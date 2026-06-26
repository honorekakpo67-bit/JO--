#!/usr/bin/env bash
set -euo pipefail

VPS_IP="72.62.28.185"
VPS_USER="root"
IMAGE_NAME="frontend"
TAG="latest"
SSH_KEY="$HOME/.ssh/id_ed25519"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "==> 1/6  Vérification de la clé SSH..."
if [ ! -f "$SSH_KEY" ]; then
  echo "  Génération d'une clé SSH..."
  ssh-keygen -t ed25519 -f "$SSH_KEY" -N "" -C "deploy-frontend"
  echo "  Copie de la clé sur le VPS (mot de passe requis)..."
  ssh-copy-id "$VPS_USER@$VPS_IP"
fi

echo "==> 2/6  Build de l'image Docker..."
docker build -t "$IMAGE_NAME:$TAG" .

echo "==> 3/6  Export de l'image..."
docker save -o "/tmp/${IMAGE_NAME}_${TIMESTAMP}.tar" "$IMAGE_NAME:$TAG"

echo "==> 4/6  Envoi de l'image sur le VPS..."
scp -i "$SSH_KEY" "/tmp/${IMAGE_NAME}_${TIMESTAMP}.tar" "$VPS_USER@$VPS_IP:/tmp/"

echo "==> 5/6  Déploiement sur le VPS..."
ssh -i "$SSH_KEY" "$VPS_USER@$VPS_IP" \
  "set -euo pipefail
   echo '  Chargement de l'\''image...'
   docker load -i /tmp/${IMAGE_NAME}_${TIMESTAMP}.tar

   echo '  Arrêt de l'\''ancien conteneur (conservé pour rollback)...'
   docker stop frontend 2>/dev/null || true

   echo '  Lancement du nouveau conteneur...'
   docker run -d \
     --name frontend-new \
     -p 81:80 \
     --restart unless-stopped \
     ${IMAGE_NAME}:${TAG}

   echo '  Vérification de la santé (timeout: 10s)...'
   HEALTHY=false
   for i in \$(seq 1 10); do
     sleep 1
     HTTP_CODE=\$(curl -s -o /dev/null -w '%{http_code}' http://localhost:81/ || echo '000')
     if [ \"\$HTTP_CODE\" = '200' ] || [ \"\$HTTP_CODE\" = '302' ]; then
       HEALTHY=true
       break
     fi
     echo '    Tentative' \$i '/ 10 — code:' \$HTTP_CODE
   done

   if [ \"\$HEALTHY\" = true ]; then
     echo '  ✅ Nouveau conteneur OK — suppression de l'\''ancien...'
     docker rm frontend 2>/dev/null || true
     docker rename frontend-new frontend
   else
     echo '  ❌ Échec — restauration de l'\''ancien conteneur...'
     docker stop frontend-new
     docker rm frontend-new
     docker start frontend 2>/dev/null || true
     echo '  ⚠️  Déploiement annulé, ancienne version restaurée'
     exit 1
   fi

   echo '  Nettoyage de l'\''archive sur le VPS...'
   rm -f /tmp/${IMAGE_NAME}_${TIMESTAMP}.tar"

echo "==> 6/6  Nettoyage local..."
rm -f "/tmp/${IMAGE_NAME}_${TIMESTAMP}.tar"

echo ""
echo "✅  Déploiement terminé !"
echo "    Accès : http://$VPS_IP:81"
