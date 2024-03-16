//
//  Model.swift
//  Protvino
//
//  Created by Natalia D on 21.10.2023.
//

import Foundation
import MapKit

struct Location: Identifiable, Codable, Equatable, Hashable {
    
    var id: Int
    var latitude: Double
    var longitude: Double
    var name:  String
    var description: String
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
}

