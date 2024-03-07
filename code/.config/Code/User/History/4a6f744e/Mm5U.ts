import { useCreator } from '@vuemodel/core'
import { NonConformance } from 'app/pinia-orm-models/models/NonConformance'

export function useNotificationsCreator () {
  const creator = useCreator(NonConformance)

  return {
    ...creator,
  }
}
