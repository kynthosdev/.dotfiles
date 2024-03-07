<script setup lang="ts">
import ManageNonConformancesTable from 'modules/NonConformance/components/ManageNonConformancesTable/ManageNonConformancesTable.vue'
import { useNonConformanceIndexer } from './useNonConformancesIndexer'

const nonConformanceIndexer = useNonConformanceIndexer()
</script>

<template>
  <div padding>
    <pre>{{ nonConformanceIndexer.records.value }}</pre>
    <!-- <ManageNonConformancesTable /> -->
  </div>
</template>
