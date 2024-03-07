<script setup lang="ts">
import ManageNonConformancesTable from 'modules/NonConformance/components/ManageNonConformancesTable/ManageNonConformancesTable.vue'
import { useCreator, useIndexer } from '@vuemodel/core'
import { NonConformance } from 'app/pinia-orm-models/models/NonConformance'

const indexer = useIndexer(NonConformance, { immediate: true })

const creator = useCreator(NonConformance)

creator.create(
  {
    // number: 60001234,
    // created_on: '2024/02/11',
    // batch: ['L24002'],
    // qty: 400,
    // incident_description: 'This is an incident',
    // comment: 'Lets get it solved',
  },
)

</script>

<template>
  <div padding>
    <!-- <ManageNonConformancesTable /> -->
  </div>
</template>
