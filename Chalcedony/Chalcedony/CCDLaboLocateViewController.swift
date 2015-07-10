//
//  CCDLaboLocateViewController.swift
//  Chalcedony
//
//  Created by S-Shimotori on 7/10/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit
import MapKit

class CCDLaboLocateViewController: UIViewController, MKMapViewDelegate {

    private let initialLocation = (35.658774, 139.701361)

    @IBOutlet weak var mapView: MKMapView!
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
