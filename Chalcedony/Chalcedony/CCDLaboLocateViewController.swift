//
//  CCDLaboLocateViewController.swift
//  Chalcedony
//
//  Created by S-Shimotori on 7/10/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit
import MapKit

class CCDLaboLocateViewController: UIViewController, MKMapViewDelegate, UISearchBarDelegate {

    private let initialLocation = (35.658774, 139.701361)
    private var mapItem = [MKMapItem]()

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()

        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBar.text
        request.region = mapView.region
        let search = MKLocalSearch(request: request)

        search.startWithCompletionHandler(){response, error in
            /*
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

            self.mapView.showAnnotations(self.mapView.annotations, animated: true)*/
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
}
