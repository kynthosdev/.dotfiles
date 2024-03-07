import { useCreator } from '@vuemodel/core'
import { NonConformance } from 'app/pinia-orm-models/models/NonConformance'

export function useNotificationsCreator () {
  const creator = useCreator(NonConformance, {
    onSuccess () {
      showDialog.value = false
    },
  })

  const showDialog = ref(false)

  return {
    ...creator,
    showDialog,
  }
}
