//
//  LocationViewController.swift
//  CarFluent
//
//  Created by mac on 11/13/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import GoogleMaps
import SwiftLocation
//import LocationPickerViewController

class LocationViewController: UIViewController {

    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var locationSelected: String?
    
    let marker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        fetchData()
        
    }

    @IBAction func btnOkey(_ sender: Any) {
//        let locationPicker = LocationPicker()
//        locationPicker.pickCompletion = { (pickedLocationItem) in
//
//        }
//        self.navigationController?.pushViewController(locationPicker, animated: true)
        
//        guard let _ = self.locationSelected else {
//            showAlertError(message: "Pleace Enter The Reservation Date")
//            return
//        }
        
        self.lblLocation.text = locationSelected
        
        if let parent = self.parent as? AppointmentViewController {
            parent.location = lblLocation.text
        }
    }
    
}

extension LocationViewController {
    
    func setupView() {
        _ = LocationManager.shared.locateFromGPS(.continous, accuracy: .city) { result in
            switch result {
            case .failure(_):
                    break
            case .success(let location):
                self.lblLocation.text = "X: \(location.coordinate.latitude) Y: \(location.coordinate.longitude)"
                // Create a GMSCameraPosition that tells the map to display the
                let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15.0)
                self.mapView.camera = camera
                // Creates a marker in the center of the map.
                self.marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        //        marker.title = "Sydney"
        //        marker.snippet = "Australia"
                self.marker.map = self.mapView
                self.marker.isDraggable = true
                if let parent = self.parent as? AppointmentViewController {
                    parent.location = self.lblLocation.text
                }
            }
        }
    }
    
    func localized() {
        
    }
    
    func setupData() {
        
    }
    
    func fetchData() {
        
    }
    
}

extension LocationViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        locationSelected = "X: \(marker.position.latitude) Y: \(marker.position.longitude)"
    }
}

extension LocationViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "\u{f3c5}")
    }
}
