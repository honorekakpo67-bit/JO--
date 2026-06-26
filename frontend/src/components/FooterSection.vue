<script setup lang="ts">

</script>

<template>
  <footer class="ft">
    <div class="ft-inner">
      <div class="ft-row">
        <div class="ft-col">
          <h4>1xBet</h4>
          <p class="ft-desc">Application mobile</p>
          <button class="ft-app">Android</button>
          <button class="ft-app">iOS</button>
        </div>
        <div class="ft-col">
          <h4>Informations</h4>
          <a href="#">Qui sommes-nous ?</a>
          <a href="#">Conditions générales</a>
          <a href="#">Programme d'affiliation</a>
          <a href="#">Politique de Confidentialité</a>
          <a href="#">Politique des Cookies</a>
          <a href="#">Contacts</a>
        </div>
        <div class="ft-col">
          <h4>Paris</h4>
          <a href="#">Avant-match</a>
          <a href="#">MULTIPLEX</a>
          <a href="#">En direct</a>
          <a href="#">Toto</a>
          <h4 style="margin-top:12px">Jeux</h4>
          <a href="#">Casino</a>
          <a href="#">1xGames</a>
          <a href="#">Casino En direct</a>
        </div>
        <div class="ft-col">
          <h4>Liens utiles</h4>
          <a href="#">Modes de paiement</a>
          <a href="#">Version mobile</a>
          <a href="#">Inscription</a>
          <h4 style="margin-top:12px">Applis</h4>
          <a href="#">IOS</a>
          <a href="#">Android</a>
          <a href="#">Autres applis</a>
        </div>
        <div class="ft-col">
          <h4>Partenaires</h4>
          <div class="ft-partner">FC Barcelone</div>
          <div class="ft-partner">Paris Saint-Germain</div>
          <div class="ft-partner">Serie A TIM</div>
          <div class="ft-partner">Volleyball World</div>
        </div>
      </div>

      <div class="ft-legal">
        <p>1xbet.bj est géré par la société VLOTUMIX SAS</p>
        <p>Copyright © 2026 «1xBet».</p>
        <div class="ft-meta">
          <span>Assistance: +229 01-53-03-00-96</span>
          <span class="ft-18">18+</span>
        </div>
      </div>
    </div>
  </footer>
</template>

<style scoped>
.ft {
  background: hsl(208, 62%, 18%);
  color: rgba(255,255,255,0.7);
  margin-top: 20px;
  padding: 24px 10px 12px;
}

.ft-inner {
  max-width: 1440px;
  margin: 0 auto;
}

.ft-row {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
  gap: 16px;
  margin-bottom: 20px;
}

.ft-col {
  display: flex;
  flex-direction: column;
}

.ft-col h4 {
  font-size: 12px;
  font-weight: 700;
  color: #fff;
  margin-bottom: 8px;
  text-transform: uppercase;
}

.ft-desc {
  font-size: 11px;
  color: rgba(255,255,255,0.4);
  margin-bottom: 6px;
}

.ft-app {
  font-size: 11px;
  padding: 6px 10px;
  background: rgba(255,255,255,0.08);
  color: #fff;
  border-radius: 3px;
  margin-bottom: 4px;
  text-align: left;
}

.ft-app:hover { background: rgba(255,255,255,0.15); }

.ft-col a {
  font-size: 11px;
  color: rgba(255,255,255,0.5);
  line-height: 1.8;
}

.ft-col a:hover { color: #fff; }

.ft-partner {
  font-size: 11px;
  padding: 4px 6px;
  background: rgba(255,255,255,0.05);
  border-radius: 3px;
  margin-bottom: 4px;
}

.ft-legal {
  border-top: 1px solid rgba(255,255,255,0.08);
  padding-top: 10px;
  font-size: 10px;
  color: rgba(255,255,255,0.3);
  line-height: 1.6;
}

.ft-meta {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-top: 4px;
}

.ft-18 {
  background: var(--live-red);
  color: #fff;
  padding: 1px 4px;
  border-radius: 2px;
  font-weight: 700;
  font-size: 9px;
}
</style>
