import { useUpdater } from '@vuemodel/core'
import { NonConformance } from 'app/pinia-orm-models/models/NonConformance'

export function useNotificationsUpdater () {
  const showDialog = ref(false)
  const updater = useUpdater(NonConformance, {
    onSuccess () {
      showDialog.value = false
    },
  })

  return {
    ...updater,
    showDialog,
  }
}
