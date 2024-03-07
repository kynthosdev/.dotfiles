<script setup lang="ts">
import ManageNonConformancesTable from 'modules/NonConformance/components/ManageNonConformancesTable/ManageNonConformancesTable.vue'
import { useNonConformancesIndexer } from './useNonConformancesIndexer'

const nonConformancesIndexer = useNonConformancesIndexer()

</script>

<template>
  <div padding>
    {{ indexer.records.value }}
    <!-- <ManageNonConformancesTable /> -->
  </div>
</template>
