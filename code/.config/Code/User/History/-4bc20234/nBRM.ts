import { Model } from 'pinia-orm'
import { Uid, Attr } from 'pinia-orm/dist/decorators'

export class BaseDepartment extends Model {
  static entity = 'base_departments'
  static primaryKey = 'id'

  // fields
  @Uid() declare id: string | null
}
