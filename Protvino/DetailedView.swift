//
//  DetailedView.swift
//  Protvino
//
//  Created by Natalia D on 20.10.2023.
//

import SwiftUI
import CoreLocation

struct DetailedView: View {
    
    @Environment(\.presentationMode) var presentationMode
  //  @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: ViewModel
    
    var myAnnotation: MyAnnotation
    var location: Location
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Название")) {
                    Text(myAnnotation.title ?? "Unknown")
                }
                Section(header: Text("Описание")) {
                    Text(myAnnotation.info)
                }
                Section(header: Text("Фотографии")) {
                    ForEach(viewModel.locations) { location in 
                        if location.name == myAnnotation.title {
                            Image("\(location.id)-1")
                                .scaledToFit()
                       }
                    }
                }
            }
        }
    }
}

struct DetailedView_Previews: PreviewProvider {
    
    @State static var isLocationSelected = true
    
    static var testlocation = Location(id: 2, latitude: 54.875, longitude: 37.2151, name: "init", description: "test")
    static var testAnnotation = MyAnnotation(title: "init", info: "init", coordinate: CLLocationCoordinate2D(latitude: 54.867969, longitude: 37.215100))
    
    static var previews: some View {
     
        DetailedView(myAnnotation: testAnnotation, location: testlocation)
            .environmentObject(ViewModel())
    }
}
