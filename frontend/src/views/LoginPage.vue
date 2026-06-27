<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import MobileBottomNav from '../components/MobileBottomNav.vue'

const router = useRouter()
type LoginMethod = 'email' | 'phone' | 'code' | 'social'

const method     = ref<LoginMethod>('email')
const identifier = ref('')
const password   = ref('')
const remember   = ref(true)
const showPass   = ref(false)
const loading    = ref(false)
const errMsg     = ref('')

async function submit() {
  errMsg.value = ''
  if (!identifier.value || (!password.value && method.value !== 'code')) {
    errMsg.value = 'Veuillez remplir tous les champs'
    return
  }
  loading.value = true
  await new Promise(r => setTimeout(r, 900))
  loading.value = false
  router.push('/')
}
</script>

<template>
  <div class="lp-page">

    <!-- Header barre -->
    <div class="lp-header">
      <button class="lp-back" @click="router.push('/')">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" width="16" height="16">
          <path d="M19 12H5M12 5l-7 7 7 7"/>
        </svg>
      </button>
      <span class="lp-header-title">SE CONNECTER</span>
    </div>

    <!-- Onglets méthode - ICÔNES RÉDUITES -->
    <div class="lp-tabs">
      <button :class="['lp-tab', method==='email' && 'lp-tab--active']" @click="method='email'">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="16" height="16">
          <rect x="2" y="4" width="20" height="16" rx="2"/>
          <path d="M2 7l10 7 10-7"/>
        </svg>
        <span>Par e-mail</span>
      </button>
      <button :class="['lp-tab', method==='phone' && 'lp-tab--active']" @click="method='phone'">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="16" height="16">
          <rect x="7" y="2" width="10" height="20" rx="2"/>
          <circle cx="12" cy="18" r="1" fill="currentColor"/>
        </svg>
        <span>Par téléphone</span>
      </button>
      <button :class="['lp-tab', method==='code' && 'lp-tab--active']" @click="method='code'">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="16" height="16">
          <path d="M21 15a2 2 0 01-2 2H7l-4 4V5a2 2 0 012-2h14a2 2 0 012 2z"/>
          <circle cx="12" cy="10" r="1" fill="currentColor"/>
          <circle cx="8" cy="10" r="1" fill="currentColor"/>
          <circle cx="16" cy="10" r="1" fill="currentColor"/>
        </svg>
        <span>Par code</span>
      </button>
      <button :class="['lp-tab', method==='social' && 'lp-tab--active']" @click="method='social'">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="16" height="16">
          <path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/>
          <circle cx="9" cy="7" r="4"/>
          <path d="M23 21v-2a4 4 0 00-3-3.87"/>
          <path d="M16 3.13a4 4 0 010 7.75"/>
        </svg>
        <span>Réseaux sociaux</span>
      </button>
    </div>

    <!-- Séparateur -->
    <div class="lp-sep"></div>

    <!-- Formulaire -->
    <form v-if="method !== 'social'" class="lp-form" @submit.prevent="submit">

      <div class="lp-field">
        <input
          v-model="identifier"
          :type="method === 'phone' ? 'tel' : 'text'"
          :placeholder="method === 'email' ? 'E-mail ou ID*' : method === 'phone' ? 'Numéro de téléphone*' : 'Code de connexion*'"
          class="lp-input"
          autocomplete="username"
        />
      </div>

      <div v-if="method !== 'code'" class="lp-field lp-field--pass">
        <input
          v-model="password"
          :type="showPass ? 'text' : 'password'"
          placeholder="Mot de passe*"
          class="lp-input"
          autocomplete="current-password"
        />
        <button type="button" class="lp-eye" @click="showPass = !showPass">
          <svg v-if="!showPass" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="18" height="18">
            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
            <circle cx="12" cy="12" r="3"/>
            <line x1="2" y1="2" x2="22" y2="22" stroke-width="2.5"/>
          </svg>
          <svg v-else viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="18" height="18">
            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
            <circle cx="12" cy="12" r="3"/>
          </svg>
        </button>
      </div>

      <label v-if="method !== 'code'" class="lp-remember">
        <input v-model="remember" type="checkbox" class="lp-cb-input" />
        <span class="lp-cb-box">
          <svg v-if="remember" viewBox="0 0 12 12" fill="none" stroke="#fff" stroke-width="2" width="10" height="10">
            <path d="M2 6l3 3 5-5"/>
          </svg>
        </span>
        <span>Mémoriser mes informations</span>
      </label>

      <p v-if="errMsg" class="lp-error">{{ errMsg }}</p>

      <button type="submit" class="lp-submit" :disabled="loading">
        <span v-if="loading" class="lp-spinner"></span>
        <span v-else>{{ method === 'code' ? 'ENVOYER LE CODE' : 'SE CONNECTER' }}</span>
      </button>

      <p class="lp-forgot">
        <a href="#">Mot de passe oublié ?</a>
      </p>

      <div class="lp-divider"><span>Pas encore inscrit ?</span></div>

      <button type="button" class="lp-register-btn" @click="router.push('/registration')">
        CRÉER UN COMPTE
      </button>

    </form>

    <!-- Réseaux sociaux -->
    <div v-else class="lp-form">
      <p class="lp-social-hint">Connectez-vous via</p>
      <button class="lp-social-btn">
        <svg viewBox="0 0 24 24" width="18" height="18">
          <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
          <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
          <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
          <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>
        </svg>
        Continuer avec Google
      </button>
      <button class="lp-social-btn lp-social-btn--telegram">
        <svg viewBox="0 0 24 24" width="18" height="18" fill="#229ED9">
          <path d="M12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12S18.627 0 12 0zm5.562 8.248l-2.013 9.49c-.145.658-.537.818-1.084.508l-3-2.21-1.447 1.394c-.16.16-.295.295-.605.295l.213-3.053 5.56-5.023c.242-.213-.054-.333-.373-.12L6.26 14.4l-2.95-.924c-.642-.2-.655-.642.136-.953l11.527-4.445c.535-.194 1.003.131.59.17z"/>
        </svg>
        Continuer avec Telegram
      </button>
      <button class="lp-social-btn lp-social-btn--apple">
        <svg viewBox="0 0 24 24" width="18" height="18" fill="#000">
          <path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.8-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.73M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z"/>
        </svg>
        Continuer avec Apple
      </button>

      <div class="lp-divider"><span>Pas encore inscrit ?</span></div>
      <button type="button" class="lp-register-btn" @click="router.push('/registration')">
        CRÉER UN COMPTE
      </button>
    </div>

    <MobileBottomNav />
  </div>
</template>

<style scoped>
/* ── PAGE ──────────────────────────────────────────────── */
.lp-page {
  min-height: 100vh;
  background: #eef1f5;
  display: flex;
  flex-direction: column;
  width: 100%;
  max-width: 520px;
  margin: 0 auto;
  padding-bottom: 70px;
}

/* ── HEADER ────────────────────────────────────────────── */
.lp-header {
  display: flex;
  align-items: center;
  gap: 12px;
  background: #1a3a5c;
  padding: 12px 16px;
  color: #fff;
}
.lp-back {
  background: rgba(255,255,255,.18);
  border: none;
  color: #fff;
  width: 34px;
  height: 34px;
  border-radius: 8px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  transition: background .2s;
}
.lp-back:hover { background: rgba(255,255,255,.28); }
.lp-header-title {
  font-size: .9rem;
  font-weight: 800;
  letter-spacing: 1.5px;
}

/* ── ONGLETS ───────────────────────────────────────────── */
.lp-tabs {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 6px;
  padding: 12px 10px;
  background: #fff;
}
.lp-tab {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
  padding: 8px 4px;
  border: 1.5px solid #d8dfe8;
  border-radius: 8px;
  background: #fff;
  color: #5a6a82;
  font-size: 9px;
  font-weight: 600;
  cursor: pointer;
  transition: all .2s;
  line-height: 1.2;
  text-align: center;
}
.lp-tab svg { 
  flex-shrink: 0;
  width: 16px !important;
  height: 16px !important;
}
.lp-tab span {
  font-size: 8px;
  letter-spacing: 0.3px;
}
.lp-tab--active {
  background: #1a3a5c;
  border-color: #1a3a5c;
  color: #fff;
}
.lp-tab:hover:not(.lp-tab--active) {
  border-color: #1a3a5c;
  color: #1a3a5c;
}

/* ── SÉPARATEUR ────────────────────────────────────────── */
.lp-sep {
  height: 1px;
  background: #d8dfe8;
}

/* ── FORMULAIRE ────────────────────────────────────────── */
.lp-form {
  display: flex;
  flex-direction: column;
  gap: 10px;
  padding: 16px 12px;
  flex: 1;
}

.lp-field {
  background: #fff;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 1px 3px rgba(0,0,0,.06);
}
.lp-field--pass {
  position: relative;
  display: flex;
  align-items: center;
}
.lp-input {
  width: 100%;
  padding: 14px 12px;
  border: none;
  outline: none;
  font-size: .9rem;
  color: #1a1a2e;
  background: transparent;
}
.lp-input::placeholder { color: #9ca3af; }
.lp-eye {
  position: absolute;
  right: 12px;
  background: none;
  border: none;
  cursor: pointer;
  color: #5a6a82;
  display: flex;
  align-items: center;
  padding: 4px;
  flex-shrink: 0;
}

/* ── MÉMORISER ─────────────────────────────────────────── */
.lp-remember {
  display: flex;
  align-items: center;
  gap: 10px;
  cursor: pointer;
  font-size: .85rem;
  color: #374151;
  padding: 4px 2px;
  user-select: none;
}
.lp-cb-input { display: none; }
.lp-cb-box {
  width: 20px;
  height: 20px;
  min-width: 20px;
  border: 2px solid #d1d5db;
  border-radius: 5px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #fff;
  transition: all .15s;
}
.lp-cb-input:checked ~ .lp-cb-box,
.lp-remember:has(.lp-cb-input:checked) .lp-cb-box {
  background: #1a3a5c;
  border-color: #1a3a5c;
}

/* ── ERREUR ────────────────────────────────────────────── */
.lp-error {
  background: #fff3f3;
  color: #e53935;
  padding: 8px 12px;
  border-radius: 8px;
  font-size: .8rem;
  border: 1px solid #ffcdd2;
}

/* ── BOUTON SUBMIT ─────────────────────────────────────── */
.lp-submit {
  width: 100%;
  padding: 15px;
  background: linear-gradient(135deg, #6abf2e, #4caf20);
  color: #fff;
  border: none;
  border-radius: 8px;
  font-size: .9rem;
  font-weight: 800;
  letter-spacing: 1.5px;
  cursor: pointer;
  transition: opacity .2s;
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 48px;
  margin-top: 4px;
}
.lp-submit:hover { opacity: .92; }
.lp-submit:disabled { opacity: .7; cursor: not-allowed; }
.lp-spinner {
  width: 20px; height: 20px;
  border: 2px solid rgba(255,255,255,.3);
  border-top-color: #fff;
  border-radius: 50%;
  animation: spin .7s linear infinite;
}
@keyframes spin { to { transform: rotate(360deg); } }

/* ── MOT DE PASSE OUBLIÉ ───────────────────────────────── */
.lp-forgot {
  text-align: center;
  font-size: .85rem;
  margin-top: 4px;
}
.lp-forgot a {
  color: #1a3a5c;
  text-decoration: underline;
  cursor: pointer;
}

/* ── DIVIDER ───────────────────────────────────────────── */
.lp-divider {
  display: flex;
  align-items: center;
  gap: 10px;
  margin: 4px 0;
  color: #9ca3af;
  font-size: .8rem;
}
.lp-divider::before, .lp-divider::after {
  content: '';
  flex: 1;
  height: 1px;
  background: #d8dfe8;
}

/* ── BOUTON CRÉER COMPTE ───────────────────────────────── */
.lp-register-btn {
  width: 100%;
  padding: 13px;
  background: transparent;
  color: #1a3a5c;
  border: 2px solid #1a3a5c;
  border-radius: 8px;
  font-size: .9rem;
  font-weight: 700;
  letter-spacing: 1px;
  cursor: pointer;
  transition: all .2s;
}
.lp-register-btn:hover {
  background: #1a3a5c;
  color: #fff;
}

/* ── RÉSEAUX SOCIAUX ───────────────────────────────────── */
.lp-social-hint {
  text-align: center;
  font-size: .85rem;
  color: #5a6a82;
  font-weight: 600;
}
.lp-social-btn {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 12px 16px;
  border: 1.5px solid #d8dfe8;
  border-radius: 8px;
  background: #fff;
  font-size: .85rem;
  font-weight: 600;
  cursor: pointer;
  color: #1a1a2e;
  transition: all .2s;
  box-shadow: 0 1px 3px rgba(0,0,0,.06);
}
.lp-social-btn:hover { border-color: #1a3a5c; }
.lp-social-btn--telegram { color: #229ED9; }
.lp-social-btn--apple { color: #000; }

/* ── DESKTOP ───────────────────────────────────────────── */
@media (min-width: 521px) {
  .lp-page {
    margin: 30px auto;
    min-height: auto;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 8px 40px rgba(0,0,0,.15);
    padding-bottom: 0;
  }
}

/* ── PETIT MOBILE ──────────────────────────────────────── */
@media (max-width: 480px) {
  .lp-tab { 
    padding: 6px 2px; 
    border-radius: 6px;
  }
  .lp-tab svg { 
    width: 14px !important; 
    height: 14px !important; 
  }
  .lp-tab span {
    font-size: 7px;
  }
  .lp-tabs {
    gap: 4px;
    padding: 8px 6px;
  }
  .lp-input { 
    font-size: .85rem; 
    padding: 12px 10px; 
  }
  .lp-submit { 
    font-size: .8rem; 
    padding: 13px;
    min-height: 42px;
  }
  .lp-header {
    padding: 10px 12px;
  }
  .lp-header-title {
    font-size: .8rem;
  }
  .lp-back {
    width: 30px;
    height: 30px;
  }
  .lp-back svg {
    width: 14px !important;
    height: 14px !important;
  }
}

@media (max-width: 380px) {
  .lp-tab { 
    padding: 4px 2px; 
    border-radius: 4px;
  }
  .lp-tab svg { 
    width: 12px !important; 
    height: 12px !important; 
  }
  .lp-tab span {
    font-size: 6px;
  }
  .lp-tabs {
    gap: 3px;
    padding: 6px 4px;
  }
  .lp-form {
    padding: 12px 8px;
    gap: 8px;
  }
  .lp-input { 
    font-size: .8rem; 
    padding: 10px 8px; 
  }
  .lp-submit { 
    font-size: .75rem; 
    padding: 11px;
    min-height: 38px;
  }
  .lp-register-btn {
    padding: 11px;
    font-size: .8rem;
  }
  .lp-social-btn {
    padding: 10px 12px;
    font-size: .8rem;
  }
}
</style>