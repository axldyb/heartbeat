import { BrowserModule } from '@angular/platform-browser'
import { NgModule } from '@angular/core'

import { AppRoutingModule } from './app-routing.module'
import { AppComponent } from './app.component'
import { HeartbeatMapComponent } from './heartbeat-map/heartbeat-map.component'

import { environment } from '../environments/environment'
import { NgxMapboxGLModule } from 'ngx-mapbox-gl'
import { HttpClientModule } from '@angular/common/http'
import { ClusterPopupComponent } from './heartbeat-map/cluster-popup/cluster-popup.component'

import { MatPaginatorModule } from '@angular/material/paginator'
import { MatListModule } from '@angular/material/list'

@NgModule({
  declarations: [
    AppComponent,
    HeartbeatMapComponent,
    ClusterPopupComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    MatPaginatorModule,
    MatListModule,
    NgxMapboxGLModule.withConfig({
      accessToken: environment.mapboxToken, // Optional, can also be set per map (accessToken input of mgl-map)
    }),
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
