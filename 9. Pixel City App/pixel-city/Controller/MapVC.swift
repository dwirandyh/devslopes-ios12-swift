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
import Alamofire
import AlamofireImage

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

    var flowLayout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView?

    var imageUrlArray = [String]()
    var imageArray = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.locationManager.delegate = self
        self.configureLocationService()
        self.addDoubleTap()

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView?.register(PhotoCell.self, forCellWithReuseIdentifier: "photoCell")
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        pullUpView.addSubview(collectionView!)
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
        cancelAllSessions()

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

        collectionView?.addSubview(spinner!)
    }

    func removeSpinner() {
        if spinner != nil {
            spinner?.removeFromSuperview()
        }
    }

    func addProgressLabel() {
        progressLabel = UILabel()
        progressLabel?.frame = CGRect(x: (screenSize.width / 2) - 100, y: 175, width: 200, height: 40)
        progressLabel?.font = UIFont(name: "Avenir Next", size: 18)
        progressLabel?.textColor = #colorLiteral(red: 0.2588235294, green: 0.2666666667, blue: 0.3215686275, alpha: 1)
        progressLabel?.textAlignment = .center
        progressLabel?.text = ""
        collectionView?.addSubview(progressLabel!)
    }

    func removeProgressLabel(){
        if progressLabel != nil {
            progressLabel?.removeFromSuperview()
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
        removeProgressLabel()
        cancelAllSessions()

        imageUrlArray = []
        imageArray = []

        collectionView?.reloadData()
        
        animateViewUp()
        addSwipe()
        addSpinner()
        addProgressLabel()

        let touchPoint = sender.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)

        let annotation = DroppablePin(coordinate: touchCoordinate, identifier: "droppablePin")
        mapView.addAnnotation(annotation)

        self.centerMapOnUserLocation(coordinate: touchCoordinate)

        retrieveUrls(forAnnotation: annotation) { (finished) in
            if finished {
                self.retrieveImages { (finished) in
                    if finished {
                        self.removeSpinner()
                        self.removeProgressLabel()
                        self.collectionView?.reloadData()
                    }
                }
            }
        }
    }

    func removePin(){
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
    }

    func retrieveUrls(forAnnotation annotation: DroppablePin, handler: @escaping (_ status: Bool) -> Void) {
        AF.request(flickrUrl(forApiKey: apiKey, withAnnotation: annotation, andNumberOfPhotos: 40))
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    guard let json = value as? Dictionary<String, AnyObject> else { return }
                    let photosDict = json["photos"] as! Dictionary<String, AnyObject>
                    let photoDictArray = photosDict["photo"] as! [Dictionary<String, AnyObject>]

                    for photo in photoDictArray {
                        let postUrl = "https://live.staticflickr.com/\(photo["server"]!)/\(photo["id"]!)_\(photo["secret"]!)_z.jpg"
                        self.imageUrlArray.append(postUrl)
                    }
                case .failure(let error):
                    print(error)
                }

                handler(true)
        }
    }

    func retrieveImages(handler: @escaping (_ status: Bool) -> Void) {
        for url in imageUrlArray {
            AF.request(url).responseImage { (response) in
                switch response.result {
                case .success(let value):
                    self.imageArray.append(value)
                    self.progressLabel?.text = "\(self.imageArray.count)/40 Images Downloaded"

                    if self.imageArray.count == self.imageUrlArray.count {
                        handler(true)
                    }

                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func cancelAllSessions() {
        Alamofire.Session.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach({ $0.cancel() })
            downloadData.forEach({ $0.cancel() })
        }
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

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.centerMapOnUserLocation()
    }
}

extension MapVC: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        let imageFromIndex = imageArray[indexPath.row]
        let imageView = UIImageView(image: imageFromIndex)
        cell.addSubview(imageView)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let popVC = storyboard?.instantiateViewController(identifier: "PopVC") as? PopVC else { return }
        popVC.initData(forImage: imageArray[indexPath.row])
        present(popVC, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            let share = UIAction(title: "Show", image: UIImage(systemName: "magnifyingglass")) { action in
                if let popVC = self.storyboard?.instantiateViewController(identifier: "PopVC") as? PopVC {
                    popVC.initData(forImage: self.imageArray[indexPath.row])
                    self.present(popVC, animated: true, completion: nil)
                }
            }
            return UIMenu(title: "", children: [share])
        }
    }
}
