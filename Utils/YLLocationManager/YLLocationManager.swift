//
//  YLLocationManager.swift
//  Driver
//
//  Created by ym on 2020/10/13.
//

import UIKit
import CoreLocation

typealias YLUpdateLocationsBlock = (_ locations: [CLLocation], _ isTrack: Bool)->Void
typealias YLUpdatingFailBlock = (_ error: Error)->Void
typealias YLMonitoringDidFailBlock = (_ error: Error)->Void
typealias YLReverseGeocodeCompletion = (_ rs: CLPlacemark)->Void

class YLLocationManager: NSObject {
    lazy var locationManager: CLLocationManager? = {
        if CLLocationManager.locationServicesEnabled() {
            let locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.distanceFilter = 50.0;
            return locationManager
        } else {
            return nil
        }
    } ();
    
    lazy var geoCoder: CLGeocoder = {
        return CLGeocoder();
    }();
    
    var updatingFailBlock: YLUpdatingFailBlock?;
    var monitoringDidFailBlock: YLMonitoringDidFailBlock?;
    var isTrack: Bool = false;
    
    private var didUpdateLocationsBlock: YLUpdateLocationsBlock?;
    private var reverseGeocodeCompletion: YLReverseGeocodeCompletion?;
    private var isAwalysRequest: Bool = false;
    private var isGeocode: Bool = false;
    
    override init() {
        super.init();
    }
    
    convenience init(_ block: @escaping YLUpdateLocationsBlock) {
        self.init();
        self.didUpdateLocationsBlock = block;
    }
    
    class func canUseLocationServices() -> Bool {
        if !CLLocationManager.locationServicesEnabled() || CLLocationManager.authorizationStatus() == .denied {
            let alertView = UIAlertController.alertView("为了保障你的权益,请打开定位功能", message: "", cancelButtonTitle: "取消", otherButtonTitles: ["去设置"]);
            alertView.tapIndexBlock = { (index) in
                UIApplication.shared.openURL(URL.init(string: UIApplication.openSettingsURLString)!);
            }
            alertView.show();
            return false
        } else {
            return true
        }
    }

    @discardableResult
    func startUpdatingLocation() -> Bool {
        return self.startUpdatingLocation(false);
    }
    
    @discardableResult
    func startUpdatingLocation(_ isTrack: Bool) -> Bool {
        if YLLocationManager.canUseLocationServices() {
            self.isTrack = isTrack;
            self.locationManager?.startUpdatingLocation();
            return true;
        }
        return false;
    }
    
    @discardableResult
    func startUpdatingLocation(_ isGeocode: Bool, handler: @escaping YLReverseGeocodeCompletion) -> Bool {
        self.reverseGeocodeCompletion = handler;
        self.isGeocode = isGeocode;
        return self.startUpdatingLocation(false);
    }
    
    func stopUpdatingLocation() {
        self.locationManager?.stopUpdatingLocation();
        self.isTrack = false;
    }
    
    func startMonitoringSignificantLocationChanges() {
        self.locationManager?.startMonitoringSignificantLocationChanges()
    }
    
    func stopMonitoringSignificantLocationChanges() {
        self.locationManager?.stopMonitoringSignificantLocationChanges()
    }
}

extension YLLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if isTrack == false {
            self.locationManager?.stopUpdatingLocation();
        }
        
        if self.didUpdateLocationsBlock != nil {
            self.didUpdateLocationsBlock!(locations, isTrack);
        }
        
        if isGeocode && locations.first != nil {
            let location: CLLocation = locations.first!;
            self.geoCoder.reverseGeocodeLocation(location) { (pls: [CLPlacemark]?, error: Error?)  in
                if error == nil {
                    guard ((pls?.last) != nil) else { return };
                    if self.reverseGeocodeCompletion != nil {
                        let rs: CLPlacemark = (pls?.last)!;
                        self.reverseGeocodeCompletion!(rs);
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if self.updatingFailBlock != nil {
            self.updatingFailBlock!(error)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        if self.monitoringDidFailBlock != nil {
            self.monitoringDidFailBlock!(error)
        }
    }
}
