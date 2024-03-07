<script setup lang="ts">
import ManageNonConformancesTable from 'modules/NonConformance/components/ManageNonConformancesTable/ManageNonConformancesTable.vue'
import { useNotificationsIndexer } from './useNotificationsIndexer'
import { useNotificationsCreator } from './useNotificationsCreator'
import { useNotificationsUpdater } from './useNotificationsUpdater'
import { useNotificationsDestroyer } from './useNotificationsDestroyer'

const notificationsIndexer = useNotificationsIndexer()
const notificationCreator = useNotificationsCreator()
const notificationUpdater = useNotificationsUpdater()
const notificationDestroyer = useNotificationsDestroyer()
</script>

<template>
  <div padding>
    <ManageNonConformancesTable
      title="Notifications"
      :loading="notificationsIndexer.indexing.value"
      :notifications="notificationsIndexer.records.value"
    />
  </div>
</template>
