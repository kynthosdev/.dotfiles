import { useDestroyer } from '@vuemodel/core'
import { NonConformance } from 'app/pinia-orm-models/models/NonConformance'

export function useNotificationsDestroyer () {
  const detroyer = useDestroyer(NonConformance)

  return {
    ...detroyer,
  }
}
