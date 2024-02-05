//
//  MapViewActionButton.swift
//  Uber
//
//  Created by Шермат Эшеров on 3/2/24.
//

import SwiftUI

struct MapViewActionButton: View {
    
    @Binding var mapState: MapViewState
    @EnvironmentObject var viewModel: LocationSearchViewModel
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(dampingFraction: 0.4)){
                actionForState(state: mapState)
            }
        }, label: {
            Image(systemName: imageNameForState(state: mapState))
                .font(.title2)
                .foregroundStyle(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(radius: 6)
        })
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func actionForState(state: MapViewState) {
        switch state {
        case .noInput:
            print("no input")
        case .locationSelected, .routeAdded:
            mapState = .noInput
            viewModel.selectedLocationCoordinate = nil
        case .searchingForLocation:
            mapState = .noInput
        }
    }
    
    func imageNameForState(state: MapViewState) -> String {
        switch state {
        case .noInput:
            return "line.3.horizontal"
        case .locationSelected:
            return "arrow.left"
        default:
            return "arrow.left"
        }
    }
}

#Preview {
    MapViewActionButton(mapState: .constant(.locationSelected))
}
