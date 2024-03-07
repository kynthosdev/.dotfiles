import { Uid, Attr, HasOne } from 'pinia-orm/dist/decorators'
import { BaseNonConformance } from '../base-models/BaseNonConformance'
import { Department } from './Department'

export class NonConformance extends BaseNonConformance {
  // fields
  // relationships
  @HasOne(() => Department, 'notificationId') declare department: Department | null
}
