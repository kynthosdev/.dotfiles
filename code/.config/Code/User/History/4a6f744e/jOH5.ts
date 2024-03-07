import { UseIndexerReturn, useCreator } from '@vuemodel/core'
import { NonConformance } from 'app/pinia-orm-models/models/NonConformance'

export function useNotificationsCreator (
  notificationIndexer: UseIndexerReturn<typeof NonConformance>,
) {
  const creator = useCreator(NonConformance, {
    onSuccess () {
      showDialog.value = false
      notificationIndexer.index()
    },
  })

  const showDialog = ref(false)

  return {
    ...creator,
    showDialog,
  }
}
