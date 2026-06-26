import { defineStore } from 'pinia'
import { ref, computed } from 'vue'

export interface BetEvent {
  id: string
  match: string
  selection: string
  odds: number
}

export const useBetSlipStore = defineStore('betSlip', () => {
  const events = ref<BetEvent[]>([])

  const totalOdds = computed(() =>
    events.value.reduce((acc, e) => acc * e.odds, 1)
  )

  const count = computed(() => events.value.length)

  function addEvent(event: BetEvent) {
    const existing = events.value.find((e) => e.id === event.id)
    if (!existing) {
      events.value.push(event)
    }
  }

  function removeEvent(id: string) {
    events.value = events.value.filter((e) => e.id !== id)
  }

  function clear() {
    events.value = []
  }

  return { events, totalOdds, count, addEvent, removeEvent, clear }
})
