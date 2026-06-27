<!-- src/views/HomePage.vue -->
<script setup lang="ts">
import { ref, onMounted, nextTick, computed, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'

const router  = useRouter()
const baseUrl = import.meta.env.VITE_APP_BASE_URL || 'http://72.62.28.185:81'

const headerHtml = ref('')
const bodyHtml   = ref('')
const footerHtml = ref('')
const loading    = ref(true)
const error      = ref<string | null>(null)

const leftCollapsed  = ref(false)
const rightCollapsed = ref(false)
const showSettings   = ref(false)
const showLang       = ref(false)
const selectedLang   = ref('FR')
const selectedTz     = ref('UTC+01:00')
const tzSearch       = ref('')
const langTab        = ref('language')

function replaceUrls(html: string): string {
  return html
    .replace(/https:\/\/1xbet\.bj\/fr/g, baseUrl)
    .replace(/https:\/\/1xbet\.bj/g, baseUrl)
    .replace(/https:\/\/partners1xbet\.com/g, baseUrl)
    .replace(/https:\/\/instagram\.com\/1xbet\.bj/g, baseUrl + '/instagram')
}

const isMobile = () => window.innerWidth <= 1023

// ── LAYOUT ──────────────────────────────────────────────────
function applyLayout() {
  const left   = document.querySelector<HTMLElement>('.layout-sidebar--left, .betting-left-aside')
  const right  = document.querySelector<HTMLElement>('.layout-sidebar--right, .betting-right-aside')
  const main   = document.querySelector<HTMLElement>('.betting-main, .betting-content__main')
  const layout = document.querySelector<HTMLElement>('.layout, .layout--has-both-sidebars, .betting-layout-app')

  if (isMobile()) {
    if (layout) layout.setAttribute('style', 'display:block!important;width:100%!important;')
    if (left)   left.setAttribute('style',   'display:none!important;')
    if (right)  right.setAttribute('style',  'display:none!important;')
    if (main)   main.setAttribute('style',   'width:100%!important;margin:0!important;display:block!important;')
    return
  }

  if (layout) layout.setAttribute('style',
    'display:flex!important;flex-direction:row!important;' +
    'width:100%!important;min-height:100vh!important;align-items:flex-start!important;'
  )
  if (left) {
    const w = leftCollapsed.value ? 48 : 250
    left.setAttribute('style',
      `width:${w}px!important;min-width:${w}px!important;max-width:${w}px!important;flex:0 0 ${w}px!important;` +
      'position:sticky!important;top:0!important;left:auto!important;right:auto!important;' +
      'align-self:flex-start!important;max-height:100vh!important;display:flex!important;' +
      'overflow-y:auto!important;overflow-x:hidden!important;background:#121c27!important;' +
      'border-right:1px solid rgba(255,255,255,.06)!important;z-index:2!important;' +
      'transition:width .3s ease!important;'
    )
  }
  if (right) {
    const w = rightCollapsed.value ? 48 : 260
    right.setAttribute('style',
      `width:${w}px!important;min-width:${w}px!important;max-width:${w}px!important;flex:0 0 ${w}px!important;` +
      'position:sticky!important;top:0!important;left:auto!important;right:auto!important;' +
      'align-self:flex-start!important;max-height:100vh!important;display:flex!important;' +
      'overflow-y:auto!important;overflow-x:hidden!important;background:#121c27!important;' +
      'border-left:1px solid rgba(255,255,255,.06)!important;z-index:2!important;' +
      'transition:width .3s ease!important;'
    )
  }
  if (main) {
    main.setAttribute('style',
      'flex:1!important;min-width:0!important;margin:0!important;' +
      'background:#0c141c!important;overflow:visible!important;'
    )
  }
}

function handleToggle(e: Event) {
  e.preventDefault(); e.stopPropagation()
  const btn = e.currentTarget as HTMLElement
  if (btn.closest('.layout-sidebar--left, .betting-left-aside'))   leftCollapsed.value  = !leftCollapsed.value
  if (btn.closest('.layout-sidebar--right, .betting-right-aside')) rightCollapsed.value = !rightCollapsed.value
  applyLayout(); setTimeout(applyLayout, 320)
}

function bindToggleButtons() {
  document.querySelectorAll<HTMLElement>('.ui-column-toggle-button').forEach(btn => {
    const f = btn.cloneNode(true) as HTMLElement
    btn.parentNode?.replaceChild(f, btn)
    f.addEventListener('click', handleToggle)
    f.style.cursor = 'pointer'
  })
}

function bindNavButtons() {
  document.querySelectorAll<HTMLElement>('button, a, .ui-button').forEach(el => {
    const t = el.textContent?.trim() || ''
    if (['INSCRIPTION', "S'inscrire", 'Inscription'].includes(t))
      el.onclick = (e) => { e.preventDefault(); e.stopPropagation(); router.push('/registration') }
    if (['SE CONNECTER', 'Se connecter', 'Connexion'].includes(t))
      el.onclick = (e) => { e.preventDefault(); e.stopPropagation(); router.push('/login') }
  })
  document.querySelectorAll<HTMLElement>('.app-settings-toolbar-dropdown__trigger').forEach(el => {
    el.onclick = (e) => { e.preventDefault(); e.stopPropagation(); showLang.value = true }
    el.style.cursor = 'pointer'
  })
}

// ── FUSEAUX ─────────────────────────────────────────────────
const timezones = [
  { label: 'Baker (île), Howland (île)', value: 'UTC-12:00' },
  { label: 'Hawaii, Tahiti', value: 'UTC-10:00' },
  { label: 'Los Angeles', value: 'UTC-07:00' },
  { label: 'Chicago, Guatemala', value: 'UTC-06:00' },
  { label: 'New York, Lima', value: 'UTC-05:00' },
  { label: 'Londres, Casablanca', value: 'UTC+00:00' },
  { label: 'Paris, Berlin, Lagos', value: 'UTC+01:00' },
  { label: 'Athènes, Le Caire', value: 'UTC+02:00' },
  { label: 'Moscou, Nairobi', value: 'UTC+03:00' },
  { label: 'Dubaï, Bakou', value: 'UTC+04:00' },
  { label: 'Bangkok, Jakarta', value: 'UTC+07:00' },
  { label: 'Pékin, Singapour', value: 'UTC+08:00' },
  { label: 'Tokyo, Séoul', value: 'UTC+09:00' },
  { label: 'Sydney', value: 'UTC+10:00' },
  { label: 'Auckland', value: 'UTC+12:00' },
]
const filteredTz = computed(() => {
  const q = tzSearch.value.toLowerCase()
  return q ? timezones.filter(t => t.label.toLowerCase().includes(q) || t.value.includes(q)) : timezones
})

onMounted(async () => {
  try {
    const [hRes, bRes, fRes] = await Promise.all([
      fetch('/assets/1xbet-header.html'),
      fetch('/assets/1xbet-body.html'),
      fetch('/assets/1xbet-footer.html'),
    ])
    if (!hRes.ok) throw new Error(`header ${hRes.status}`)
    if (!bRes.ok) throw new Error(`body ${bRes.status}`)
    if (!fRes.ok) throw new Error(`footer ${fRes.status}`)

    headerHtml.value = replaceUrls(await hRes.text())
    bodyHtml.value   = replaceUrls(await bRes.text())
    footerHtml.value = replaceUrls(await fRes.text())

    await nextTick()
    applyLayout(); bindToggleButtons(); bindNavButtons()
    setTimeout(() => { applyLayout(); bindToggleButtons(); bindNavButtons() }, 500)
    setTimeout(() => { applyLayout(); bindToggleButtons(); bindNavButtons() }, 1200)

    window.addEventListener('resize', applyLayout)
  } catch (e) {
    error.value = (e as Error).message
  } finally {
    loading.value = false
  }
})
onUnmounted(() => window.removeEventListener('resize', applyLayout))
</script>

<template>
  <div v-if="loading" class="state-screen"><div class="spinner"></div><span>Chargement…</span></div>
  <div v-else-if="error" class="state-screen err">❌ {{ error }}</div>
  <div v-else class="page-wrapper">
    <!-- HEADER -->
    <div v-html="headerHtml" class="app-header" />
    
    <!-- CONTENU PRINCIPAL -->
    <div class="content-wrapper">
      <div v-html="bodyHtml" class="app-body" />
    </div>
    
    <!-- FOOTER - TOUJOURS EN BAS -->
    <div v-html="footerHtml" class="app-footer" />
  </div>

  <!-- SETTINGS -->
  <Teleport to="body">
    <div v-if="showSettings" class="hp-overlay" @click="showSettings=false">
      <div class="hp-settings" @click.stop>
        <div class="hp-modal-head"><span>⚙️ Paramètres</span><button @click="showSettings=false">✕</button></div>
        <div class="hp-settings-body">
          <div class="hp-s-group">
            <label class="hp-s-label">FORMAT DES COTES</label>
            <div class="hp-s-opts">
              <button class="hp-s-opt hp-s-opt--on">Décimal (2.2)</button>
              <button class="hp-s-opt">Fractionnaire</button>
              <button class="hp-s-opt">Américain</button>
              <button class="hp-s-opt">Hong Kong</button>
            </div>
          </div>
          <div class="hp-s-group">
            <label class="hp-s-label">OPTIONS</label>
            <div class="hp-s-checks">
              <label><input type="checkbox" checked> Pari combiné EN DIRECT</label>
              <label><input type="checkbox" checked> Stats dans nouvelle fenêtre</label>
              <label><input type="checkbox" checked> Déplacer vidéo au scroll</label>
            </div>
          </div>
        </div>
        <div class="hp-modal-foot"><button class="hp-btn-save" @click="showSettings=false">ENREGISTRER</button></div>
      </div>
    </div>
  </Teleport>

  <!-- LANGUE -->
  <Teleport to="body">
    <div v-if="showLang" class="hp-overlay hp-overlay--center" @click="showLang=false">
      <div class="hp-lang-modal" @click.stop>
        <div class="hp-modal-head"><span>🌐 Langue / Fuseau horaire</span><button @click="showLang=false">✕</button></div>
        <div class="hp-lang-tabs">
          <button :class="['hp-lang-tab', langTab==='language'&&'on']" @click="langTab='language'">Langue</button>
          <button :class="['hp-lang-tab', langTab==='timezone'&&'on']" @click="langTab='timezone'">Fuseau horaire</button>
        </div>
        <div class="hp-lang-body">
          <div v-if="langTab==='language'">
            <button :class="['hp-lang-item', selectedLang==='EN'&&'on']" @click="selectedLang='EN'">
              🇬🇧 <strong>EN</strong> English <span v-if="selectedLang==='EN'">✓</span>
            </button>
            <button :class="['hp-lang-item', selectedLang==='FR'&&'on']" @click="selectedLang='FR'">
              🇫🇷 <strong>FR</strong> Français <span v-if="selectedLang==='FR'">✓</span>
            </button>
          </div>
          <div v-else>
            <input v-model="tzSearch" class="hp-tz-search" placeholder="Rechercher…">
            <div class="hp-tz-list">
              <button v-for="tz in filteredTz" :key="tz.value"
                :class="['hp-tz-item', selectedTz===tz.value&&'on']"
                @click="selectedTz=tz.value">
                <span>{{ tz.label }}</span><span class="hp-tz-val">{{ tz.value }}</span>
                <span v-if="selectedTz===tz.value">✓</span>
              </button>
            </div>
          </div>
        </div>
        <div class="hp-modal-foot"><button class="hp-btn-save" @click="showLang=false">ENREGISTRER</button></div>
      </div>
    </div>
  </Teleport>
</template>

<style scoped>
/* ── PAGE WRAPPER ────────────────────────────────────────── */
.page-wrapper {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  width: 100%;
  background: #0c141c;
  flex: 1;
}

.app-header {
  flex-shrink: 0;
  width: 100%;
}

/* ── CONTENU - PREND TOUT L'ESPACE DISPONIBLE ──────────── */
.content-wrapper {
  flex: 1 0 auto;
  width: 100%;
  background: #0c141c;
  padding: 16px;
  padding-bottom: 20px;
}

.app-body {
  width: 100%;
  max-width: 100%;
}

/* ── FOOTER - COLLÉ EN BAS ───────────────────────────────── */
.app-footer {
  flex-shrink: 0;
  margin-top: auto;
  width: 100%;
  background: #ffffff;
  display: block;
  min-height: 50px;
  position: relative;
  z-index: 10;
}

/* ── CHARGEMENT ──────────────────────────────────────────── */
.state-screen {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 16px;
  min-height: 100vh;
  background: #0c141c;
  color: #fff;
}

.state-screen.err {
  color: #ff6b6b;
}

.spinner {
  width: 36px;
  height: 36px;
  border: 3px solid rgba(255,255,255,.15);
  border-top-color: #e8a838;
  border-radius: 50%;
  animation: spin .8s linear infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

/* ── OVERLAYS ────────────────────────────────────────────── */
.hp-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0,0,0,.7);
  z-index: 9999;
  display: flex;
  justify-content: flex-end;
  animation: fadeIn .2s;
}

.hp-overlay--center {
  justify-content: center;
  align-items: center;
}

@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

.hp-modal-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  border-bottom: 1px solid #e8ecf1;
  font-size: 16px;
  font-weight: 700;
  color: #1a1a2e;
}

.hp-modal-head button {
  background: none;
  border: none;
  font-size: 20px;
  color: #8a9bb5;
  cursor: pointer;
}

.hp-modal-foot {
  padding: 16px 20px;
  border-top: 1px solid #e8ecf1;
}

.hp-btn-save {
  width: 100%;
  padding: 13px;
  background: #2563eb;
  color: #fff;
  border: none;
  border-radius: 8px;
  font-size: 14px;
  font-weight: 700;
  text-transform: uppercase;
  cursor: pointer;
}

.hp-btn-save:hover {
  background: #1d4ed8;
}

/* Settings */
.hp-settings {
  width: 400px;
  max-width: 95vw;
  height: 100%;
  background: #fff;
  display: flex;
  flex-direction: column;
  animation: slideIn .3s;
}

@keyframes slideIn {
  from { transform: translateX(100%); }
  to { transform: translateX(0); }
}

.hp-settings-body {
  flex: 1;
  padding: 20px;
  overflow-y: auto;
}

.hp-s-group {
  margin-bottom: 20px;
}

.hp-s-label {
  display: block;
  font-size: 11px;
  font-weight: 700;
  color: #8a9bb5;
  text-transform: uppercase;
  letter-spacing: .5px;
  margin-bottom: 8px;
}

.hp-s-opts {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.hp-s-opt {
  padding: 6px 12px;
  border: 1px solid #e8ecf1;
  border-radius: 4px;
  background: #fff;
  color: #4a5a72;
  font-size: 13px;
  cursor: pointer;
}

.hp-s-opt--on {
  background: #2563eb;
  border-color: #2563eb;
  color: #fff;
  font-weight: 600;
}

.hp-s-checks {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.hp-s-checks label {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
  color: #1a1a2e;
  cursor: pointer;
}

/* Langue */
.hp-lang-modal {
  width: 420px;
  max-width: 94vw;
  max-height: 88vh;
  background: #fff;
  border-radius: 12px;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.hp-lang-tabs {
  display: flex;
  gap: 4px;
  padding: 12px 16px;
  background: #f5f6fa;
}

.hp-lang-tab {
  flex: 1;
  padding: 9px;
  border: none;
  background: transparent;
  font-size: 14px;
  font-weight: 600;
  color: #4a5a72;
  cursor: pointer;
  border-radius: 6px;
}

.hp-lang-tab.on {
  background: #2563eb;
  color: #fff;
}

.hp-lang-body {
  flex: 1;
  padding: 12px 16px;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.hp-lang-item {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 12px 14px;
  border: 2px solid transparent;
  border-radius: 8px;
  background: #f8f9fc;
  cursor: pointer;
  font-size: 15px;
  width: 100%;
}

.hp-lang-item:hover {
  background: #f0f7ff;
}

.hp-lang-item.on {
  background: #eff6ff;
  border-color: #2563eb;
}

.hp-lang-item strong {
  min-width: 32px;
}

.hp-tz-search {
  width: 100%;
  padding: 10px 14px;
  border: 2px solid #e8ecf1;
  border-radius: 8px;
  font-size: 14px;
  outline: none;
  margin-bottom: 8px;
}

.hp-tz-search:focus {
  border-color: #2563eb;
}

.hp-tz-list {
  max-height: 260px;
  overflow-y: auto;
  border: 1px solid #e8ecf1;
  border-radius: 8px;
}

.hp-tz-item {
  display: flex;
  align-items: center;
  gap: 8px;
  width: 100%;
  padding: 10px 14px;
  border: none;
  border-bottom: 1px solid #f5f6fa;
  background: #fff;
  font-size: 13px;
  cursor: pointer;
}

.hp-tz-item:hover {
  background: #f5f6fa;
}

.hp-tz-item.on {
  background: #eff6ff;
}

.hp-tz-val {
  margin-left: auto;
  font-size: 11px;
  color: #8a9bb5;
}

/* ── RESPONSIVE ───────────────────────────────────────────── */
@media (max-width: 1023px) {
  .content-wrapper {
    padding: 8px !important;
    padding-bottom: 70px !important;
  }
}

@media (max-width: 768px) {
  .content-wrapper {
    padding: 4px !important;
    padding-bottom: 68px !important;
  }
}

@media (max-width: 480px) {
  .content-wrapper {
    padding: 2px !important;
    padding-bottom: 64px !important;
  }
}
</style>