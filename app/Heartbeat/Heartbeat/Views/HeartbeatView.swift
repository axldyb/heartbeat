//
//  HeartbeatView.swift
//  Heartbeat
//
//  Created by Aksel Dybdal on 22/02/2022.
//

import SwiftUI
import HeartbeatKit
import Logging
import MapKit

struct HeartbeatView: View {

    @EnvironmentObject private var heartbeatStore: HeartbeatStore

    var body: some View {
        VStack {
            HeartbeatMap()

            Text("Heartbeats: \(heartbeatStore.heartbeatCount)")
                .padding()
                .modifier(TitleModifier())
                .multilineTextAlignment(.center)

            HStack {
                Button("Create Heartbeat") {
                    heartbeatStore.createHeartbeat()
                }
                .buttonStyle(BlueButton())

                Button("Reconnect") {
                    heartbeatStore.reconnect()
                }
                .buttonStyle(BlueButton())
            }
            .padding()
        }
    }
}

struct HeartbeatView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            HeartbeatView()
                .environmentObject(HeartbeatStore())
        }
    }
}
