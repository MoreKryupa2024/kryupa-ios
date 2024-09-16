//
//  SelectProfileImageView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 20/05/24.
//

import SwiftUI
import SwiftfulUI
import AVFoundation


struct SelectProfileImageView: View {
    
    @Environment(\.router) var router
    @State var camera = CameraModal()
    @State var isTaken = Bool()
    
    @StateObject private var viewModel = SelectProfileImageViewModel()
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack(spacing:0){
                    ZStack(alignment:.leading){
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundStyle(.E_5_E_5_EA)
                            .frame(height: 4)
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundStyle(.appMain)
                            .frame(width: 196,height: 4)
                    }
                    .padding([.leading,.trailing],24)
                    
                    ZStack(alignment:.topLeading){
                        
                        Text("Smile!\nClick A Picture")
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .font(.custom(FontContent.besMedium, size: 22))
                            .frame(maxWidth: .infinity)
                            .padding(.top,30)
                            .padding(.horizontal,24)
                        
                        Image("navBack")
                            .resizable()
                            .frame(width: 30,height: 30)
                            .padding(.top,30)
                            .padding(.horizontal,24)
                            .asButton(.press) {
                                router.dismissScreen()
                            }
                    }
                    
                    if let profilePicture = viewModel.profilePicture{
                        pictureSelectedView(image: profilePicture)
                    }else{
                        takePhotoView
                    }
                }
            }
            .scrollIndicators(.hidden)
            .toolbar(.hidden, for: .navigationBar)
            .onAppear {
                
                #if DEBUG && targetEnvironment(simulator)
                self.viewModel.profilePicture = UIImage(named: "personal")
                #else
                //
                #endif
                //
                camera.requestCameraPermission()
            }
            if viewModel.isLoading{
                LoadingView()
            }
        }
    }
    
    private var takePhotoView: some View{
        VStack(spacing:0){
            RoundedRectangle(cornerRadius:20)
                .stroke(lineWidth: 1)
                .foregroundStyle(.E_5_E_5_EA)
                .frame(height: 250)
                .padding(.top,40)
                .padding(.horizontal,53)
                .overlay(content: {
                    Image("profilePlaceholder")
                })
            
            Text("Please take a clear photo of yourself for\nyour profile.")
                .multilineTextAlignment(.center)
                .font(.custom(FontContent.plusRegular, size: 14))
                .foregroundStyle(._444446)
                .padding(.top,35)
            
            nextButton
                .padding(.top,55)
                .asButton(.press) {
                    if camera.isTaken{
                        isTaken = true
                    }else{
                        presentAlert(title: "Kryupa", subTitle: "Please Allow Camera Access to our app.")
                    }
                }
                .fullScreenCover(isPresented: $isTaken) {
                    CameraPickerView(isCam: true) { image in
                        viewModel.profilePicture = image
                    }
                }
            if Defaults().userType == AppConstants.SeekCare{
                SkipButton
                    .padding(.top,25)
                    .asButton(.press) {//(resource: "placeholderImage")
                        let imageModel: UIImage = UIImage(imageLiteralResourceName: "placeholderImage")
                        viewModel.uploadProfilePic(file: imageModel.jpegData(compressionQuality: 0.5) ?? Data(), fileName: "user_image.png") {
                            router.showScreen(.push) { _ in
                                SuccessfulScreeenView()
                            }
                        }
                    }
            }
        }
    }
    
    //MARK: Send Code Button View
    private var nextButton: some View {
        HStack{
            Text("Take Photo")
                .font(.custom(FontContent.plusMedium, size: 16))
                .padding([.top,.bottom], 16)
                .padding([.leading,.trailing], 40)
        }
        .background(
            ZStack{
                Capsule(style: .circular)
                    .fill(.appMain)
            }
        )
        .foregroundColor(.white)
        
    }
    
    private var SkipButton: some View {
        HStack{
            Text("Skip Now")
                .font(.custom(FontContent.plusMedium, size: 16))
                .padding([.top,.bottom], 16)
                .padding([.leading,.trailing], 40)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
        )
    }
    
    
    private func pictureSelectedView(image: UIImage)-> some View{
        VStack(spacing:0){
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 250,height: 250)
                .background(.gray.opacity(0.3))
                .clipShape(.rect(cornerRadius: 125))
                .padding(.top,40)
            
            HStack(content: {
                Image("profileCancel")
                    .asButton(.press) {
                        viewModel.profilePicture = nil
                    }
                Image("profileApprove")
                    .asButton(.press) {
                        if let imageData = viewModel.profilePicture?.jpegData(compressionQuality: 0){
                            viewModel.uploadProfilePic(file: imageData, fileName: "user_image.png") {
                                router.showScreen(.push) { _ in
                                    SuccessfulScreeenView()
                                }
                            }
                        }
                    }
            })
            .padding(.top,50)
            
            Text("Picture added successfully!")
                .font(.custom(FontContent.plusRegular, size: 14))
                .foregroundStyle(._444446)
                .padding(.top,35)
        }
        
    }
}

#Preview {
    SelectProfileImageView()
}
