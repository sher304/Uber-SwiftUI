//
//  RideRequestView.swift
//  Uber
//
//  Created by Шермат Эшеров on 4/2/24.
//

import SwiftUI

struct RideRequestView: View {
    @State private var selectedRideType: RideType = .uberX
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    
    var body: some View {
        VStack {
            Capsule()
                .foregroundStyle(.gray)
                .frame(width: 42, height: 6)
                .padding(.top, 8)
            // TRIP INFO
            
            HStack {
                VStack {
                    Circle()
                        .fill(.gray)
                        .frame(width: 8, height: 8)
                    Rectangle()
                        .fill(.gray)
                        .frame(width: 1, height: 32)
                    Rectangle()
                        .fill()
                        .frame(width: 8, height: 8)
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("Current location ")
                            .font(.system(size: 16))
                            .foregroundStyle(.gray)
                        
                        Spacer()
                        Text(locationViewModel.pickUpTime ?? "")
                            .font(.system(size: 14))
                            .foregroundStyle(.gray)
                    }
                    .padding(.bottom, 10)
                    
                    HStack {
                        if let locationTitle = locationViewModel.selectedLocationCoordinate?.title {
                            Text(locationTitle)
                                .font(.system(size: 16))
                        }
                        Spacer()
                        Text(locationViewModel.dropOffTime ?? "")
                            .font(.system(size: 14))
                    }
                    .fontWeight(.semibold)
                }
                .padding(.leading, 8)
            }
            .padding()
            
            Divider()
            
            // RIDE TYPE INFO
            
            Text("Select Type")
                .font(.headline)
                .fontWeight(.semibold)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(RideType.allCases, id: \.self) { data in
                        VStack(alignment: .leading) {
                            Image(data.imageName)
                                .resizable()
                                .scaledToFit()
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(data.description)
                                    .font(.system(size: 14, weight: .semibold))
                                Text(locationViewModel.computeRidePrice(type: data).toCurrency())
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .padding()
                        }
                        .shadow(radius: 10)
                        .frame(width: 112, height: 140)
                        .foregroundStyle(Color.theme.primaryTextColor)
                        .background(data == selectedRideType ? .blue : Color.theme.backgroundCar)
                        .scaleEffect(data == selectedRideType ? 1.2 : 1)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .onTapGesture {
                            withAnimation(.spring(dampingFraction: 0.6)) {
                                selectedRideType = data
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            
            Divider()
                .padding(.vertical)
            
            // PAYMENT INFO
            
            HStack(spacing: 12) {
                Text("VISA")
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.leading)
                
                Text("*****1234")
                    .fontWeight(.bold)
                
                Spacer()
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .frame(height: 50)
            .background(.green)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
            // CONFIRM RIDE
            
            Button {
                
            } label: {
                Text("CONFIRM RIDE")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
            }
            .frame(width: UIScreen.main.bounds.width - 32, height: 50)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(.bottom, 16)
        .background(Color.theme.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    RideRequestView()
}
