//
//  SearchViewModel.swift
//  Uber
//
//  Created by Шермат Эшеров on 3/2/24.
//

import Foundation


import MapKit


final class LocationSearchViewModel: NSObject, ObservableObject {
    
    // MARK: Properties
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedLocationCoordinate: DestinationModel?
    @Published var pickUpTime: String?
    @Published var dropOffTime: String?
    
    var userLocation: CLLocationCoordinate2D?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    // MARK: Init
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    // MARK: Public Func
    func selectLocation(location: MKLocalSearchCompletion) {
        locationSearch(localSearch: location) { response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.selectedLocationCoordinate = DestinationModel(title: location.title,
                                                               cooridnate: coordinate)
        }
    }
    
    func locationSearch(localSearch: MKLocalSearchCompletion,
                        completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }
    
    func computeRidePrice(type: RideType) -> Double {
        guard let destinationCoordinate = selectedLocationCoordinate?.cooridnate else { return 0}
        guard let userCoordinate = self.userLocation else { return 0}
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude,
                                      longitude: userCoordinate.longitude)
        
        let destination = CLLocation(latitude: destinationCoordinate.latitude,
                                     longitude: destinationCoordinate.longitude)
        
        let tripDistanceMeter = userLocation.distance(from: destination)
        return type.computePrice(distanceInMeter: tripDistanceMeter)
    }
    
    func getDestinationRoute(userLocation: CLLocationCoordinate2D,
                             destination: CLLocationCoordinate2D,
                             completion: @escaping(MKRoute) -> Void) {
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let request = MKDirections.Request()
        let destPlaceMark = MKPlacemark(coordinate: destination)
        request.source = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: destPlaceMark)
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let error = error {
                print(error.localizedDescription, "error")
            }
            
            guard let route = response?.routes.first else { return }
            self.configurePickAndDropTime(expectedTime: route.expectedTravelTime)
            completion(route)
        }
    }
    
    func configurePickAndDropTime(expectedTime: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        self.pickUpTime = formatter.string(from: Date())
        self.dropOffTime = formatter.string(from: Date() + expectedTime)
    }
}


// MARK: MKLocalSearchCompleterDelegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
