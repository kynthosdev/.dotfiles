<script setup lang="ts">
import ManageNonConformancesTable from 'modules/NonConformance/components/ManageNonConformancesTable/ManageNonConformancesTable.vue'
import { useNotificationsIndexer } from './useNotificationsIndexer'

const notificationsIndexer = useNotificationsIndexer()
</script>

<template>
  <div padding>
    <ManageNonConformancesTable :notifications="notificationsIndexer.records.value" />
  </div>
</template>
