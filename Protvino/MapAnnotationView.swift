//
//  MapAnnotationView.swift
//  Protvino
//
//  Created by Natalia D on 20.10.2023.
//

import SwiftUI

struct MapAnnotationView: View {
    
    let location: Location
    
    @Binding var isLocationSelected: Bool
    
    var body: some View {
        Button(action: {
            
            isLocationSelected = true},
               
               label: {
            VStack {
                Image(systemName: "atom")
                    .resizable()
                    .foregroundColor(.blue)
                    .frame(width: 44, height: 44)
                    // .background(.white)
                    //.clipShape(Circle())
                
                Text(location.name)
                    .fixedSize()
                    .foregroundColor(.black)
            }
               })
        
                       
        
    }
}

struct MapAnnotationView_Previews: PreviewProvider {
    
   static var testlocation = Location(id: 2, latitude: 54.875, longitude: 37.2151, name: "test", description: "test")
    
    @State static var isLocationSelected = false

    
    static var previews: some View {
        MapAnnotationView(location: testlocation, isLocationSelected: $isLocationSelected)
    }
}
