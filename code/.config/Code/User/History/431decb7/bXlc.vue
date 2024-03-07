<script setup lang="ts">
import ManageNonConformancesTable from 'modules/NonConformance/components/ManageNonConformancesTable/ManageNonConformancesTable.vue'
import { useNonConformanceIndexer } from './useNonConformancesIndexer'

const NonConformanceIndexer = useNonConformanceIndexer()
</script>

<template>
  <div padding>
    {{ indexer.records.value }}
    <!-- <ManageNonConformancesTable /> -->
  </div>
</template>
