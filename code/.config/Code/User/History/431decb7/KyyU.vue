<script setup lang="ts">
import ManageNonConformancesTable from 'modules/NonConformance/components/ManageNonConformancesTable/ManageNonConformancesTable.vue'
import { useCreator, useIndexer } from '@vuemodel/core'
import { NonConformance } from 'app/pinia-orm-models/models/NonConformance'

</script>

<template>
  <div padding>
    {{ indexer.records.value }}
    <!-- <ManageNonConformancesTable /> -->
  </div>
</template>
