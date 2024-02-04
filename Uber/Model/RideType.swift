//
//  RideType.swift
//  Uber
//
//  Created by Шермат Эшеров on 4/2/24.
//

import Foundation


enum RideType: Int, CaseIterable, Identifiable {
    case uberX
    case uberBlack
    case uberXL
    
    var id: Int { return rawValue }
    
    var description: String {
        switch self {
        case .uberX:
            return "Uber X"
        case .uberBlack:
            return "Uber Black"
        case .uberXL:
            return "Uber XL"
        }
    }
    
    var imageName: String {
        switch self {
        case .uberBlack:
            return "uber-black"
        case .uberX:
            return "uber-x"
        case .uberXL:
            return "uber-x"
        }
    }
    
    var baseFare: Double {
        switch self {
        case .uberBlack:
            return 20
        case .uberX:
            return 15
        case .uberXL:
            return 25
        }
    }
    
    func computePrice(distanceInMeter: Double) -> Double {
        let distanceInMiles = distanceInMeter / 1600
        switch self {
        case .uberBlack:
            return distanceInMiles * 2.0 + baseFare
        case .uberX:
            return distanceInMiles * 1.5 + baseFare
        case .uberXL:
            return distanceInMiles * 2.2 + baseFare
        }
    }
}
