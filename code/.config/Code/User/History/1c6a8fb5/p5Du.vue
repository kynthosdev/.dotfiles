<script setup lang="ts">
import { Form } from '@vuemodel/core'
import { NonConformance } from 'app/pinia-orm-models/models/NonConformance'
import { ADateTime } from 'augment-quasar'

const modelValue = defineModel<Form<NonConformance>>('modelValue', { required: true })
</script>

<template>
  <q-form>
    <ADateTime />
    <q-input v-model="modelValue." />
  </q-form>
</template>
