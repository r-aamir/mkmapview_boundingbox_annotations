//
//  ViewController.swift
//  teatestr
//
//  Created by AamirR on 5/27/19.
//  Copyright © 2019 AamirR. All rights reserved.
//

import UIKit
import MapKit

extension MKCoordinateRegion {
    
    var boundingBoxCoordinates: [CLLocationCoordinate2D] {
        let halfLatDelta = self.span.latitudeDelta / 2
        let halfLngDelta = self.span.longitudeDelta / 2
        let topLeftCoord = CLLocationCoordinate2D(
            latitude: self.center.latitude + halfLatDelta,
            longitude: self.center.longitude - halfLngDelta
        )
        let bottomRightCoord = CLLocationCoordinate2D(
            latitude: self.center.latitude - halfLatDelta,
            longitude: self.center.longitude + halfLngDelta
        )
        let bottomLeftCoord = CLLocationCoordinate2D(
            latitude: self.center.latitude - halfLatDelta,
            longitude: self.center.longitude - halfLngDelta
        )
        let topRightCoord = CLLocationCoordinate2D(
            latitude: self.center.latitude + halfLatDelta,
            longitude: self.center.longitude + halfLngDelta
        )

        return [topLeftCoord, topRightCoord, bottomRightCoord, bottomLeftCoord]
    }
    
}

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    private let annotations: [MKPointAnnotation] = [MKPointAnnotation(), MKPointAnnotation(), MKPointAnnotation(), MKPointAnnotation()]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        self.customizeMapView()
        self.centerMapOnLocation(CLLocationCoordinate2D(latitude: 37.334922, longitude: -122.009033))
        self.mapView.addAnnotations(annotations)
    }

    func customizeMapView() {
        self.mapView.showsBuildings = true
        self.mapView.showsCompass = true
        self.mapView.showsPointsOfInterest = true
        self.mapView.showsUserLocation = false
        self.mapView.userTrackingMode = .none
        self.mapView.mapType = .satelliteFlyover
    }
    
    func centerMapOnLocation(_ coordinate: CLLocationCoordinate2D) {
        let spanRegion = MKCoordinateSpan(latitudeDelta: 0.0025, longitudeDelta: 0.0025)
        let mapRegion = MKCoordinateRegion(center: coordinate, span: spanRegion)
        mapView.setRegion(mapRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let bounds = mapView.region.boundingBoxCoordinates
        print("TopLeft: \(bounds[0])\nTopRight: \(bounds[1])\nBottomRight: \(bounds[3])\nBottomLeft: \(bounds[3])")
        for (i, coordinate) in bounds.enumerated() {
            self.annotations[i].coordinate = coordinate
        }
    }

}
