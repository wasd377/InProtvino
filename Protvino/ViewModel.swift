//
//  LocalData.swift
//  Protvino
//
//  Created by Natalia D on 17.10.2023.
//

import Foundation
import MapKit
import SwiftUI



class ViewModel : ObservableObject {
    @Published var locations: [Location] = []
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var selectedAnnotation: MyAnnotation?
    @Published var route: MKRoute?
    @Published var showDetails: Bool = false
    
    init() {
        loadLocalData()
    }
    
    
    func loadLocalData() {
        // find file with data
        if let url = Bundle.main.url(forResource: "locations", withExtension: "json") {
            // load file into string
            if let LocationsData = try? Data(contentsOf: url) {
                
                let LocalLocations = try? JSONDecoder().decode([Location].self, from: LocationsData)
                
                locations = LocalLocations ?? []
                
            }
        }
        }
    
    func getAnnotations() -> [MKAnnotation] {
        
        var annotations: [MKAnnotation] = []
        
        for location in locations {
            annotations.append(MyAnnotation(title: location.name, info: location.description, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)))
        }
        
        return annotations
    }
    

}

class MyAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var info: String
    init(title: String, info: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.info = info
        self.coordinate = coordinate
    }
}





