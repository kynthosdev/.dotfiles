import { Model } from 'pinia-orm'
import { Uid, Attr } from 'pinia-orm/dist/decorators'

export class BaseNonConformance extends Model {
  static entity = 'base_non_conformances'
  static primaryKey = 'id'

  // fields
  @Uid() declare id: string | null
}
