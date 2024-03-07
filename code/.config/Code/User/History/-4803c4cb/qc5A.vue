<script setup lang="ts">
import { NonConformance } from 'app/pinia-orm-models/models/NonConformance'
import { columns } from './columns'
import { mdiDelete, mdiPencil, mdiPlus } from '@quasar/extras/mdi-v7'

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
    :columns="columns"
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

    <template #body-cell-update="scope">
      <td :props="scope">
        <q-btn
          round
          unelevated
          :icon="mdiPencil"
          color="blue-5"
        />
      </td>
    </template>

    <template #body-cell-delete="scope">
      <td :props="scope">
        <q-btn
          round
          unelevated
          :icon="mdiDelete"
          color="red-3"
        />
      </td>
    </template>
  </q-table>
</template>
