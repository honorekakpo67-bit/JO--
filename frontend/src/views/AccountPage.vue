<script setup lang="ts">
import FooterSection from '../components/FooterSection.vue'
import MobileBottomNav from '../components/MobileBottomNav.vue'

const links = [
  { label: 'Profil', icon: '👤' },
  { label: 'Dépôt', icon: '💰' },
  { label: 'Retrait', icon: '💳' },
  { label: 'Paris', icon: '📊' },
  { label: 'Bonus', icon: '🎁' },
]
</script>

<template>
  <div class="account-page">
    <div class="account-card">
      <h1>Mon Compte</h1>
      <p>Solde: 0 XOF</p>
      <div class="links">
        <div v-for="link in links" :key="link.label" class="link-item">
          <span>{{ link.icon }}</span>
          <span>{{ link.label }}</span>
        </div>
      </div>
    </div>
    <FooterSection />
    <MobileBottomNav />
  </div>
</template>

<style scoped>
@media (max-width: 1023px) {
  .account-page {
    padding-bottom: 56px;
  }

  .account-card {
    margin: 0 10px !important;
  }
}
</style>
