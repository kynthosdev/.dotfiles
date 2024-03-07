import { Uid, Attr, HasOne, BelongsTo } from 'pinia-orm/dist/decorators'
import { Department } from './Department'
import { BaseNotification } from '../base-models/BaseNotification'

export class Notification extends BaseNotification {
  // fields
  @Attr() declare departmentId: string | null

  // relationships
  @BelongsTo(() => Department, 'departmentId') declare department: Department | null
}
