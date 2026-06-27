<!-- src/components/MobileBottomNav.vue -->
<script setup lang="ts">
import { useRoute } from 'vue-router'

interface NavItem {
  label: string
  path: string
  center?: boolean
}

const route = useRoute()

const items: NavItem[] = [
  { label: 'Sports',    path: '/'             },
  { label: 'Casino',   path: '/casino'        },
  { label: 'Coupon',   path: '/coupon', center: true },
  { label: 'Connexion', path: '/login'        },
  { label: 'Menu',     path: '/menu'          },
]

const isActive = (path: string) => {
  if (path === '/') return route.path === '/'
  return route.path.startsWith(path)
}
</script>

<template>
  <nav class="mb-nav">
    <router-link
      v-for="item in items"
      :key="item.path"
      :to="item.path"
      :class="['mb-nav__item', item.center && 'mb-nav__item--center', isActive(item.path) && 'mb-nav__item--active']"
    >
      <span class="mb-nav__icon">

        <!-- Sports -->
        <svg v-if="item.path === '/'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mb-nav__svg">
          <circle cx="12" cy="12" r="10"/>
          <path d="M12 2a15.3 15.3 0 014 10 15.3 15.3 0 01-4 10 15.3 15.3 0 01-4-10 15.3 15.3 0 014-10z"/>
          <path d="M2 12h20"/>
        </svg>

        <!-- Casino -->
        <svg v-else-if="item.path === '/casino'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mb-nav__svg">
          <rect x="2" y="3" width="20" height="14" rx="2"/>
          <path d="M8 21h8M12 17v4"/>
          <circle cx="12" cy="10" r="3"/>
        </svg>

        <!-- Coupon (centre) -->
        <svg v-else-if="item.path === '/coupon'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mb-nav__svg">
          <path d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2"/>
          <rect x="9" y="3" width="6" height="4" rx="1"/>
          <path d="M9 12h6M9 16h4"/>
        </svg>

        <!-- Connexion -->
        <svg v-else-if="item.path === '/login'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mb-nav__svg">
          <path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2"/>
          <circle cx="12" cy="7" r="4"/>
        </svg>

        <!-- Menu -->
        <svg v-else viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mb-nav__svg">
          <line x1="3" y1="6" x2="21" y2="6"/>
          <line x1="3" y1="12" x2="21" y2="12"/>
          <line x1="3" y1="18" x2="21" y2="18"/>
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
  background: #fff;
  border-top: 1px solid #e8ecf1;
  box-shadow: 0 -2px 10px rgba(0,0,0,.08);
  align-items: center;
  justify-content: space-around;
  padding-bottom: env(safe-area-inset-bottom, 0);
}

.mb-nav__item {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 2px;
  text-decoration: none;
  color: #8a9bb5;
  flex: 1;
  height: 100%;
  padding: 4px 2px;
  transition: color .2s;
  -webkit-tap-highlight-color: transparent;
}

.mb-nav__item--active { color: #2563eb; }

.mb-nav__icon {
  width: 22px;
  height: 22px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.mb-nav__svg { width: 22px; height: 22px; }

.mb-nav__label {
  font-size: 9px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.3px;
  white-space: nowrap;
}

/* Bouton central Coupon */
.mb-nav__item--center { position: relative; }

.mb-nav__item--center .mb-nav__icon {
  background: #2563eb;
  color: #fff;
  width: 44px;
  height: 44px;
  border-radius: 50%;
  margin-top: -16px;
  box-shadow: 0 4px 12px rgba(37,99,235,.4);
}

.mb-nav__item--center .mb-nav__svg {
  width: 22px;
  height: 22px;
  stroke: #fff;
}

.mb-nav__item--center.mb-nav__item--active .mb-nav__icon {
  background: #1d4ed8;
}

@media (max-width: 1023px) {
  .mb-nav { display: flex; }
}
</style>