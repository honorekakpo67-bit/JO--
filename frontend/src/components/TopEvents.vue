<script setup lang="ts">
interface TopEvent {
  home: string
  away: string
  hScore: number
  aScore: number
  odds1: number
  oddsX: number
  odds2: number
}

defineProps<{ events: TopEvent[] }>()
</script>

<template>
  <div class="te">
    <div class="te-head">
      <span class="te-title">TOP-EVENTS</span>
      <div class="te-tabs">
        <span class="te-tab te-tab--active">HOT</span>
        <span class="te-tab">WC2026</span>
        <span class="te-tab">IEM Cologne</span>
      </div>
    </div>
    <div class="te-scroll">
      <div v-for="(e, i) in events" :key="i" class="te-card">
        <div class="te-matchup">
          <span class="te-team"><span class="te-dot" />{{ e.home }}</span>
          <span class="te-vs">{{ e.hScore }}:{{ e.aScore }}</span>
          <span class="te-team">{{ e.away }}</span>
        </div>
        <div class="te-odds">
          <button class="te-odd">1 {{ e.odds1.toFixed(2) }}</button>
          <button class="te-odd">X {{ e.oddsX.toFixed(2) }}</button>
          <button class="te-odd">2 {{ e.odds2.toFixed(2) }}</button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.te {
  background: #fff;
  border-radius: var(--radius);
  box-shadow: var(--shadow);
  margin-bottom: 6px;
}

.te-head {
  display: flex;
  align-items: center;
  padding: 8px 10px;
  gap: 12px;
  border-bottom: 1px solid #f0f1f3;
}

.te-title {
  font-size: 11px;
  font-weight: 700;
  color: hsl(208, 62%, 40%);
  letter-spacing: 0.5px;
}

.te-tabs { display: flex; gap: 4px; }

.te-tab {
  font-size: 11px;
  padding: 2px 8px;
  border-radius: 3px;
  color: #999;
  cursor: pointer;
}

.te-tab--active { background: hsl(208, 62%, 40%); color: #fff; }

.te-scroll {
  display: flex;
  gap: 6px;
  padding: 8px 10px;
  overflow-x: auto;
  scrollbar-width: none;
}

.te-scroll::-webkit-scrollbar { display: none; }

.te-card {
  flex-shrink: 0;
  width: 200px;
  background: #f8f9fb;
  border-radius: 4px;
  padding: 8px;
}

.te-matchup {
  display: flex;
  align-items: center;
  gap: 4px;
  margin-bottom: 6px;
  font-size: 11px;
}

.te-team {
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  display: flex;
  align-items: center;
  gap: 3px;
}

.te-dot {
  width: 4px; height: 4px;
  border-radius: 50%;
  background: var(--live-red);
  flex-shrink: 0;
}

.te-vs {
  font-weight: 700;
  font-size: 12px;
  color: hsl(208, 62%, 40%);
}

.te-odds {
  display: flex;
  gap: 2px;
}

.te-odd {
  flex: 1;
  font-size: 11px;
  font-weight: 600;
  padding: 3px 4px;
  background: #fff;
  border: 1px solid #e0e2e6;
  border-radius: 2px;
}

.te-odd:hover { background: #eaf7ea; border-color: var(--accent); }
</style>
