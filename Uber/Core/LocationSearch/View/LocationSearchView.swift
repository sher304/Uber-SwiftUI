//
//  LocationSearchView.swift
//  Uber
//
//  Created by Шермат Эшеров on 3/2/24.
//

import SwiftUI

struct LocationSearchView: View {
    
    @State private var startLocation = ""
    @Binding var mapState: MapViewState
    @EnvironmentObject var viewModel: LocationSearchViewModel
    
    var body: some View {
        VStack {
            //Header view
            ZStack {
                HStack {
                    Button(action: {
                        withAnimation(.spring(dampingFraction: 0.8)) {
                            mapState = .noInput
                        }
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color.theme.primaryTextColor)
                    })
                    
                    .padding(.leading)
                    Spacer()
                }
                
                Text("Your route")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            HStack {
                VStack {
                    Circle()
                        .fill(.gray)
                        .frame(width: 6, height: 6)
                    Rectangle()
                        .fill(.gray)
                        .frame(width: 1, height: 24)
                    Rectangle()
                        .fill()
                        .frame(width: 6, height: 6)
                }
                
                VStack {
                    TextField("Current Location",
                              text: $startLocation)
                    .frame(height: 32)
                    .background(.gray)
                    .padding(.trailing)
                    
                    TextField("Where to?",
                              text: $viewModel.queryFragment)
                    .frame(height: 32)
                    .background(.gray)
                    .padding(.trailing)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            Divider()
                .padding(.vertical)
            
            // List View
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.results, id: \.self) { data in
                        LocationSearchResultCell(
                            title: data.title,
                            subtitle: data.subtitle)
                        .onTapGesture {
                            withAnimation(.spring(dampingFraction: 0.7)) {
                                viewModel
                                    .selectLocation(location: data)
                                mapState = .locationSelected
                            }
                        }
                    }
                }
            }
        }
        .background(Color.theme.backgroundColor )
    }
}

#Preview {
    LocationSearchView(mapState: .constant(.noInput))
}
