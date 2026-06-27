<!-- src/App.vue - LAYOUT PRINCIPAL SIMPLIFIÉ -->
<script setup lang="ts">
import { RouterView } from 'vue-router'
import MobileBottomNav from './components/MobileBottomNav.vue'
</script>

<template>
  <div id="app">
    <RouterView />
    <MobileBottomNav />
  </div>
</template>

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

html, body {
  height: 100%;
  background: #0c141c;
}

#app {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  height: 100%;
  background: #0c141c;
}

/* La navigation mobile est en bas */
.mobile-bottom-nav {
  flex-shrink: 0;
  position: sticky;
  bottom: 0;
  z-index: 100;
}
</style>