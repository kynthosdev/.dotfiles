import { Model } from 'pinia-orm'
import { Uid, Attr } from 'pinia-orm/dist/decorators'

export class BaseNonConformance extends Model {
  static entity = 'base_non_conformances'
  static primaryKey = 'id'

  // fields
  @Attr() declare created_on: string | null
  @Attr() declare number: number | null
  @Attr() declare batch: string[] | null
  @Attr() declare qty: number | null
  @Attr() declare incident_description: string | null
  @Attr() declare comment: string | null
  @Uid() declare id: string | null
}
