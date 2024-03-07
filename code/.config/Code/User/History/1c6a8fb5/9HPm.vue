<script setup lang="ts">
import { Form } from '@vuemodel/core'
import { NonConformance } from 'app/pinia-orm-models/models/NonConformance'

const modelValue = defineModel<Form<NonConformance>>('modelValue', { required: true })
</script>

<template>
  <q-form>
    <q-input v-model="modelValue.created_on" />
  </q-form>
</template>
