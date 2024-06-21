//
//  GalleryView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 21/06/24.
//

import Foundation
import SwiftUI
import PhotosUI

struct GalleryView: View {
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    private let onImagePicked: (UIImage) -> Void
    
    var body: some View {
        
        PhotosPicker(
            selection: $selectedItem,
            matching: .images,
            photoLibrary: .shared()) {
                Text("Select a photo")
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    // Retrieve selected asset in the form of Data
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                    }
                }
            }
        
        if let selectedImageData,
           let uiImage = UIImage(data: selectedImageData) {
//            self.onImagePicked(uiImage)
//            Image(uiImage: uiImage)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 250, height: 250)
        }
    }
}
