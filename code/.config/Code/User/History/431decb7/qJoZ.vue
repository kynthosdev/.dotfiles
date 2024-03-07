<script setup lang="ts">
import ManageNonConformancesTable from 'modules/NonConformance/components/ManageNonConformancesTable/ManageNonConformancesTable.vue'
import { useIndexer } from '@vuemodel/core'
import { NonConformance } from 'app/pinia-orm-models/models/NonConformance'

const indexer = useIndexer(NonConformance, { immediate: true })

</script>

<template>
  <div padding>
    <!-- <ManageNonConformancesTable /> -->
  </div>
</template>
