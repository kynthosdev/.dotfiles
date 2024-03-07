import { Uid, Attr, HasOne, BelongsTo } from 'pinia-orm/dist/decorators'
import { Department } from './Department'
import { BaseNonConformance } from '../base-models/BaseNonConformance'

export class NonConformance extends BaseNonConformance {
  // fields
  @Attr() declare departmentId: string | null

  // relationships
  @BelongsTo(() => Department, 'departmentId') declare department: Department | null
}
