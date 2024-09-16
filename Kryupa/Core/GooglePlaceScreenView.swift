//
//  GooglePlaceScreenView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 12/09/24.
//
import Foundation
import UIKit
import SwiftUI
import GooglePlaces


struct PlacePicker: UIViewControllerRepresentable {
    
    func makeCoordinator() -> GooglePlacesCoordinator {
        GooglePlacesCoordinator(self)
    }
    @Environment(\.presentationMode) var presentationMode
    @Binding var address: String
    @Binding var country: String
    @Binding var state: String
    @Binding var city: String
    @Binding var latitude: Double
    @Binding var postalCode: String
    @Binding var longitude: Double

    func makeUIViewController(context: UIViewControllerRepresentableContext<PlacePicker>) -> GMSAutocompleteViewController {

        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = context.coordinator
        

        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt64(UInt(GMSPlaceField.name.rawValue) |
                                                                   UInt(GMSPlaceField.placeID.rawValue)))
        autocompleteController.placeFields = fields

        let filter = GMSAutocompleteFilter()
        filter.type = .address
        filter.country = "USA"
        autocompleteController.autocompleteFilter = filter
        return autocompleteController
    }

    func updateUIViewController(_ uiViewController: GMSAutocompleteViewController, context: UIViewControllerRepresentableContext<PlacePicker>) {
    }

    class GooglePlacesCoordinator: NSObject, UINavigationControllerDelegate, GMSAutocompleteViewControllerDelegate {

        var parent: PlacePicker

        init(_ parent: PlacePicker) {
            self.parent = parent
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            DispatchQueue.main.async {
//                print(place.description.description as Any)
//                self.parent.address =  place.name!
                self.parent.address =  "\(place.addressComponents?.first(where: { $0.type == "street_number" })?.name ?? "") \(place.addressComponents?.first(where: { $0.type == "route" })?.name ?? "")"
                self.parent.country =  "\(place.addressComponents?.first(where: { $0.type == "country" })?.name ?? "")"
                self.parent.city =  "\(place.addressComponents?.first(where: { $0.type == "sublocality_level_1" })?.name ?? "")"
                self.parent.state =  "\(place.addressComponents?.first(where: { $0.type == "administrative_area_level_1" })?.name ?? "")"
                self.parent.postalCode =  "\(place.addressComponents?.first(where: { $0.type == "postal_code" })?.name ?? "")"
                self.parent.latitude =  (place.coordinate.latitude)
                self.parent.longitude =  (place.coordinate.longitude)
                self.parent.presentationMode.wrappedValue.dismiss()
                print("latitude: \(place.coordinate.latitude)")
                print("longitude: \(place.coordinate.longitude)")
                print("state: \(place.addressComponents?.first(where: { $0.type == "administrative_area_level_1" })?.name ?? "")")
                print("country: \(place.addressComponents?.first(where: { $0.type == "country" })?.name ?? "")")
                print("postal_code: \(place.addressComponents?.first(where: { $0.type == "postal_code" })?.name ?? "")")
                print("city: \(place.addressComponents?.first(where: { $0.type == "sublocality_level_1" })?.name ?? "")")
                print("address: \(place.addressComponents?.first(where: { $0.type == "street_number" })?.name ?? "") \(place.addressComponents?.first(where: { $0.type == "route" })?.name ?? "")")
                print("name: \(place.name!)")
            }
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            print("Error: ", error.localizedDescription)
        }

        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }

    }
}
