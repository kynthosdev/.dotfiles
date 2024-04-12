import { Uid, Attr, HasMany } from 'pinia-orm/dist/decorators'
import { BaseDepartment } from '../base-models/BaseDepartment'
import { NonConformance } from './NonConformance'

export class Department extends BaseDepartment {
  // field

  // relationships
  @HasMany(() => NonConformance, 'notificationId') declare notifications: NonConformance[] | null
}