<script setup lang="ts">
import ManageNonConformancesTable from 'modules/NonConformance/components/ManageNonConformancesTable/ManageNonConformancesTable.vue'

const notificationsIndexer = useNotificationsIndexer()
</script>

<template>
  <div padding>
    <pre>{{ notificationsIndexer.records.value }}</pre>
    <!-- <ManageNonConformancesTable /> -->
  </div>
</template>
