<script setup lang="ts">
import { NonConformance } from 'app/pinia-orm-models/models/NonConformance'
import { columns } from './columns'
import { mdiDelete, mdiPencil, mdiPlus } from '@quasar/extras/mdi-v7'

interface Props {
  notifications: NonConformance[]
}

defineProps<Props>()

const emit = defineEmits<{
  (event: 'create'): void
  (event: 'update', notification: NonConformance): void
  (event: 'delete', notification: NonConformance): void
}>()
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
        @click="emit('create')"
      />
    </template>

    <template #body-cell-update="scope">
      <td :props="scope">
        <q-btn
          round
          unelevated
          :icon="mdiPencil"
          color="blue-5"
          @click="emit('update', scope.row)"
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
          @click="emit('delete', scope.row)"
        />
      </td>
    </template>
  </q-table>
</template>
