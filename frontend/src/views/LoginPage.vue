<script setup lang="ts">
import { ref } from 'vue'

const loginMethod = ref<'email' | 'id'>('email')
const identifier  = ref('')
const password    = ref('')
const showPass    = ref(false)
const loading     = ref(false)
const error       = ref('')

async function submit() {
  error.value = ''
  if (!identifier.value || !password.value) {
    error.value = 'Veuillez remplir tous les champs'
    return
  }
  loading.value = true
  await new Promise(r => setTimeout(r, 1000))
  loading.value = false
  // Ici appel API login
  alert('Connexion réussie !')
}
</script>

<template>
  <div class="login-overlay">
    <div class="login-modal">

      <!-- Header -->
      <div class="login-header">
        <div class="login-logo">1<span>X</span>BET</div>
        <button class="login-close" @click="$router.push('/')">✕</button>
      </div>

      <div class="login-body">
        <h2 class="login-title">SE CONNECTER</h2>

        <!-- Toggle Email / ID -->
        <div class="login-toggle">
          <button
            :class="['toggle-btn', loginMethod === 'email' && 'active']"
            @click="loginMethod = 'email'"
          >✉️ E-mail</button>
          <button
            :class="['toggle-btn', loginMethod === 'id' && 'active']"
            @click="loginMethod = 'id'"
          >🆔 ID du compte</button>
        </div>

        <form class="login-form" @submit.prevent="submit">

          <!-- Identifiant -->
          <div class="login-field">
            <label>{{ loginMethod === 'email' ? 'Adresse e-mail' : 'ID du compte' }}</label>
            <input
              v-model="identifier"
              :type="loginMethod === 'email' ? 'email' : 'text'"
              :placeholder="loginMethod === 'email' ? 'votre@email.com' : 'Votre ID numérique'"
              autocomplete="username"
            />
          </div>

          <!-- Mot de passe -->
          <div class="login-field">
            <label>Mot de passe</label>
            <div class="pass-wrap">
              <input
                v-model="password"
                :type="showPass ? 'text' : 'password'"
                placeholder="••••••••"
                autocomplete="current-password"
              />
              <button type="button" class="pass-eye" @click="showPass = !showPass">
                {{ showPass ? '🙈' : '👁' }}
              </button>
            </div>
          </div>

          <!-- Erreur -->
          <p v-if="error" class="login-error">⚠️ {{ error }}</p>

          <!-- Oublié -->
          <div class="login-forgot">
            <a href="#">Mot de passe oublié ?</a>
          </div>

          <!-- Submit -->
          <button type="submit" class="login-submit" :disabled="loading">
            <span v-if="loading" class="btn-spinner"></span>
            {{ loading ? 'Connexion…' : 'SE CONNECTER' }}
          </button>

          <!-- Séparateur -->
          <div class="login-sep"><span>ou</span></div>

          <!-- Réseaux sociaux -->
          <div class="login-socials">
            <button type="button" class="soc-btn google">🌐 Google</button>
            <button type="button" class="soc-btn facebook">📘 Facebook</button>
            <button type="button" class="soc-btn telegram">✈️ Telegram</button>
          </div>

        </form>

        <p class="login-register">
          Pas encore inscrit ?
          <a @click="$router.push('/register')">S'inscrire</a>
        </p>
      </div>

    </div>
  </div>
</template>

<style scoped>
.login-overlay {
  min-height: 100vh;
  background: rgba(0,0,0,0.75);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 20px;
  backdrop-filter: blur(4px);
}

.login-modal {
  background: #fff;
  border-radius: 14px;
  width: 100%;
  max-width: 420px;
  overflow: hidden;
  box-shadow: 0 24px 64px rgba(0,0,0,0.45);
}

/* Header */
.login-header {
  background: #1a3a5c;
  padding: 16px 20px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.login-logo {
  font-size: 1.6rem;
  font-weight: 900;
  color: #fff;
  letter-spacing: -1px;
}
.login-logo span { color: #e8a838; }
.login-close {
  background: none; border: none;
  color: #fff; font-size: 1.1rem;
  cursor: pointer; opacity: .7;
  transition: opacity .2s;
}
.login-close:hover { opacity: 1; }

/* Body */
.login-body { padding: 24px; }

.login-title {
  text-align: center;
  font-size: 1.1rem;
  font-weight: 800;
  color: #1a3a5c;
  letter-spacing: 2px;
  margin-bottom: 18px;
}

/* Toggle */
.login-toggle {
  display: flex;
  gap: 8px;
  margin-bottom: 20px;
  background: #f0f4f8;
  padding: 4px;
  border-radius: 8px;
}
.toggle-btn {
  flex: 1;
  padding: 9px 12px;
  border: none;
  background: none;
  border-radius: 6px;
  font-size: 0.85rem;
  font-weight: 600;
  color: #666;
  cursor: pointer;
  transition: all .2s;
}
.toggle-btn.active {
  background: #fff;
  color: #1a3a5c;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

/* Form */
.login-form { display: flex; flex-direction: column; gap: 14px; }

.login-field { display: flex; flex-direction: column; gap: 5px; }
.login-field label {
  font-size: 0.78rem;
  font-weight: 600;
  color: #555;
}
.login-field input {
  width: 100%;
  padding: 11px 14px;
  border: 1.5px solid #d0d7e2;
  border-radius: 8px;
  font-size: 0.9rem;
  color: #222;
  outline: none;
  transition: border-color .2s;
}
.login-field input:focus { border-color: #1a3a5c; }

.pass-wrap { position: relative; display: flex; }
.pass-wrap input { padding-right: 42px; }
.pass-eye {
  position: absolute; right: 12px; top: 50%;
  transform: translateY(-50%);
  background: none; border: none;
  cursor: pointer; font-size: 1rem; color: #888;
}

.login-error {
  background: #fff3f3;
  color: #e53935;
  padding: 8px 12px;
  border-radius: 6px;
  font-size: 0.82rem;
  border: 1px solid #ffcdd2;
}

.login-forgot { text-align: right; }
.login-forgot a {
  font-size: 0.8rem;
  color: #1a73e8;
  text-decoration: none;
}
.login-forgot a:hover { text-decoration: underline; }

.login-submit {
  width: 100%;
  padding: 13px;
  background: linear-gradient(90deg, #1a3a5c, #1e4d7b);
  color: #fff;
  border: none;
  border-radius: 8px;
  font-size: 0.95rem;
  font-weight: 700;
  letter-spacing: 1px;
  cursor: pointer;
  transition: opacity .2s;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}
.login-submit:hover { opacity: 0.9; }
.login-submit:disabled { opacity: 0.6; cursor: not-allowed; }

.btn-spinner {
  width: 16px; height: 16px;
  border: 2px solid rgba(255,255,255,.3);
  border-top-color: #fff;
  border-radius: 50%;
  animation: spin .7s linear infinite;
  display: inline-block;
}
@keyframes spin { to { transform: rotate(360deg); } }

/* Séparateur */
.login-sep {
  text-align: center;
  position: relative;
  color: #aaa;
  font-size: 0.8rem;
}
.login-sep::before, .login-sep::after {
  content: '';
  position: absolute;
  top: 50%;
  width: 42%;
  height: 1px;
  background: #e0e0e0;
}
.login-sep::before { left: 0; }
.login-sep::after  { right: 0; }

/* Réseaux sociaux */
.login-socials { display: flex; gap: 8px; }
.soc-btn {
  flex: 1;
  padding: 10px 6px;
  border: none;
  border-radius: 8px;
  font-size: 0.78rem;
  font-weight: 600;
  cursor: pointer;
  transition: opacity .2s;
}
.soc-btn:hover { opacity: 0.85; }
.google   { background: #fff; border: 1px solid #ddd; color: #333; }
.facebook { background: #1877f2; color: #fff; }
.telegram { background: #229ed9; color: #fff; }

.login-register {
  text-align: center;
  margin-top: 18px;
  font-size: 0.85rem;
  color: #666;
}
.login-register a {
  color: #1a3a5c;
  font-weight: 700;
  cursor: pointer;
  text-decoration: underline;
}

/* Responsive */
@media (max-width: 480px) {
  .login-overlay { padding: 0; align-items: flex-start; }
  .login-modal { border-radius: 0; min-height: 100vh; }
  .login-socials { flex-direction: column; }
}
</style>
