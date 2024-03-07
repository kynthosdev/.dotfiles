import { NonConformance } from 'app/pinia-orm-models/models/NonConformance'
import { QTableColumn } from 'quasar'

export const columns: QTableColumn[] = [
  {
    name: 'created_on',
    field: 'created_on',
    label: 'Date',
    align: 'left',
  },
  {
    name: 'number',
    field: 'number',
    label: 'Notification',
    align: 'left',
  },
  {
    name: 'qty',
    field: 'qty',
    label: 'Qty',
    align: 'left',
  },
  {
    name: 'incident_description',
    field: 'incident_description',
    label: 'Description',
    align: 'left',
  },
  {
    name: 'batch',
    field: (row: NonConformance) => row.batch,
    label: 'Batch',
    align: 'left',
  },
  {
    name: 'comment',
    field: 'comment',
    label: 'Comment',
    align: 'left',
  },
]
