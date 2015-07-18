//
//  CCDLaboLocateViewController.swift
//  Chalcedony
//
//  Created by S-Shimotori on 7/10/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CCDLaboLocateViewController: UIViewController, MKMapViewDelegate, UISearchBarDelegate, CLLocationManagerDelegate {

    private let initialLocation = (35.658774, 139.701361)
    private var mapItem = [MKMapItem]()

    private let locationManager = CLLocationManager()
    private var longitude: CLLocationDegrees! = 35.658774
    private var latitude: CLLocationDegrees! = 139.701361

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var buttonToIndicateLocation: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        let location = CLLocationCoordinate2DMake(initialLocation)
        mapView.setCenterCoordinate(location,animated:true)

        var region  = mapView.region
        region.center = location
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        mapView.setRegion(region,animated:true)
        mapView.mapType = .Standard

        searchBar.delegate = self

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 300

        buttonToIndicateLocation.addTarget(self, action: "touchUpInsideButtonToIndicateLocation:", forControlEvents: .TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!){
        println("update location")
        mapView.setCenterCoordinate(newLocation.coordinate, animated:true)
        var region  = mapView.region
        region.center = newLocation.coordinate
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        mapView.setRegion(region,animated:true)
        locationManager.stopUpdatingLocation()
    }

    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("fail update location")
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBar.text
        request.region = mapView.region
        let search = MKLocalSearch(request: request)

        search.startWithCompletionHandler(){response, error in
            self.mapItem.removeAll(keepCapacity: false)
            self.mapView.removeAnnotations(self.mapView.annotations)

            for item in response.mapItems {
                if let item = item as? MKMapItem {
                    let point = MKPointAnnotation()
                    point.coordinate = item.placemark.coordinate
                    point.title = item.placemark.name
                    point.subtitle = item.placemark.title
                    self.mapView.addAnnotation(point)
                    self.mapItem.append(item)
                }
            }

            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        }

    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func touchUpInsideButtonToIndicateLocation(sender: UIButton) {
        locationManager.startUpdatingLocation()
    }
}
