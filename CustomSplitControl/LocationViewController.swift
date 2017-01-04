//
//  LocationViewController.swift
//  CustomSplitControl
//
//  Created by Ignacio Nieto Carvajal on 3/1/17.
//  Copyright © 2017 Ignacio Nieto Carvajal. All rights reserved.
//

import UIKit
import MapKit

class PersonAnnotation: NSObject, MKAnnotation {
    // data
    var personName: String
    var personAddress: String
    var coordinate: CLLocationCoordinate2D
    
    init(person: Person, coordinate: CLLocationCoordinate2D) {
        self.personName = person.name
        self.personAddress = person.address
        self.coordinate = coordinate
    }
    
    var title: String? { return personName }
    var subtitle: String? { return personAddress }
}

class LocationViewController: CustomSplitContentViewController, MKMapViewDelegate {
    // outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationLabel: UILabel!
    
    // data
    let geocoder = CLGeocoder()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateMapPosition()
        locationLabel.text = self.person.address.replacingOccurrences(of: ",", with: "\n")
        mapView.layer.cornerRadius = 4.0
    }

    func reverseGeoCodeForString(_ string: String, completion: ((_ success: Bool, _ placemark: CLPlacemark?, _ coordinates: CLLocationCoordinate2D?) -> Void)?) {
        geocoder.geocodeAddressString(string) { (placemarks, error) in
            if error == nil && placemarks != nil && placemarks!.count > 0 {
                for placemark in placemarks! {
                    if let coordinates = placemark.location?.coordinate , CLLocationCoordinate2DIsValid(coordinates) {
                        completion?(true, placemark, coordinates)
                        return
                    }
                }
            }
            completion?(false, nil, nil)
        }
    }
    
    func updateMapPosition() {
        if person.address == nil { return }
        
        reverseGeoCodeForString(self.person.address) { (success, placemark, coordinate) in
            if success && coordinate != nil && CLLocationCoordinate2DIsValid(coordinate!) {
                // center the map in the coordinate.
                let visibleRegion = MKCoordinateRegionMakeWithDistance(coordinate!, 10000, 10000)
                self.mapView.setRegion(self.mapView.regionThatFits(visibleRegion), animated: true)
                self.mapView.setCenter(coordinate!, animated: true)
                // add annotation for this person
                let annotation = PersonAnnotation(person: self.person, coordinate: coordinate!)
                self.mapView.removeAnnotations(self.mapView.annotations)
                self.mapView.addAnnotation(annotation)
            }
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "PersonAnnotation")
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PersonAnnotation")
            annotationView!.canShowCallout = true
        } else { annotationView!.annotation = annotation }
        
        return annotationView
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
