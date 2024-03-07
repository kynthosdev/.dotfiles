<script setup lang="ts">
import { NonConformance } from 'app/pinia-orm-models/models/NonConformance'
import { columns } from './columns'
import { mdiPlus } from '@quasar/extras/mdi-v7'

interface Props {
  notifications: NonConformance[]
}

defineProps<Props>()

// defineEmits<{
//   // (event: 'update:modelValue', payload: string): void
// }>()
</script>

<template>
  <q-table
    :rows="notifications"
  >
    <template #top-right>
      <q-btn
        round
        unelevated
        color="primary"
        :icon="mdiPlus"
      />
    </template>

    <template #body-cell-number="scope">
      <q-td :props="scope">
        <pre>{{ scope }}</pre>
      </q-td>
    </template>
  </q-table>
</template>
