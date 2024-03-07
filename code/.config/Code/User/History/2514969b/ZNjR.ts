import { useIndexer } from '@vuemodel/core'
import { NonConformance } from 'app/pinia-orm-models/models/NonConformance'

export function useNonConformanceIndexer () {
  const indexer = useIndexer(NonConformance, { immediate: true })

  return {
    ...indexer,
  }
}
