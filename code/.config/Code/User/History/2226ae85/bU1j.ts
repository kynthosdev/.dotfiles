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
    name: 'batch',
    field: 'batch',
    label: 'Batch',
    align: 'left',
  },
]
