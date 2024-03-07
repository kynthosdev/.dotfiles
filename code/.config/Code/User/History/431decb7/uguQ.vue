<script setup lang="ts">
import ManageNonConformancesTable from 'modules/NonConformance/components/ManageNonConformancesTable/ManageNonConformancesTable.vue'
import { useNotificationsIndexer } from './useNotificationsIndexer'
import { useNotificationsCreator } from './useNotificationsCreator'
import { useNotificationsUpdater } from './useNotificationsUpdater'
import { useNotificationsDestroyer } from './useNotificationsDestroyer'
import CreateNonConformanceDialog from 'modules/NonConformance/components/CreateNonConformanceDialog/CreateNonConformanceDialog.vue'
import UpdateNonConformanceDialog from 'modules/NonConformance/components/UpdateNonConformanceDialog/UpdateNonConformanceDialog.vue'

const notificationsIndexer = useNotificationsIndexer()
const notificationCreator = useNotificationsCreator(notificationsIndexer)
const notificationUpdater = useNotificationsUpdater()
const notificationDestroyer = useNotificationsDestroyer()
</script>

<template>
  <div padding>
    <ManageNonConformancesTable
      title="Notifications"
      :loading="notificationsIndexer.indexing.value"
      :notifications="notificationsIndexer.records.value"
      @destroy="notification => notificationDestroyer.destroy(notification.id ?? '')"
      @create="notificationCreator.showDialog.value=true"
      @update="async (notification) => {
        await notificationUpdater.makeForm(notification.id ?? '')
        notificationUpdater.showDialog.value=true
      }"
    />

    <CreateNonConformanceDialog
      v-model:form="notificationCreator.form.value"
      v-model="notificationCreator.showDialog.value"
      title="Create Notification"
      :creating="notificationCreator.creating.value"
      @create="notificationCreator.create()"
    />

    <UpdateNonConformanceDialog
      v-model:form="notificationUpdater.form.value"
      v-model="notificationUpdater.showDialog.value"
      title="Update Notification"
      :updating="notificationUpdater.updating.value"
      @update="notificationUpdater.update()"
    />
  </div>
</template>
