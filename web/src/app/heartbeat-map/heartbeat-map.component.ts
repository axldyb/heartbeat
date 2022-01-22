import { Component, OnInit } from '@angular/core'
import { HttpClient } from '@angular/common/http'

interface Client {
  id: string
  name: string
  version: string
}

interface Device {
  id: string
  name: string
  os: string
  osVersion: string
  model: string
  language: string
}

interface Location {
  city: string
  region: string
  country: string
  latitude: number
  longitude: number
  org: string
  postal: string
  timezone: string
}

interface Heartbeat {
  id: string
  timestamp: any // google timestapm, fix
  client: Client
  device: Device
  location: Location
}

@Component({
  selector: 'app-heartbeat-map',
  templateUrl: './heartbeat-map.component.html',
  styleUrls: ['./heartbeat-map.component.css']
})
export class HeartbeatMapComponent implements OnInit {

  public heartbeatsCount = 0
  public heartbeats: GeoJSON.FeatureCollection
  public selectedCluster: { geometry: GeoJSON.Point; properties: any }

  constructor(
    private http: HttpClient
  ) {
    //
  }

  ngOnInit() {
    this.updateHeartbeatList()
  }

  selectCluster(event: MouseEvent, feature: any) {
    event.stopPropagation() // This is needed, otherwise the popup will close immediately
    // Change the ref, to trigger mgl-popup onChanges (when the user click on the same cluster)
    this.selectedCluster = {
      geometry: feature.geometry,
      properties: feature.properties,
    }
  }

  private async updateHeartbeatList(): Promise<void> {
    const fetchedHeartbeats = await this.getHeartbeats()
    const heartbeatFeatures = fetchedHeartbeats.map(this.mapHeartbeatToMapFeature)
    this.heartbeatsCount = fetchedHeartbeats.length
    this.heartbeats = {
      type: 'FeatureCollection',
      features: heartbeatFeatures,
    }
  }

  private mapHeartbeatToMapFeature(heartbeat: Heartbeat): GeoJSON.Feature<GeoJSON.Geometry, { [name: string]: any }> {
    return {
      type: 'Feature',
      properties: {
        title: heartbeat.client.name,
        subTitle: `${heartbeat.location.city}, ${heartbeat.location.region}, ${heartbeat.location.country}`
      },
      geometry: {
        type: 'Point',
        coordinates: [heartbeat.location.longitude, heartbeat.location.latitude]
      }
    }
  }

  private async getHeartbeats(): Promise<Heartbeat[]> {
    return this.http.get('http://heartbeat.axldyb.com:8080/api/heartbeats').toPromise().then(object => {
      const heartbeatsList = object['heartbeats']
      return heartbeatsList.map(heartbeatItem => {
        return heartbeatItem as Heartbeat
      })
    })
  }
}
