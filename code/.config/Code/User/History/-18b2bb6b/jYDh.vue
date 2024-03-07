<script setup lang="ts">
import { Form } from '@vuemodel/core'
import { NonConformance } from 'app/pinia-orm-models/models/NonConformance'
import { AUpdateDialog } from 'augment-quasar'
import NonConformanceForm from '../NonConformanceForm/NonConformanceForm.vue'

const form = defineModel<Form<NonConformance>>('form', { required: true })

</script>

<template>
  <AUpdateDialog>
    <NonConformanceForm v-model="form" />
  </AUpdateDialog>
</template>
