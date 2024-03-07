<script setup lang="ts">
import { Form } from '@vuemodel/core'
import { NonConformance } from 'app/pinia-orm-models/models/NonConformance'
import { ACreateDialog } from 'augment-quasar'

const form = defineModel<Form<NonConformance>>('form', { required: true })

</script>

<template>
  <ACreateDialog>
    {{ form }}
  </ACreateDialog>
</template>
