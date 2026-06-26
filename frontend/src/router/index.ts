import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      name: 'home',
      component: () => import('../views/HomePage.vue'),
    },
    {
      path: '/registration',
      name: 'registration',
      component: () => import('../views/RegistrationPage.vue'),
    },
    {
      path: '/login',
      name: 'login',
      component: () => import('../views/LoginPage.vue'),
    },
    {
      path: '/account',
      name: 'account',
      component: () => import('../views/AccountPage.vue'),
    },
    {
      path: '/deposit',
      name: 'deposit',
      component: () => import('../views/DepositPage.vue'),
    },
    {
      path: '/withdraw',
      name: 'withdraw',
      component: () => import('../views/WithdrawPage.vue'),
    },
  ],
})

export default router