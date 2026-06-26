<script setup lang="ts">
import { ref, onMounted } from 'vue'
import MobileBottomNav from '../components/MobileBottomNav.vue'

const baseUrl = import.meta.env.VITE_APP_BASE_URL || 'http://72.62.28.185:81'

const html = ref('')
const loading = ref(true)
const error = ref<string | null>(null)

function replaceUrls(html: string): string {
  return html
    .replace(/https:\/\/1xbet\.bj\/fr/g, baseUrl)
    .replace(/https:\/\/1xbet\.bj/g, baseUrl)
    .replace(/https:\/\/partners1xbet\.com/g, baseUrl)
    .replace(/https:\/\/instagram\.com\/1xbet\.bj/g, baseUrl + '/instagram')
}

onMounted(async () => {
  try {
    const res = await fetch('/assets/deposit.html')
    if (!res.ok) throw new Error(`HTTP ${res.status}`)
    html.value = replaceUrls(await res.text())
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
  <div v-else class="deposit-page" v-html="html" />
  <MobileBottomNav />
</template>

<style scoped>
@media (max-width: 1023px) {
  .deposit-page {
    padding-bottom: 56px;
  }
}
</style>
