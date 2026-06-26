<script setup lang="ts">
import { ref } from 'vue'
import MobileBottomNav from '../components/MobileBottomNav.vue'

type RegType = 'phone' | 'email' | 'social'
type BonusType = 'sport' | 'casino' | 'refuse'

const regType = ref<RegType>('phone')
const bonusType = ref<BonusType>('sport')
const phone = ref('')
const smsCode = ref('')
const promo = ref('')
const firstName = ref('')
const email = ref('')
const phoneEmail = ref('')
const docNum = ref('')
const docSerial = ref('')
const issueDate = ref('')
const birthDate = ref('')
const password = ref('')
const baseUrl = import.meta.env.VITE_APP_BASE_URL || 'http://72.62.28.185:81'
const passwordConfirm = ref('')
const sendMethod = ref('SMS')
const lastName = ref('')
const agreeMarketing = ref(false)
const showPassword = ref(false)
const showPasswordConfirm = ref(false)

function setRegType(type: RegType) {
  regType.value = type
}
</script>

<template>
  <div class="registration-page-desktop">
    <div class="registration">

      <!-- BONUS GAUCHE -->
      <div class="registration__bonus-left">
        <ul class="registration-bonus-choice">
          <li class="registration-bonus-choice__bonus">
            <div :class="['ui-bonus-select','ui-bonus-select--row','ui-bonus-select--theme-gray-100','registration-bonus-choice__select', bonusType==='sport' ? 'ui-bonus-select--selected' : '']" @click="bonusType='sport'">
              <div class="ui-bonus-select__container">
                <span class="ui-bonus-select__text">
                  <span class="ui-bonus-select__title">Bonus pour le sport</span>
                  <span class="ui-bonus-select__info">Bonus de 200 % sur le premier dépôt jusqu'à 250000 XOF</span>
                </span>
              </div>
              <label class="ui-bonus-select__label">
                <input type="radio" name="bonus" class="ui-bonus-select__input" :checked="bonusType==='sport'" value="0">
              </label>
            </div>
          </li>
          <li class="registration-bonus-choice__bonus">
            <div :class="['ui-bonus-select','ui-bonus-select--row','ui-bonus-select--theme-gray-100','registration-bonus-choice__select', bonusType==='casino' ? 'ui-bonus-select--selected' : '']" @click="bonusType='casino'">
              <div class="ui-bonus-select__container">
                <span class="ui-bonus-select__text">
                  <span class="ui-bonus-select__title">Casino + 1xGames</span>
                  <span class="ui-bonus-select__info">Pack de bienvenue jusqu'à 1000000 XOF + 150 FS</span>
                </span>
              </div>
              <label class="ui-bonus-select__label">
                <input type="radio" name="bonus" class="ui-bonus-select__input" :checked="bonusType==='casino'" value="1">
              </label>
            </div>
          </li>
          <li class="registration-bonus-choice__bonus">
            <div :class="['ui-bonus-select','ui-bonus-select--row','ui-bonus-select--theme-gray-100','registration-bonus-choice__select', bonusType==='refuse' ? 'ui-bonus-select--unwanted' : '']" @click="bonusType='refuse'">
              <div class="ui-bonus-select__container">
                <span class="ui-bonus-select__text">
                  <span class="ui-bonus-select__title">Refuser les bonus</span>
                  <span class="ui-bonus-select__info">Faites votre choix plus tard</span>
                </span>
              </div>
              <label class="ui-bonus-select__label">
                <input type="radio" name="bonus" class="ui-bonus-select__input" :checked="bonusType==='refuse'" value="-1">
              </label>
            </div>
          </li>
        </ul>
      </div>

      <!-- FORMULAIRE DROITE -->
      <div class="registration__content">
        <div class="registration__inner">
          <div class="registration__form-wrapper">
            <h1 class="registration__title">INSCRIPTION</h1>

            <!-- TABS -->
            <ul class="registration__tabs">
              <li :class="['tab-item', regType==='phone' ? 'tab-item--active' : '']">
                <label>
                  <input type="radio" name="registration_tabs" :checked="regType==='phone'" @change="setRegType('phone')">
                  <div class="tab-item__inner">
                    <svg viewBox="0 0 10 15" width="14" height="14" fill="currentColor"><path d="M8.7.7h-7C1 .7.4 1.1.4 1.7v12c0 .6.5 1 1.1 1h7.1c.6 0 1.1-.4 1.1-1v-12c0-.6-.5-1-1-1zM4 1.4h2.3l.1.1v.1H4v-.2zm1.2 12.8c-.3 0-.6-.2-.6-.4 0-.3.3-.5.6-.5s.5.2.5.5c0 .2-.2.4-.5.4zM9 13H1.3V2.2H9V13z"/></svg>
                    <span>Par téléphone</span>
                  </div>
                </label>
              </li>
              <li :class="['tab-item', regType==='email' ? 'tab-item--active' : '']">
                <label>
                  <input type="radio" name="registration_tabs" :checked="regType==='email'" @change="setRegType('email')">
                  <div class="tab-item__inner">
                    <svg viewBox="0 0 32 32" width="14" height="14" fill="currentColor"><path d="M16 20.7l-4-3.5L.8 26.9c.4.4 1 .6 1.6.6h27.4c.6 0 1.2-.2 1.6-.6L20 17.2l-4 3.5z"/><path d="M31.3 5.3c-.4-.4-1-.6-1.6-.6H2.3c-.6 0-1.2.2-1.6.6L16 18.4 31.3 5.3zM0 6.7v19l11-9.4zM21 16.3l11 9.4v-19z"/></svg>
                    <span>Par e-mail</span>
                  </div>
                </label>
              </li>
              <li :class="['tab-item', regType==='social' ? 'tab-item--active' : '']">
                <label>
                  <input type="radio" name="registration_tabs" :checked="regType==='social'" @change="setRegType('social')">
                  <div class="tab-item__inner">
                    <svg viewBox="0 0 32 32" width="14" height="14" fill="currentColor"><path d="M19.3 7.3c1.5.9 2.6 2.4 2.8 4.3.6.3 1.2.5 2 .5a4.7 4.7 0 000-9.3c-2.7-.1-4.8 2-4.8 4.5zm-3 9.6c2.6 0 4.6-2.2 4.6-4.7s-2.1-4.7-4.6-4.7-4.7 2.2-4.7 4.7 2 4.7 4.7 4.7zm1.9.3h-4a6 6 0 00-6 6v5h.3c3.2 1 6 1.4 8.2 1.4 4.4 0 7-1.3 7.2-1.3l.3-.2v-4.8a6 6 0 00-6-6.1zm7.8-4.8h-4c0 1.6-.7 3-1.7 4 2.9.9 5 3.6 5 6.9v1.5c4-.1 6.2-1.3 6.3-1.3l.3-.2h.1v-4.8a6 6 0 00-6-6.1zm-18-.3c1 0 1.8-.3 2.5-.8.2-1.5 1-2.8 2.2-3.7v-.3a4.7 4.7 0 00-9.3 0c0 2.6 2 4.8 4.6 4.8zm4.2 4.3c-1-1-1.7-2.5-1.8-4H6a6 6 0 00-6 6v5h.3c2.6.9 4.8 1.2 6.8 1.3v-1.4c0-3.3 2.2-6 5.1-6.9z"/></svg>
                    <span>Réseaux sociaux</span>
                  </div>
                </label>
              </li>
            </ul>

            <!-- ── PAR TÉLÉPHONE ── -->
            <div v-if="regType==='phone'" class="reg-fields">
              <div class="reg-header-text">
                <strong>Par téléphone</strong>
                <span>Pour vous inscrire, saisissez votre numéro de téléphone et choisissez la manière dont vous souhaitez recevoir le code</span>
              </div>
              <div class="reg-row">
                <div class="reg-field reg-field--full">
                  <div class="phone-input-wrap">
                    <span class="phone-code">+ 229</span>
                    <input v-model="phone" type="tel" class="field-input" placeholder="01 23 45 67 89">
                  </div>
                </div>
              </div>
              <div class="reg-row">
                <div class="reg-field">
                  <label class="field-label">Sélectionnez la devise</label>
                  <div class="field-select-wrap">
                    <span class="field-select-value">Franc CFA d'Afrique de l'Ouest (XOF)</span>
                    <span class="field-caret">▾</span>
                  </div>
                </div>
                <div class="reg-field">
                  <label class="field-label">Code de confirmation</label>
                  <input v-model="smsCode" type="text" maxlength="5" class="field-input" placeholder="Code de confirmation">
                </div>
                <div class="reg-field">
                  <label class="field-label">Code promo (si vous en avez un)</label>
                  <input v-model="promo" type="text" class="field-input" placeholder="Code promo">
                </div>
                <div class="reg-field">
                  <button type="button" class="btn-accent btn-block">S'INSCRIRE</button>
                </div>
                <div class="reg-field reg-field--full">
                  <p class="terms-text">En appuyant sur ce bouton, vous confirmez avoir lu et accepté les <a :href="baseUrl+'/information/rules'" target="_blank">Conditions générales</a> et la <a :href="baseUrl+'/information/rules/privacy_policy'" target="_blank">Politique de confidentialité</a>.</p>
                </div>
                <div class="reg-field reg-field--full">
                  <label class="checkbox-label">
                    <input v-model="agreeMarketing" type="checkbox" class="checkbox-input">
                    <span class="checkbox-box"></span>
                    <span>J'accepte de recevoir des offres marketing et promotionnelles par téléphone</span>
                  </label>
                </div>
              </div>
            </div>

            <!-- ── PAR E-MAIL ── -->
            <div v-if="regType==='email'" class="reg-fields">
              <div class="reg-row">
                <div class="reg-field">
                  <label class="field-label">Choisissez un pays</label>
                  <div class="field-select-wrap disabled">
                    <span class="field-select-value">Bénin</span>
                    <span class="field-caret">▾</span>
                  </div>
                </div>
                <div class="reg-field">
                  <label class="field-label">Choisissez une région</label>
                  <div class="field-select-wrap">
                    <span class="field-select-value placeholder">Choisissez une région</span>
                    <span class="field-caret">▾</span>
                  </div>
                </div>
                <div class="reg-field">
                  <label class="field-label">Choisissez une ville</label>
                  <div class="field-select-wrap disabled">
                    <span class="field-select-value placeholder">Choisissez une ville</span>
                    <span class="field-caret">▾</span>
                  </div>
                </div>
                <div class="reg-field">
                  <label class="field-label">Sélectionnez la devise</label>
                  <div class="field-select-wrap disabled">
                    <span class="field-select-value">Franc CFA d'Afrique de l'Ouest (XOF)</span>
                    <span class="field-caret">▾</span>
                  </div>
                </div>
              </div>
              <div class="reg-row">
                <div class="reg-field">
                  <label class="field-label">E-mail *</label>
                  <input v-model="email" type="email" class="field-input" placeholder="E-mail">
                </div>
                <div class="reg-field">
                  <label class="field-label">Numéro de téléphone</label>
                  <input v-model="phoneEmail" type="tel" class="field-input" placeholder="01 23 45 67 89">
                </div>
                <div class="reg-field">
                  <label class="field-label">Prénom *</label>
                  <input v-model="firstName" type="text" class="field-input" placeholder="Prénom">
                </div>
                <div class="reg-field">
                  <label class="field-label">Votre nom *</label>
                  <input v-model="lastName" type="text" class="field-input" placeholder="Votre nom">
                </div>
                <div class="reg-field">
                  <label class="field-label">Date de naissance</label>
                  <input v-model="birthDate" type="date" class="field-input">
                </div>
                <div class="reg-field">
                  <label class="field-label">Type de document</label>
                  <div class="field-select-wrap">
                    <span class="field-select-value">Passeport (document d'identité)</span>
                    <span class="field-caret">▾</span>
                  </div>
                </div>
                <div class="reg-field">
                  <label class="field-label">Série du document</label>
                  <input v-model="docSerial" type="text" class="field-input" placeholder="Série du document">
                </div>
                <div class="reg-field">
                  <label class="field-label">Date de délivrance</label>
                  <input v-model="issueDate" type="date" class="field-input">
                </div>
                <div class="reg-field">
                  <label class="field-label">Numéro du document</label>
                  <input v-model="docNum" type="text" class="field-input" placeholder="Numéro du document">
                </div>
                <div class="reg-field">
                  <label class="field-label">Mot de passe *</label>
                  <div class="pass-wrap">
                    <input v-model="password" :type="showPassword ? 'text' : 'password'" class="field-input" placeholder="Mot de passe">
                    <button type="button" class="pass-eye" @click="showPassword=!showPassword">{{ showPassword ? '🙈' : '👁' }}</button>
                  </div>
                </div>
                <div class="reg-field">
                  <label class="field-label">Confirmer le mot de passe *</label>
                  <div class="pass-wrap">
                    <input v-model="passwordConfirm" :type="showPasswordConfirm ? 'text' : 'password'" class="field-input" placeholder="Indiquez à nouveau votre mot de passe">
                    <button type="button" class="pass-eye" @click="showPasswordConfirm=!showPasswordConfirm">{{ showPasswordConfirm ? '🙈' : '👁' }}</button>
                  </div>
                </div>
                <div class="reg-field">
                  <label class="field-label">Code promo (si vous en avez un)</label>
                  <input v-model="promo" type="text" class="field-input" placeholder="Code promo">
                </div>
                <div class="reg-field">
                  <button type="button" class="btn-accent btn-block">S'INSCRIRE</button>
                </div>
                <div class="reg-field reg-field--full">
                  <p class="terms-text">En appuyant sur ce bouton, vous confirmez avoir lu et accepté les <a :href="baseUrl+'/information/rules'" target="_blank">Conditions générales</a> et la <a :href="baseUrl+'/information/rules/privacy_policy'" target="_blank">Politique de confidentialité</a>.</p>
                </div>
                <div class="reg-field reg-field--full">
                  <label class="checkbox-label">
                    <input v-model="agreeMarketing" type="checkbox" class="checkbox-input">
                    <span class="checkbox-box"></span>
                    <span>J'accepte de recevoir des offres marketing et promotionnelles par téléphone</span>
                  </label>
                </div>
              </div>
            </div>

            <!-- ── RÉSEAUX SOCIAUX ── -->
            <div v-if="regType==='social'" class="reg-fields">
              <div class="reg-row">
                <div class="reg-field reg-field--full">
                  <p class="field-label" style="margin-bottom:10px">Réseaux sociaux</p>
                  <div style="display:flex;gap:10px;flex-wrap:wrap;">
                    <button type="button" class="btn-social">✈️ Telegram</button>
                    <button type="button" class="btn-social">🌐 Google</button>
                    <button type="button" class="btn-social">🍎 Apple ID</button>
                  </div>
                </div>
                <div class="reg-field">
                  <label class="field-label">Choisissez un pays</label>
                  <div class="field-select-wrap disabled">
                    <span class="field-select-value">Bénin</span>
                    <span class="field-caret">▾</span>
                  </div>
                </div>
                <div class="reg-field">
                  <label class="field-label">Sélectionnez la devise</label>
                  <div class="field-select-wrap disabled">
                    <span class="field-select-value">Franc CFA d'Afrique de l'Ouest (XOF)</span>
                    <span class="field-caret">▾</span>
                  </div>
                </div>
                <div class="reg-field">
                  <label class="field-label">Code promo (si vous en avez un)</label>
                  <input v-model="promo" type="text" class="field-input" placeholder="Code promo">
                </div>
                <div class="reg-field">
                  <button type="button" class="btn-accent btn-block">S'INSCRIRE</button>
                </div>
                <div class="reg-field reg-field--full">
                  <p class="terms-text">En appuyant sur ce bouton, vous confirmez avoir lu et accepté les <a :href="baseUrl+'/information/rules'" target="_blank">Conditions générales</a> et la <a :href="baseUrl+'/information/rules/privacy_policy'" target="_blank">Politique de confidentialité</a>.</p>
                </div>
              </div>
            </div>

          </div>
        </div>
      </div>
    </div>
    <MobileBottomNav />
  </div>
</template>

<style scoped>
/* ── PAGE ─────────────────────────────────────────────────── */
.registration-page-desktop {
  min-height: 100vh;
  background: #f0f2f5;
  display: flex;
  flex-direction: column;
}

/* ── LAYOUT 2 COLONNES ───────────────────────────────────── */
.registration {
  display: flex;
  flex-direction: row;
  align-items: flex-start;
  gap: 2px;
  padding: 1.5rem;
  max-width: 1100px;
  margin: 0 auto;
  width: 100%;
}

/* ── BONUS GAUCHE ─────────────────────────────────────────── */
.registration__bonus-left {
  width: 300px;
  min-width: 300px;
  flex-shrink: 0;
}

.registration-bonus-choice {
  list-style: none;
  margin: 0;
  padding: 0;
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 5px 17px 1px rgba(0,0,0,.15);
}

.registration-bonus-choice__bonus:nth-child(n+2) {
  border-top: 1px solid #e5e7eb;
}

.ui-bonus-select {
  display: flex;
  align-items: center;
  padding: 1rem;
  cursor: pointer;
  background: #fff;
  transition: background .15s;
}
.ui-bonus-select--selected { background: #f0fdf4; }
.ui-bonus-select--unwanted { opacity: .6; }
.ui-bonus-select__container { flex: 1; }
.ui-bonus-select__text { display: flex; flex-direction: column; gap: 3px; }
.ui-bonus-select__title { font-size: .85rem; font-weight: 700; color: #1f2937; }
.ui-bonus-select__info { font-size: .75rem; color: #6b7280; line-height: 1.4; }
.ui-bonus-select__label { margin-left: .5rem; }
.ui-bonus-select__input { accent-color: #6841ea; width: 1rem; height: 1rem; }

/* ── FORMULAIRE DROITE ────────────────────────────────────── */
.registration__content { flex: 1; min-width: 0; }

.registration__inner {
  background: #fff;
  border-radius: 10px;
  box-shadow: 0 5px 17px 1px rgba(0,0,0,.15);
  overflow: hidden;
}

.registration__form-wrapper {
  padding: 1.5rem 1.25rem 2rem;
}

.registration__title {
  text-align: center;
  font-size: 1.4rem;
  font-weight: 800;
  letter-spacing: 2px;
  color: #4fc3f7;
  margin-bottom: 1.25rem;
}

/* ── TABS ─────────────────────────────────────────────────── */
.registration__tabs {
  display: flex;
  list-style: none;
  margin: 0 0 1.25rem;
  padding: 4px;
  background: #f0f2f5;
  border-radius: 8px;
  gap: 2px;
}

.tab-item { flex: 1; }

.tab-item label {
  display: flex;
  cursor: pointer;
  border-radius: 6px;
  transition: all .15s;
}

.tab-item label input { display: none; }

.tab-item__inner {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  padding: 8px 6px;
  width: 100%;
  border-radius: 6px;
  font-size: .8rem;
  font-weight: 600;
  color: #6b7280;
  transition: all .15s;
}

.tab-item--active .tab-item__inner {
  background: #fff;
  color: #6841ea;
  box-shadow: 0 1px 4px rgba(0,0,0,.1);
}

/* ── CHAMPS ───────────────────────────────────────────────── */
.reg-fields { display: flex; flex-direction: column; gap: 1rem; }

.reg-header-text {
  display: flex;
  flex-direction: column;
  gap: 4px;
  text-align: center;
  margin-bottom: .5rem;
}
.reg-header-text strong { font-size: .9rem; color: #1f2937; }
.reg-header-text span { font-size: .8rem; color: #6b7280; line-height: 1.4; }

.reg-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: .75rem;
}

.reg-field { display: flex; flex-direction: column; gap: 4px; }
.reg-field--full { grid-column: 1 / -1; }

.field-label {
  font-size: .72rem;
  font-weight: 600;
  color: #9ca3af;
}

.field-input {
  width: 100%;
  padding: 10px 12px;
  border: 1.5px solid #d1d5db;
  border-radius: 6px;
  font-size: .875rem;
  color: #1f2937;
  background: #fff;
  outline: none;
  transition: border-color .15s;
  box-sizing: border-box;
}
.field-input:focus { border-color: #6841ea; }

.field-select-wrap {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px 12px;
  border: 1.5px solid #d1d5db;
  border-radius: 6px;
  background: #fff;
  cursor: pointer;
  min-height: 42px;
}
.field-select-wrap.disabled { background: #f3f4f6; opacity: .7; cursor: not-allowed; }
.field-select-value { font-size: .8rem; color: #374151; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.field-select-value.placeholder { color: #9ca3af; }
.field-caret { font-size: .7rem; color: #9ca3af; flex-shrink: 0; margin-left: 4px; }

/* Phone input */
.phone-input-wrap {
  display: flex;
  align-items: center;
  border: 1.5px solid #d1d5db;
  border-radius: 6px;
  overflow: hidden;
}
.phone-code {
  padding: 10px 12px;
  background: #f3f4f6;
  font-size: .875rem;
  color: #374151;
  border-right: 1.5px solid #d1d5db;
  white-space: nowrap;
  flex-shrink: 0;
}
.phone-input-wrap .field-input {
  border: none;
  border-radius: 0;
  flex: 1;
}
.phone-input-wrap .field-input:focus { border: none; outline: none; }

/* Mot de passe */
.pass-wrap { position: relative; display: flex; }
.pass-wrap .field-input { padding-right: 40px; }
.pass-eye {
  position: absolute;
  right: 10px;
  top: 50%;
  transform: translateY(-50%);
  background: none;
  border: none;
  cursor: pointer;
  font-size: 1rem;
  color: #9ca3af;
}

/* Boutons */
.btn-accent {
  padding: 12px 20px;
  background: linear-gradient(90deg, #6abf2e, #4caf20);
  color: #fff;
  border: none;
  border-radius: 6px;
  font-size: .9rem;
  font-weight: 700;
  letter-spacing: 1px;
  cursor: pointer;
  transition: opacity .2s;
  text-transform: uppercase;
}
.btn-accent:hover { opacity: .9; }
.btn-block { width: 100%; }

.btn-social {
  padding: 10px 16px;
  background: #e5e7eb;
  border: none;
  border-radius: 6px;
  font-size: .85rem;
  font-weight: 600;
  cursor: pointer;
  transition: background .15s;
}
.btn-social:hover { background: #d1d5db; }

/* Texte conditions */
.terms-text {
  font-size: .72rem;
  color: #9ca3af;
  line-height: 1.5;
  text-align: center;
}
.terms-text a { color: #6841ea; text-decoration: underline; }

/* Checkbox */
.checkbox-label {
  display: flex;
  align-items: flex-start;
  gap: .5rem;
  cursor: pointer;
  font-size: .82rem;
  color: #374151;
  line-height: 1.4;
}
.checkbox-input { display: none; }
.checkbox-box {
  width: 18px;
  height: 18px;
  min-width: 18px;
  border: 2px solid #d1d5db;
  border-radius: 3px;
  position: relative;
  transition: all .15s;
  margin-top: 2px;
}
.checkbox-input:checked + .checkbox-box {
  background: #6841ea;
  border-color: #6841ea;
}
.checkbox-input:checked + .checkbox-box::after {
  content: '';
  position: absolute;
  top: 1px; left: 4px;
  width: 4px; height: 8px;
  border: solid #fff;
  border-width: 0 2px 2px 0;
  transform: rotate(45deg);
}

/* ── RESPONSIVE ───────────────────────────────────────────── */
@media (max-width: 1023px) {
  .registration {
    flex-direction: column;
    padding: 1rem;
    padding-bottom: 70px;
  }
  .registration__bonus-left {
    width: 100%;
    min-width: 0;
  }
  .registration__inner {
    box-shadow: none;
    border-radius: 8px;
  }
}

@media (max-width: 640px) {
  .reg-row {
    grid-template-columns: 1fr;
  }
  .reg-field--full {
    grid-column: 1;
  }
  .registration__form-wrapper {
    padding: 1rem;
  }
  .registration__title {
    font-size: 1.1rem;
  }
  .tab-item__inner {
    font-size: .68rem;
    padding: 7px 4px;
    gap: 3px;
  }
  .tab-item__inner svg {
    display: none;
  }
}

@media (max-width: 400px) {
  .registration { padding: .5rem; }
}
</style>