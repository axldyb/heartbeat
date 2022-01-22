import * as _ from 'lodash'
import { Component, Input, OnChanges, SimpleChanges, ViewChild } from '@angular/core'
import { MatPaginator, PageEvent } from '@angular/material/paginator'
import { GeoJSONSourceComponent } from 'ngx-mapbox-gl'

@Component({
  selector: 'showcase-cluster-popup',
  template: `
    <mat-list>
      <mat-list-item *ngFor="let leaf of leaves">
        {{ leaf.properties.subTitle }}
      </mat-list-item>
    </mat-list>
    <mat-paginator
      [length]="selectedCluster.properties?.point_count"
      [pageSize]="5"
      (page)="changePage($event)"
    ></mat-paginator>
  `,
})
export class ClusterPopupComponent implements OnChanges {
  @Input() selectedCluster: { geometry: GeoJSON.Point; properties: any }
  @Input() clusterComponent: GeoJSONSourceComponent

  @ViewChild(MatPaginator, { static: true }) paginator: MatPaginator

  leaves: GeoJSON.Feature<GeoJSON.Geometry>[]

  ngOnChanges(changes: SimpleChanges) {
    this.changePage()
    if (changes.selectedCluster && !changes.selectedCluster.isFirstChange()) {
      this.paginator.firstPage()
    }
  }

  async changePage(pageEvent?: PageEvent) {
    let offset = 0
    if (pageEvent) {
      offset = pageEvent.pageIndex * 5
    }
    const allLeaves = await this.clusterComponent.getClusterLeaves(
      this.selectedCluster.properties.cluster_id,
      5,
      offset
    )

    this.leaves = _.uniqBy(allLeaves, (l) => l.subTitle)
  }
}
