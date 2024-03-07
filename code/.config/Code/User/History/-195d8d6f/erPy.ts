import { useUpdater } from '@vuemodel/core'
import { NonConformance } from 'app/pinia-orm-models/models/NonConformance'

export function useNotificationsUpdater () {
  const updater = useUpdater(NonConformance)

  return {
    ...updater,
 useUpdater
}
