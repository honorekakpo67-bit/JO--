import { createApp } from 'vue'
import { createPinia } from 'pinia'
import router from './router'
import App from './App.vue'
import './assets/1xbet.css'
import './assets/1xbet-layout.css'
import './assets/responsive.css'

const app = createApp(App)
app.use(createPinia())
app.use(router)
app.mount('#app')
