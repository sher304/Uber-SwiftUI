//
//  HomeView.swift
//  Uber
//
//  Created by Шермат Эшеров on 3/2/24.
//

import SwiftUI

struct HomeView: View {
    @State private var mapState = MapViewState.noInput
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                UberMapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                
                if mapState == .searchingForLocation {
                    LocationSearchView(mapState: $mapState)
                } else if mapState == .noInput{
                    MapViewActionButton(mapState: $mapState)
                        .padding(.leading, 20)
                        .padding(.top)
                    
                    LocationSearchActivationView()
                        .padding(.top, 72)
                        .onTapGesture {
                            withAnimation(.spring(dampingFraction: 0.4)) {
                                mapState = .searchingForLocation
                            }
                        }
                } else {
                    MapViewActionButton(mapState: $mapState)
                        .padding(.leading, 20)
                        .padding(.top)
                }
            }
            
            
            if mapState == .locationSelected || mapState == .routeAdded{
                RideRequestView()
                    .transition(.move(edge: .bottom))
                    .gesture(
                        DragGesture()
                            .onEnded({ action in
                                if action.translation.height > 100 {
                                    withAnimation(.spring(dampingFraction: 0.7)) {
                                        mapState = .noInput
                                    }
                                }
                            })
                    )
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .onReceive(LocationManager.shared.$userLocation, perform: { location in
            if let location = location {
                locationViewModel.userLocation = location
            }
        })
    }
}

#Preview {
    HomeView()
}
