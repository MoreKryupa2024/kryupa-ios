//
//  APIClient.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 22/05/24.
//

import Foundation
import CoreLocation
import SwiftUI
import Combine
import MapKit

struct Test: View {
    let locationProvider = LocationProvider()
    @State var currentAddress = ""
    @State var userTap = CLLocationCoordinate2D()
    
    let position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 22.736201, longitude: 75.899992),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    var body: some View {
        Text(currentAddress)
        
        VStack{
            MapReader { proxy in
                Map(initialPosition: position){
                    Marker(coordinate: userTap) {
                        Label("", systemImage: "star")
                    }
                }
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            getAddress(latitude: coordinate.latitude, longitude: coordinate.longitude)
                        }
                    }
            }
        }
    }
    
    
    func getAddress(latitude: Double, longitude: Double) {
        // for testing  Tokyo
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        locationProvider.getPlace(for: location) { plsmark in
            guard let placemark = plsmark else { return }
            if let streetNumber = placemark.subThoroughfare,
               let street = placemark.subThoroughfare,
               let city = placemark.locality,
               let state = placemark.administrativeArea {
                self.currentAddress = "\(streetNumber) \(street) \(city) \(state)"
            } else if let city = placemark.locality, let state = placemark.administrativeArea {
                self.currentAddress = "\(city) \(state)"
            } else {
                self.currentAddress = "Address Unknown"
            }
        }
    }
    
}

/**
 A Combine-based CoreLocation provider.
 
 On every update of the device location from a wrapped `CLLocationManager`,
 it provides the latest location as a published `CLLocation` object and
 via a `PassthroughSubject<CLLocation, Never>` called `locationWillChange`.
 */
public class LocationProvider: NSObject, ObservableObject {
    
    private let lm = CLLocationManager()
    
    /// Is emitted when the `location` property changes.
    public let locationWillChange = PassthroughSubject<CLLocation, Never>()
    
    /**
     The latest location provided by the `CLLocationManager`.
     
     Updates of its value trigger both the `objectWillChange` and the `locationWillChange` PassthroughSubjects.
     */
    @Published public private(set) var location: CLLocation? {
        willSet {
            locationWillChange.send(newValue ?? CLLocation())
        }
    }
    
    /// The authorization status for CoreLocation.
    @Published public var authorizationStatus: CLAuthorizationStatus?
    
    /// A function that is executed when the `CLAuthorizationStatus` changes to `Denied`.
    public var onAuthorizationStatusDenied : ()->Void = {presentLocationSettingsAlert()}
    
    /// The LocationProvider intializer.
    ///
    /// Creates a CLLocationManager delegate and sets the CLLocationManager properties.
    public override init() {
        super.init()
        self.lm.delegate = self
        self.lm.desiredAccuracy = kCLLocationAccuracyBest
        self.lm.activityType = .fitness
        self.lm.distanceFilter = 10
        self.lm.allowsBackgroundLocationUpdates = true
        self.lm.pausesLocationUpdatesAutomatically = false
        self.lm.showsBackgroundLocationIndicator = true
    }
    
    /**
     Request location access from user.
     
     In case, the access has already been denied, execute the `onAuthorizationDenied` closure.
     The default behavior is to present an alert that suggests going to the settings page.
     */
    public func requestAuthorization() -> Void {
        if self.authorizationStatus == CLAuthorizationStatus.denied {
            onAuthorizationStatusDenied()
        }
        else {
            self.lm.requestWhenInUseAuthorization()
        }
    }
    
    /// Start the Location Provider.
    public func start() throws -> Void {
        self.requestAuthorization()
        
        if let status = self.authorizationStatus {
            guard status == .authorizedWhenInUse || status == .authorizedAlways else {
                throw LocationProviderError.noAuthorization
            }
        }
        else {
            /// no authorization set by delegate yet
#if DEBUG
            print(#function, "No location authorization status set by delegate yet. Try to start updates anyhow.")
#endif
            /// In principle, this should throw an error.
            /// However, this would prevent start() from running directly after the LocationProvider is initialized.
            /// This is because the delegate method `didChangeAuthorization`,
            /// setting `authorizationStatus` runs only after a brief delay after initialization.
            //throw LocationProviderError.noAuthorization
        }
        self.lm.startUpdatingLocation()
    }
    
    /// Stop the Location Provider.
    public func stop() -> Void {
        self.lm.stopUpdatingLocation()
    }
    
    // todo deal with errors
    public func getPlace(for location: CLLocation, completion: @escaping (CLPlacemark?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard error == nil else {
                print("=====> Error \(error!.localizedDescription)")
                completion(nil)
                return
            }
            guard let placemark = placemarks?.first else {
                print("=====> Error placemark is nil")
                completion(nil)
                return
            }
            completion(placemark)
        }
    }
    
}

/// Present an alert that suggests to go to the app settings screen.
public func presentLocationSettingsAlert(alertText : String? = nil) -> Void {
    let alertController = UIAlertController (title: "Enable Location Access", message: alertText ?? "The location access for this app is set to 'never'. Enable location access in the application settings. Go to Settings now?", preferredStyle: .alert)
    let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
        guard let settingsUrl = URL(string:UIApplication.openSettingsURLString) else {
            return
        }
        UIApplication.shared.open(settingsUrl)
    }
    alertController.addAction(settingsAction)
    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
    alertController.addAction(cancelAction)
    UIApplication.shared.windows[0].rootViewController?.present(alertController, animated: true, completion: nil)
}


/// Error which is thrown for lacking localization authorization.
public enum LocationProviderError: Error {
    case noAuthorization
}

extension LocationProvider: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
#if DEBUG
        print(#function, status.name)
#endif
        //print()
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clErr = error as? CLError {
            switch clErr {
            case CLError.denied : do {
                print(#function, "Location access denied by user.")
                self.stop()
                self.requestAuthorization()
            }
            case CLError.locationUnknown : print(#function, "Location manager is unable to retrieve a location.")
            default: print(#function, "Location manager failed with unknown CoreLocation error.")
            }
        }
        else {
            print(#function, "Location manager failed with unknown error", error.localizedDescription)
        }
    }
}

extension CLAuthorizationStatus {
    /// String representation of the CLAuthorizationStatus
    var name: String {
        switch self {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }
} // End Struct


#Preview {
    Test()
}
