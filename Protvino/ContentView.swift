//
//  ContentView.swift
//  Protvino
//
//  Created by Natalia D on 17.10.2023.
//

import SwiftUI
import MapKit
import UIKit

struct ContentView: View {

    @EnvironmentObject var viewModel: ViewModel
    
    @State private var testLocations: [Location] = [
        Location(id: 2, latitude: 54.875, longitude: 37.2151, name: "test", description: "test")
    ]
    @State var isLocationSelected = false
    @State private var routeSelected: Bool? = false
    @State var showDetails: Bool = false
    @State var myAnnotation: MyAnnotation = MyAnnotation(title: "init", info: "init", coordinate: CLLocationCoordinate2D(latitude: 54.867969, longitude: 37.215100))
    

    func getRoute() {

        if routeSelected == false {
            routeSelected = true
        } else {
            routeSelected = false
        }
        
    }

    var body: some View {
        
        NavigationView{
            
        
            MapView(routeSelected: $routeSelected, showDetails: $showDetails, myAnnotation: $myAnnotation, annotations: viewModel.getAnnotations())
                .ignoresSafeArea()
//                .background {
//                    NavigationLink("", destination: DetailedView(myAnnotation: myAnnotation), isActive: $showDetails)}
            
//                .navigationDestination(for: Location.self) { location in
//                    DetailedView(myAnnotation: myAnnotation, location: location)
//                }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if showDetails == false {
                        Button("False Route"){
                            getRoute()
                        }
                       // .buttonStyle(.borderedProminent)
                    }
                    else {
                        Button("TRUE Route"){
                            getRoute()
                        }
                    }
                }
//                    .padding()
//                    .background(.white)
                        
                    }
         
                }
                
            }
        }
        
    



struct ContentView_Previews: PreviewProvider {
    
    static var testlocation = Location(id: 2, latitude: 54.875, longitude: 37.2151, name: "test", description: "test")
    
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())

    }
}




