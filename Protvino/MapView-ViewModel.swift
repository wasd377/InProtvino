import SwiftUI
import MapKit
import UIKit


struct MapView: UIViewRepresentable {
    
    typealias UIViewType = MKMapView
    
    @Binding var routeSelected: Bool?
    @Binding var showDetails: Bool
    @Binding var myAnnotation: MyAnnotation
    
    var annotations: [MKAnnotation] = []
    
    @EnvironmentObject var viewModel: ViewModel

    
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(showDetails: $showDetails, myAnnotation: $myAnnotation)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06)
        let mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 54.867969, longitude: 37.215100), span: mapSpan)
        mapView.setRegion(mapRegion, animated: true)
        
        mapView.addAnnotations(annotations)
              
        return mapView
    }
        
    func updateUIView(_ mapView: MKMapView, context: Context) {
        
       // checking that route was selected to update UIView
        if routeSelected == true {
            
            // Loading all route points to calculate route
            var points: [MKMapItem] = []
            let request = MKDirections.Request()
            
            for location in viewModel.locations {
                var newLocation = location
                newLocation.name = location.name
                newLocation.latitude = location.latitude
                newLocation.longitude = location.longitude
                points.append(MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: newLocation.latitude, longitude: newLocation.longitude))))
            }
            
            for i in 0...1 {
                
                request.source = points[i] //MKMapItem(placemark: MKPlacemark(coordinate: viewModel.locations[0].coordinate))
                request.destination = points[i+1] //MKMapItem(placemark: MKPlacemark(coordinate: viewModel.locations[1].coordinate))
                request.transportType = .walking
                
                let directions = MKDirections(request: request)
                
                directions.calculate { response, error in
                    guard let route = response?.routes.first else { return }
                    mapView.addOverlay(route.polyline, level: .aboveRoads)
                    mapView.setVisibleMapRect(
                        route.polyline.boundingMapRect,
                        edgePadding: UIEdgeInsets(top: 50, left: 100, bottom: 50, right: 100),
                       animated: true)
                }
            }
        } else if routeSelected == false {
            mapView.removeOverlays(mapView.overlays)
            let mapSpan = MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06)
            let mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 54.867969, longitude: 37.215100), span: mapSpan)
            mapView.setRegion(mapRegion, animated: true)
        }
        
        
    }
}

      

class MapViewCoordinator: UIViewController, MKMapViewDelegate {
    
    @Binding private var showDetails: Bool
    @Binding private var myAnnotation: MyAnnotation
    
    init(showDetails: Binding<Bool>, myAnnotation: Binding<MyAnnotation>) {
        self._showDetails = showDetails
        self._myAnnotation = myAnnotation
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
      
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      let renderer = MKPolylineRenderer(overlay: overlay)
      renderer.strokeColor = .systemBlue
      renderer.lineWidth = 5
      return renderer
    }
      
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
     
        guard annotation is MyAnnotation else { return nil }
        let identifier = "Location"
          var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
          if annotationView == nil {
              annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
              annotationView?.displayPriority = .required
          } else {
              annotationView?.annotation = annotation
              
          }
          return annotationView
      }
      
      func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

       view.canShowCallout = true
       view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
          
          
      }
      
      func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
          guard let annotation = view.annotation as? MyAnnotation else { return }
          myAnnotation = annotation
          showDetails = true
          print(myAnnotation.title ?? "Could not print name")
      }
  }








