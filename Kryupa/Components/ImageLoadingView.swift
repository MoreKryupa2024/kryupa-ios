//
//  ImageLoadingView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 03/07/24.
//

import SwiftUI

struct ImageLoadingView: View {
    
    var imageURL = String()
    //    private let manager = CacheManager.instance
    
    var body: some View{
        AsyncImage(url: URL(string: imageURL),content: { image in
            image
                .resizable()
                .scaledToFill()
            
        },placeholder: {
            Image("placeholderImage")
                .resizable()
                .scaledToFit()
                .padding()
        })
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(.gray.opacity(0.3))
    }
} /*{
        
        if let imageCache = manager.get(name: imageURL){
            Image(uiImage: imageCache)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .background(.gray.opacity(0.3))
        }else{
            AsyncImage(url: URL(string: imageURL),content: { image in
                image
                    .resizable()
                    .scaledToFill()
                
            },placeholder: {
                Image("placeholderImage")
                    .resizable()
                    .scaledToFit()
                    .padding()
            })
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(.gray.opacity(0.3))
//            .task {
//                downloadImage()
//            }
        }
    }
//    
//    func downloadImage(){
//        guard let url = URL(string: imageURL) else {return}
//        
//        URLSession.shared.dataTaskPublisher(for: url)
//            .map { ((UIImage(data: $0.data) ?? UIImage(named: "placeholderImage"))!)}
//            .receive(on: DispatchQueue.main)
//            .sink { (_) in
//                
//            }receiveValue: { (returnImage) in
//                manager.add(image: returnImage, name: imageURL)
//            }
//    }
}

class CacheManager{
    static let instance = CacheManager() // singleton
    
    private init(){}
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    func add(image:UIImage, name: String){
        imageCache.setObject(image, forKey: name as NSString)
        print("added to cache")
    }
    
    func get(name: String)-> UIImage?{
        print("send to cache Image")
        return imageCache.object(forKey: name as NSString)
        
    }
}
*/
