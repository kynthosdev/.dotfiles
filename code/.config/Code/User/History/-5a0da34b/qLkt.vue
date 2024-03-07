<script setup lang="ts">
import { Form } from '@vuemodel/core'
import { NonConformance } from 'app/pinia-orm-models/models/NonConformance'
import { ACreateDialog } from 'augment-quasar'
import { NonConformanceForm } from '../NonConformanceForm/NonConformanceForm.vue'
const form = defineModel<Form<NonConformance>>('form', { required: true })

</script>

<template>
  <ACreateDialog>
    <NonConformanceForm v-model="form" />
  </ACreateDialog>
</template>
