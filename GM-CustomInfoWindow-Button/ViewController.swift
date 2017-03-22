//
//  ViewController.swift
//  GM-CustomInfoWindow-Button
//
//  Created by Marla Na on 22/03/2017.
//
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    var tappedMarker : GMSMarker?
    var customInfoWindow : CustomInfoWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: 51.5287352, longitude: -0.3817818, zoom: 8)
        mapView.camera = camera
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 51.5287352, longitude: -0.3817818)
        marker.title = "My marker"
        marker.map = self.mapView
        
        let anotherMarker = GMSMarker()
        anotherMarker.position = CLLocationCoordinate2D(latitude: 52, longitude: -0.10)
        anotherMarker.title = "Another marker"
        anotherMarker.map = self.mapView

        self.tappedMarker = GMSMarker()
        self.customInfoWindow = CustomInfoWindow().loadView()
        
        self.mapView.delegate = self
    }

    
   func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        NSLog("marker was tapped")
        tappedMarker = marker
    
        //get position of tapped marker
        let position = marker.position
        mapView.animate(toLocation: position)
        let point = mapView.projection.point(for: position)
        let newPoint = mapView.projection.coordinate(for: point)
        let camera = GMSCameraUpdate.setTarget(newPoint)
        mapView.animate(with: camera)
    
        let opaqueWhite = UIColor(white: 1, alpha: 0.85)
        customInfoWindow?.layer.backgroundColor = opaqueWhite.cgColor
        customInfoWindow?.layer.cornerRadius = 8
        customInfoWindow?.center = mapView.projection.point(for: position)
        customInfoWindow?.center.y -= 140
        customInfoWindow?.customWindowLabel.text = "This is my Custom Info Window"
        self.mapView.addSubview(customInfoWindow!)
    
        return false
    }

   func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return UIView()
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        customInfoWindow?.removeFromSuperview()
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let position = tappedMarker?.position
        customInfoWindow?.center = mapView.projection.point(for: position!)
        customInfoWindow?.center.y -= 140
    }
}

