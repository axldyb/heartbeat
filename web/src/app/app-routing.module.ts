import { NgModule } from '@angular/core'
import { RouterModule, Routes } from '@angular/router'
import { HeartbeatMapComponent } from './heartbeat-map/heartbeat-map.component'

const routes: Routes = [{
  path: '',
  redirectTo: 'map',
  pathMatch: 'full',
}, {
  path: 'map',
  component: HeartbeatMapComponent,
}]

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
