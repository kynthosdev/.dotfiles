import { RouteRecordRaw } from 'vue-router'

export const main: RouteRecordRaw[] = [
  {
    name: 'non_conformance.manage',
    path: '/non_conformance',
    component: () => import('./pages/ManageNonConformancesPage/ManageNonConformancesPage.vue'),
  },
]