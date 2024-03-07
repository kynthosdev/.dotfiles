<script setup lang="ts">
import { Form } from '@vuemodel/core'
import { NonConformance } from 'app/pinia-orm-models/models/NonConformance'

const modelValue = defineModel<Form<NonConformance>>('modelValue', { required: true })
</script>

<template>
  <q-form>
    <q-card-section>
      <q-input
        v-model="modelValue.created_on"
        filled
        label="Date"
      />
      <q-input
        v-model="modelValue.number"
        filled
        label="Qty"
      />
      <q-input
        v-model="modelValue.qty"
        filled
        label="Date"
      />
      <q-input
        v-model="modelValue.incident_description"
        filled
        label="Date"
      />
      <q-input
        v-model="modelValue.comment"
        filled
        label="Date"
      />
    </q-card-section>
  </q-form>
</template>
