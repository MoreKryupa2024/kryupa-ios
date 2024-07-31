//
//  ImageLoadingView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 03/07/24.
//

import SwiftUI

struct ImageLoadingView: View {
    
    var imageURL = String()
    private static let cache = NSCache<NSString, UIImage>()
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL),content: { image in
//            if let cachedImage = Self.cache.object(forKey: imageURL as NSString){
//                Image(uiImage: cachedImage)
//                    .resizable()
//                    .scaledToFit()
//            }else{
                
                image
                    .resizable()
                    .scaledToFit()
//                    .task {
//                        do {
//                            let _ = try await fetchImage(imageURL)
//                            print("image save")
//                        } catch { //never gets caught
//                            print("Image not saved \(error.localizedDescription)")
//                        }
//                    }
//            }
        },placeholder: {
            ProgressView()
        })
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(.gray.opacity(0.3))
    }
    
    func fetchImage(_ urlStr: String) async throws {
        guard let url = URL(string: urlStr) else {
            throw NetworkError.invalidURL
        }
        let request = URLRequest(url: url)
        // check
        
        let (data, response) = try await URLSession.shared.data (for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        guard let image = UIImage(data: data) else {
            throw NetworkError.somethingWentWrong
        }
        // store it in the cache
        Self.cache.setObject(image, forKey: url.absoluteString as NSString)
    }
    
}

#Preview {
    ImageLoadingView()
}
