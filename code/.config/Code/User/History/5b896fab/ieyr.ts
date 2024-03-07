import { Uid, Attr, HasMany } from 'pinia-orm/dist/decorators'
import { BaseDepartment } from '../base-models/BaseDepartment'

export class Department extends BaseDepartment {
  // field

  // relationships
  @HasMany(() => Notification, 'departmentId') declare notifications: Noti[] | null
}
