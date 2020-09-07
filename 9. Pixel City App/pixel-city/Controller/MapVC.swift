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

class MapVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pullUpViewHeight: NSLayoutConstraint!
    @IBOutlet weak var pullUpView: UIView!

    var locationManager: CLLocationManager = CLLocationManager()
    let authorizationStatus: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 1000
    let annotation = MKPointAnnotation()

    var screenSize = UIScreen.main.bounds

    var spinner: UIActivityIndicatorView?
    var progressLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.locationManager.delegate = self
        self.configureLocationService()
        self.addDoubleTap()
    }

    func addDoubleTap(){
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        mapView.addGestureRecognizer(doubleTap)
    }

    func animateViewUp() {
        pullUpViewHeight.constant = 300
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    func addSwipe() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(animateViewDown))
        swipe.direction = .down
        pullUpView.addGestureRecognizer(swipe)
    }

    @objc func animateViewDown() {
        pullUpViewHeight.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    func addSpinner() {
        spinner = UIActivityIndicatorView()
        spinner?.center = CGPoint(x: (screenSize.width / 2) - ((spinner?.frame.width)! / 2), y: 150)
        spinner?.style = .large
        spinner?.color = #colorLiteral(red: 0.2588235294, green: 0.2705882353, blue: 0.3058823529, alpha: 1)
        spinner?.startAnimating()

        pullUpView.addSubview(spinner!)
    }

    func removeSpinner() {
        if spinner != nil {
            spinner?.removeFromSuperview()
        }
    }

    @IBAction func centerMapButtonPressed(_ sender: Any) {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMapOnUserLocation()
        }
    }
}

extension MapVC: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }

        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "droppablePin")
        pinAnnotation.pinTintColor = #colorLiteral(red: 0.9607843137, green: 0.7098039216, blue: 0.1529411765, alpha: 1)
        pinAnnotation.animatesDrop = true
        return pinAnnotation
    }

    func centerMapOnUserLocation(coordinate: CLLocationCoordinate2D? = nil) {
        var locationCoordinate = locationManager.location?.coordinate
        if let customCoordinate = coordinate {
            locationCoordinate = customCoordinate
        }

        guard let centerCoordinate = locationCoordinate else { return }

        let coordinateRegion = MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: self.regionRadius * 2.0, longitudinalMeters: self.regionRadius * 2.0)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }

    @objc func dropPin(sender: UITapGestureRecognizer) {
        removePin()
        removeSpinner()
        
        animateViewUp()
        addSwipe()
        addSpinner()

        let touchPoint = sender.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)

        let annotation = DroppablePin(coordinate: touchCoordinate, identifier: "droppablePin")
        mapView.addAnnotation(annotation)

        self.centerMapOnUserLocation(coordinate: touchCoordinate)
    }

    func removePin(){
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
    }
}

extension MapVC: CLLocationManagerDelegate {

    func configureLocationService() {
        if self.authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            return
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.centerMapOnUserLocation()
    }
}
