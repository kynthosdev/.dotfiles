<script setup lang="ts">
import { ACreateDialog } from 'augment-quasar'

const form = defineModel('form', { required: true })

</script>

<template>
  <ACreateDialog>
    <h1>
      CreateNonConformanceDialog
    </h1>
  </ACreateDialog>
</template>
