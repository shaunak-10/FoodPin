//
//  MapViewController.swift
//  FoodPin
//
//  Created by Shaunak Mehta on 08/06/23.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        

            // Convert address to coordinate and annotate it on map
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(restaurant.location, completionHandler: { placemarks, error in
                if let error = error {
                    print(error)
                    return
                }

                if let placemarks = placemarks {
                    // Get the first placemark
                    let placemark = placemarks[0]

                    // Add annotation
                    let annotation = MKPointAnnotation()
                    annotation.title = self.restaurant.name
                    annotation.subtitle = self.restaurant.type

                    if let location = placemark.location {
                        annotation.coordinate = location.coordinate

                        // Display the annotation
                        self.mapView.showAnnotations([annotation], animated: true)
                        self.mapView.selectAnnotation(annotation, animated: true)
                    }
                }
            })
        
        mapView.delegate = self
        
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        
        


           
    }
    
    @IBOutlet var mapView: MKMapView!

    var restaurant = Restaurant()


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation:

                 MKAnnotation) -> MKAnnotationView? {
                         let identifier = "MyMarker"

                         if annotation.isKind(of: MKUserLocation.self) {
                             return nil
                         }

                         // Reuse the annotation if possible
                         var annotationView: MKMarkerAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView

                         if annotationView == nil {
                             annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                         }

                         annotationView?.glyphText = "😋"
                         annotationView?.markerTintColor = UIColor.orange

                         return annotationView
                     }
    }

                 
