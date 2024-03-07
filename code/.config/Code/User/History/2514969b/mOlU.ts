import { useIndexer } from '@vuemodel/core'
import { NonConformance } from 'app/pinia-orm-models/models/NonConformance'

export function useNotificationsIndexer () {
  const indexer = useIndexer(NonConformance, {
    immediate: true,
  })

  return {
    ...indexer,
  }
}
