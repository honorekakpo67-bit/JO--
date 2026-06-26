<script setup lang="ts">
interface NavItem {
  label: string
  path: string
}

const items: NavItem[] = [
  { label: 'Accueil', path: '/' },
  { label: 'Compte', path: '/account' },
  { label: 'Dépôt', path: '/deposit' },
  { label: 'Retrait', path: '/withdraw' },
]
</script>

<template>
  <nav class="mb-nav">
    <router-link
      v-for="item in items"
      :key="item.path"
      :to="item.path"
      class="mb-nav__item"
      :class="{ 'mb-nav__item--active': $route.path === item.path }"
    >
      <span class="mb-nav__icon">
        <!-- Accueil -->
        <svg v-if="item.path === '/'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mb-nav__svg">
          <path d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
        </svg>
        <!-- Compte -->
        <svg v-else-if="item.path === '/account'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mb-nav__svg">
          <path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2" />
          <circle cx="12" cy="7" r="4" />
        </svg>
        <!-- Dépôt -->
        <svg v-else-if="item.path === '/deposit'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mb-nav__svg">
          <line x1="12" y1="1" x2="12" y2="23" />
          <path d="M17 5H9.5a3.5 3.5 0 000 7h5a3.5 3.5 0 010 7H6" />
        </svg>
        <!-- Retrait -->
        <svg v-else viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mb-nav__svg">
          <line x1="12" y1="23" x2="12" y2="1" />
          <path d="M17 19H9.5a3.5 3.5 0 010-7h5a3.5 3.5 0 000-7H6" />
        </svg>
      </span>
      <span class="mb-nav__label">{{ item.label }}</span>
    </router-link>
  </nav>
</template>

<style scoped>
.mb-nav {
  display: none;
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  z-index: 9999;
  height: 56px;
  background: hsl(208, 62%, 18%);
  border-top: 1px solid rgba(255,255,255,0.1);
  align-items: center;
  justify-content: space-around;
  padding-bottom: env(safe-area-inset-bottom, 0);
}

.mb-nav__item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 2px;
  text-decoration: none;
  color: rgba(255,255,255,0.5);
  padding: 4px 12px;
  border-radius: 6px;
  transition: color 0.15s;
  -webkit-tap-highlight-color: transparent;
}

.mb-nav__item--active {
  color: hsl(208, 62%, 60%);
}

.mb-nav__icon {
  width: 22px;
  height: 22px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.mb-nav__svg {
  width: 22px;
  height: 22px;
}

.mb-nav__label {
  font-size: 9px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.3px;
}

@media (max-width: 1023px) {
  .mb-nav {
    display: flex;
  }
}
</style>
