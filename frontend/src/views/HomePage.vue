<script setup lang="ts">
import { ref, onMounted, nextTick, computed } from 'vue'
import { useRouter } from 'vue-router'
import MobileBottomNav from '../components/MobileBottomNav.vue'

const router = useRouter()
const baseUrl = import.meta.env.VITE_APP_BASE_URL || 'http://72.62.28.185:81'

const headerHtml = ref('')
const bodyHtml = ref('')
const footerHtml = ref('')
const loading = ref(true)
const error = ref<string | null>(null)

// Modals
const showSettingsSidebar = ref(false)
const showLanguageModal = ref(false)
const showBonusModal = ref(false)
const selectedLanguage = ref('FR')
const selectedTimezone = ref('UTC+01:00')
const searchQuery = ref('')
const activeTab = ref('language')

function replaceUrls(html: string): string {
  return html
    .replace(/https:\/\/1xbet\.bj\/fr/g, baseUrl)
    .replace(/https:\/\/1xbet\.bj/g, baseUrl)
    .replace(/https:\/\/partners1xbet\.com/g, baseUrl)
    .replace(/https:\/\/instagram\.com\/1xbet\.bj/g, baseUrl + '/instagram')
}

// ── NAVIGATION ──────────────────────────────────────────────
function goToLogin(e: Event) {
  e.preventDefault()
  e.stopPropagation()
  router.push('/login')
}

function goToRegistration(e: Event) {
  e.preventDefault()
  e.stopPropagation()
  router.push('/registration')
}

function goToDepositPage(e: Event) {
  e.preventDefault()
  e.stopPropagation()
  window.location.href = '/deposit.html'
}

function closeBonusModal() {
  showBonusModal.value = false
}

function bindNavButtons() {
  // INSCRIPTION
  document.querySelectorAll<HTMLElement>('button, a, .ui-button').forEach(el => {
    const text = el.textContent?.trim() || ''
    if (text === 'INSCRIPTION' || text === "S'inscrire" || text === 'Inscription' || text.includes("s'inscrire")) {
      el.onclick = goToRegistration
      el.style.cursor = 'pointer'
    }
    if (text === 'SE CONNECTER' || text === 'Connexion' || text === 'Se connecter' || text.includes('se connecter')) {
      el.onclick = goToLogin
      el.style.cursor = 'pointer'
    }
  })

  // DOLLAR → dépôt
  document.querySelectorAll<HTMLElement>('[data-v-ico="common|dollar-sign"], .user-control-dashboard-payment, [class*="dollar"]').forEach(el => {
    const btn = el.closest<HTMLElement>('button, a, span, div') || el
    btn.onclick = goToDepositPage
    btn.style.cursor = 'pointer'
    btn.setAttribute('title', 'Effectuer un dépôt')
  })

  // SETTINGS
  document.querySelectorAll<HTMLElement>('[data-v-ico="common|settings"], [class*="settings"]').forEach(el => {
    const btn = el.closest<HTMLElement>('button, a') || el
    btn.onclick = (e) => { e.preventDefault(); e.stopPropagation(); showSettingsSidebar.value = true }
    btn.style.cursor = 'pointer'
  })

  // LANGUE
  document.querySelectorAll<HTMLElement>('.app-settings-toolbar-dropdown__trigger, .app-settings-toolbar-panel, [data-v-ico*="lang_"]').forEach(el => {
    el.onclick = (e) => { e.preventDefault(); e.stopPropagation(); showLanguageModal.value = true }
    el.style.cursor = 'pointer'
    el.setAttribute('title', 'Langue et fuseau horaire')
  })

  // BONUS
  document.querySelectorAll<HTMLElement>('[data-v-ico="common|bonus"], [class*="bonus"]').forEach(el => {
    const btn = el.closest<HTMLElement>('button, a, span, div') || el
    btn.onclick = (e) => { e.preventDefault(); e.stopPropagation(); showBonusModal.value = true }
    btn.style.cursor = 'pointer'
    btn.setAttribute('title', 'Bonus')
  })
}

// ── FUSEAUX HORAIRES ────────────────────────────────────────
const timezones = [
  { label: 'Baker (île), Howland (île)', value: 'UTC-12:00' },
  { label: 'Hawaii, Rarotonga, Tahiti', value: 'UTC-10:00' },
  { label: 'Los Angeles, Vancouver', value: 'UTC-07:00' },
  { label: 'Chicago, Guatemala', value: 'UTC-06:00' },
  { label: 'Bogota, New York, Lima', value: 'UTC-05:00' },
  { label: 'Londres, Lisbonne, Casablanca', value: 'UTC+00:00' },
  { label: 'Paris, Berlin, Rome, Lagos', value: 'UTC+01:00' },
  { label: 'Athènes, Le Caire, Helsinki', value: 'UTC+02:00' },
  { label: 'Moscou, Nairobi, Bagdad', value: 'UTC+03:00' },
  { label: 'Dubaï, Bakou', value: 'UTC+04:00' },
  { label: 'Bangkok, Jakarta', value: 'UTC+07:00' },
  { label: 'Pékin, Singapour', value: 'UTC+08:00' },
  { label: 'Tokyo, Séoul', value: 'UTC+09:00' },
  { label: 'Sydney, Melbourne', value: 'UTC+10:00' },
  { label: 'Auckland, Fidji', value: 'UTC+12:00' },
]

const filteredTimezones = computed(() => {
  if (!searchQuery.value) return timezones
  const q = searchQuery.value.toLowerCase()
  return timezones.filter(tz => tz.label.toLowerCase().includes(q) || tz.value.toLowerCase().includes(q))
})

onMounted(async () => {
  try {
    const [headerRes, bodyRes, footerRes] = await Promise.all([
      fetch('/assets/1xbet-header.html'),
      fetch('/assets/1xbet-body.html'),
      fetch('/assets/1xbet-footer.html'),
    ])
    if (!headerRes.ok) throw new Error(`header HTTP ${headerRes.status}`)
    if (!bodyRes.ok) throw new Error(`body HTTP ${bodyRes.status}`)
    if (!footerRes.ok) throw new Error(`footer HTTP ${footerRes.status}`)
    headerHtml.value = replaceUrls(await headerRes.text())
    bodyHtml.value = replaceUrls(await bodyRes.text())
    footerHtml.value = replaceUrls(await footerRes.text())

    await nextTick()
    bindNavButtons()
    setTimeout(bindNavButtons, 500)
    setTimeout(bindNavButtons, 1000)

  } catch (e) {
    error.value = (e as Error).message
  } finally {
    loading.value = false
  }
})
</script>

<template>
  <div v-if="loading" style="padding:2rem;text-align:center">Chargement...</div>
  <div v-else-if="error" style="padding:2rem;text-align:center;color:red">Erreur : {{ error }}</div>
  <div v-else class="app-shell">
    <div v-html="headerHtml" />
    <div class="layout-content__app" data-v-52580f63>
      <div v-html="bodyHtml" />
    </div>
    <div v-html="footerHtml" />
    <MobileBottomNav />
  </div>

  <!-- BONUS MODAL -->
  <Teleport to="body">
    <div v-if="showBonusModal" class="overlay center" @click="closeBonusModal">
      <div class="bonus-modal" @click.stop>
        <button class="modal-close-top" @click="closeBonusModal">✕</button>
        <div class="bonus-body">
          <h2>Bonus de 200 % sur le premier dépôt</h2>
          <p>jusqu'à 250 000 XOF</p>
        </div>
        <div class="bonus-footer">
          <button class="btn-save" @click="goToDepositPage">EFFECTUER UN DÉPÔT</button>
        </div>
      </div>
    </div>
  </Teleport>

  <!-- SETTINGS SIDEBAR -->
  <Teleport to="body">
    <div v-if="showSettingsSidebar" class="overlay" @click="showSettingsSidebar=false">
      <div class="settings-sidebar" @click.stop>
        <div class="modal-header">
          <span>⚙️ Paramètres</span>
          <button @click="showSettingsSidebar=false">✕</button>
        </div>
        <div class="settings-body">
          <div class="s-group">
            <label class="s-label">FORMAT DES COTES</label>
            <div class="s-options">
              <button class="s-opt active">Décimal (2.2)</button>
              <button class="s-opt">Fractionnaire</button>
              <button class="s-opt">Américain</button>
              <button class="s-opt">Hong Kong</button>
              <button class="s-opt">Indonésien</button>
              <button class="s-opt">Malaisien</button>
            </div>
          </div>
          <div class="s-group">
            <label class="s-label">AFFICHAGE DES MARCHÉS</label>
            <div class="s-radios">
              <label><input type="radio" name="m" checked> Complet</label>
              <label><input type="radio" name="m"> Abrégé</label>
            </div>
          </div>
          <div class="s-group">
            <label class="s-label">OPTIONS</label>
            <div class="s-checks">
              <label><input type="checkbox" checked> Pari combiné EN DIRECT</label>
              <label><input type="checkbox" checked> Pari Combiné du Jour</label>
              <label><input type="checkbox" checked> Stats dans nouvelle fenêtre</label>
              <label><input type="checkbox" checked> Déplacer vidéo au scroll</label>
              <label><input type="checkbox"> Afficher l'ID du jeu</label>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button class="btn-save" @click="showSettingsSidebar=false">ENREGISTRER</button>
        </div>
      </div>
    </div>
  </Teleport>

  <!-- LANGUE MODAL -->
  <Teleport to="body">
    <div v-if="showLanguageModal" class="overlay center" @click="showLanguageModal=false">
      <div class="lang-modal" @click.stop>
        <div class="lang-modal-header">
          <span>🌐 Langue / Fuseau horaire</span>
          <button class="lang-close" @click="showLanguageModal=false">✕</button>
        </div>
        <div class="lang-tabs-bar">
          <button :class="['lang-tab', activeTab==='language'&&'active']" @click="activeTab='language'">Langue</button>
          <button :class="['lang-tab', activeTab==='timezone'&&'active']" @click="activeTab='timezone'">Fuseau horaire</button>
        </div>
        <div class="lang-body">
          <div v-if="activeTab==='language'" class="lang-list">
            <button :class="['lang-item', selectedLanguage==='EN'&&'active']" @click="selectedLanguage='EN'">
              <span class="lang-flag">🇬🇧</span>
              <strong>EN</strong>
              <span>English</span>
              <span v-if="selectedLanguage==='EN'" class="lang-check">✓</span>
            </button>
            <button :class="['lang-item', selectedLanguage==='FR'&&'active']" @click="selectedLanguage='FR'">
              <span class="lang-flag">🇫🇷</span>
              <strong>FR</strong>
              <span>Français</span>
              <span v-if="selectedLanguage==='FR'" class="lang-check">✓</span>
            </button>
          </div>
          <div v-else>
            <input v-model="searchQuery" class="tz-search" placeholder="Rechercher un fuseau horaire…">
            <div class="tz-list">
              <button v-for="tz in filteredTimezones" :key="tz.value"
                :class="['tz-item', selectedTimezone===tz.value&&'active']"
                @click="selectedTimezone=tz.value">
                <span class="tz-label">{{ tz.label }}</span>
                <span class="tz-val">{{ tz.value }}</span>
                <span v-if="selectedTimezone===tz.value" class="tz-check">✓</span>
              </button>
            </div>
          </div>
        </div>
        <div class="lang-modal-footer">
          <button class="btn-save" @click="showLanguageModal=false">ENREGISTRER</button>
        </div>
      </div>
    </div>
  </Teleport>
</template>

<style>
.app-shell {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

/* ── OVERLAYS ────────────────────────────────────────────── */
.overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.7);
  z-index: 9999;
  display: flex;
  justify-content: flex-end;
  animation: fadeIn 0.25s;
}
.overlay.center {
  justify-content: center;
  align-items: center;
}
@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

/* ── BONUS MODAL ──────────────────────────────────────────── */
.bonus-modal {
  position: relative;
  width: 420px;
  max-width: 92%;
  background: #ffffff;
  border-radius: 16px;
  overflow: hidden;
  padding-bottom: 24px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
}
.bonus-body {
  padding: 32px 24px 16px;
  text-align: center;
}
.bonus-body h2 {
  font-size: 22px;
  font-weight: 700;
  color: #1a1a2e;
  margin-bottom: 8px;
}
.bonus-body p {
  font-size: 18px;
  color: #4a5a72;
}
.bonus-footer {
  padding: 0 24px;
}
.modal-close-top {
  position: absolute;
  top: 12px;
  right: 16px;
  background: none;
  border: none;
  font-size: 22px;
  color: #8a9bb5;
  cursor: pointer;
  z-index: 1;
}
.modal-close-top:hover {
  color: #1a1a2e;
}
.btn-save {
  width: 100%;
  padding: 14px;
  background: #2563eb;
  color: #ffffff;
  border: none;
  border-radius: 8px;
  font-size: 14px;
  font-weight: 700;
  text-transform: uppercase;
  cursor: pointer;
  transition: background 0.2s;
}
.btn-save:hover {
  background: #1d4ed8;
}

/* ── SETTINGS ─────────────────────────────────────────────── */
.settings-sidebar {
  width: 420px;
  max-width: 92%;
  height: 100%;
  background: #ffffff;
  display: flex;
  flex-direction: column;
  animation: slideIn 0.3s;
  overflow-y: auto;
}
@keyframes slideIn {
  from { transform: translateX(100%); }
  to { transform: translateX(0); }
}
.settings-body {
  flex: 1;
  padding: 24px;
  overflow-y: auto;
}
.s-group {
  margin-bottom: 24px;
}
.s-label {
  display: block;
  font-size: 11px;
  font-weight: 700;
  color: #8a9bb5;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  margin-bottom: 10px;
}
.s-options {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}
.s-opt {
  padding: 6px 14px;
  border: 1px solid #e8ecf1;
  border-radius: 4px;
  background: #ffffff;
  color: #4a5a72;
  font-size: 13px;
  cursor: pointer;
  transition: all 0.15s;
}
.s-opt.active {
  background: #2563eb;
  border-color: #2563eb;
  color: #ffffff;
  font-weight: 600;
}
.s-radios {
  display: flex;
  gap: 24px;
}
.s-radios label,
.s-checks label {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
  color: #1a1a2e;
  cursor: pointer;
}
.s-checks {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

/* ── LANGUE MODAL ─────────────────────────────────────────── */
.lang-modal {
  width: 460px;
  max-width: 94%;
  max-height: 90vh;
  background: #ffffff;
  border-radius: 16px;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
}
.lang-modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 18px 24px;
  border-bottom: 1px solid #e8ecf1;
  background: #ffffff;
}
.lang-modal-header span {
  font-size: 18px;
  font-weight: 700;
  color: #1a1a2e;
}
.lang-close {
  background: none;
  border: none;
  font-size: 22px;
  color: #8a9bb5;
  cursor: pointer;
  padding: 4px 8px;
}
.lang-close:hover {
  color: #1a1a2e;
}
.lang-tabs-bar {
  display: flex;
  padding: 4px;
  background: #f5f6fa;
  margin: 16px 20px 12px 20px;
  border-radius: 8px;
}
.lang-tab {
  flex: 1;
  padding: 10px;
  border: none;
  background: transparent;
  font-size: 14px;
  font-weight: 600;
  color: #4a5a72;
  cursor: pointer;
  border-radius: 6px;
  transition: all 0.2s;
}
.lang-tab.active {
  background: #2563eb;
  color: #ffffff;
}
.lang-tab:hover:not(.active) {
  background: #e8ecf1;
}
.lang-body {
  flex: 1;
  padding: 0 20px 16px 20px;
  overflow-y: auto;
}
.lang-list {
  display: flex;
  flex-direction: column;
  gap: 6px;
}
.lang-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px 16px;
  border: 2px solid transparent;
  border-radius: 8px;
  background: #f8f9fc;
  cursor: pointer;
  font-size: 15px;
  text-align: left;
  width: 100%;
  transition: all 0.2s;
}
.lang-item:hover {
  background: #f0f7ff;
  border-color: #e8ecf1;
}
.lang-item.active {
  background: #eff6ff;
  border-color: #2563eb;
}
.lang-flag {
  font-size: 22px;
}
.lang-item strong {
  min-width: 36px;
  color: #1a1a2e;
}
.lang-item span {
  color: #4a5a72;
}
.lang-check {
  margin-left: auto;
  color: #2563eb;
  font-size: 18px;
  font-weight: 700;
}
.tz-search {
  width: 100%;
  padding: 10px 14px;
  border: 2px solid #e8ecf1;
  border-radius: 8px;
  font-size: 14px;
  outline: none;
  background: #f8f9fc;
  color: #1a1a2e;
  margin-bottom: 10px;
}
.tz-search:focus {
  border-color: #2563eb;
}
.tz-search::placeholder {
  color: #b0b8c4;
}
.tz-list {
  max-height: 280px;
  overflow-y: auto;
  border: 1px solid #e8ecf1;
  border-radius: 8px;
  background: #ffffff;
}
.tz-item {
  display: flex;
  align-items: center;
  gap: 8px;
  width: 100%;
  padding: 10px 14px;
  border: none;
  border-bottom: 1px solid #f5f6fa;
  background: #ffffff;
  font-size: 13px;
  cursor: pointer;
  text-align: left;
  transition: background 0.15s;
  color: #1a1a2e;
}
.tz-item:hover {
  background: #f5f6fa;
}
.tz-item.active {
  background: #eff6ff;
  border-left: 3px solid #2563eb;
}
.tz-label {
  flex: 1;
  color: #1a1a2e;
}
.tz-val {
  font-size: 11px;
  color: #8a9bb5;
  font-weight: 600;
}
.tz-check {
  color: #2563eb;
  font-size: 14px;
  font-weight: 700;
  margin-left: 8px;
}
.lang-modal-footer {
  padding: 16px 24px;
  border-top: 1px solid #e8ecf1;
  background: #ffffff;
}
.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  border-bottom: 1px solid #e8ecf1;
  font-size: 16px;
  font-weight: 700;
  color: #1a1a2e;
}
.modal-header button {
  background: none;
  border: none;
  font-size: 20px;
  color: #8a9bb5;
  cursor: pointer;
}
.modal-header button:hover {
  color: #1a1a2e;
}
.modal-footer {
  padding: 16px 20px;
  border-top: 1px solid #e8ecf1;
}
</style>