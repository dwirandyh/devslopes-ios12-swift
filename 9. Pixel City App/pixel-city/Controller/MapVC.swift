//
//  MapVC.swift
//  pixel-city
//
//  Created by Dwi Randy Herdinanto on 07/09/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    var locationManager: CLLocationManager = CLLocationManager()
    let authorizationStatus: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 1000
    let annotation = MKPointAnnotation()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.locationManager.delegate = self
        configureLocationService()
    }

    @IBAction func centerMapButtonPressed(_ sender: Any) {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMapOnUserLocation()
        }
    }
}

extension MapVC: MKMapViewDelegate {
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: self.regionRadius * 2.0, longitudinalMeters: self.regionRadius * 2.0)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension MapVC: CLLocationManagerDelegate {

    func configureLocationService() {
        if self.authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            locationManager.startUpdatingLocation()
            return
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.centerMapOnUserLocation()
    }
}
