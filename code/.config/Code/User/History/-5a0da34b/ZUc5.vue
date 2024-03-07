<script setup lang="ts">
import { Form } from '@vuemodel/core'
import { ACreateDialog } from 'augment-quasar'

const form = defineModel<Form<>>('form', { required: true })

</script>

<template>
  <ACreateDialog>
    <h1>
      CreateNonConformanceDialog
    </h1>
  </ACreateDialog>
</template>
