import { Uid, Attr, HasOne, BelongsTo } from 'pinia-orm/dist/decorators'
import { BaseNonConformance } from '../base-models/BaseNonConformance'
import { Department } from './Department'

export class NonConformance extends BaseNonConformance {
  // fields
  @Attr() declare departmentId: string | null

  // relationships
  @BelongsTo(() => Department, 'departmentId') declare department: Department | null
}
