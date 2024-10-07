//
//  ProfileDetailScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 14/06/24.
//

import SwiftUI
import SwiftfulUI
import PhotosUI

struct ProfileDetailScreenView: View {
    @Environment(\.router) var router
    
    @StateObject var viewModel = ProfileDetailScreenViewModel()
    @State private var showingAlert = false
    @State private var selectedItem: PhotosPickerItem?
    @State var showsAlertForImageUpload = false
    @State var profilesDownShow = false
    @State var showPicker = Bool()
    @State var isCam = Bool()
    @State var selectedImage: UIImage? = nil//UIImage(imageLiteralResourceName: "personal")

    var body: some View {
        ZStack{
            VStack{
                HeaderView(title: "Personal Details",showBackButton: true)
                ScrollView{
                    HStack(alignment:.top){
                        let nameArray = viewModel.profileList.map{ $0.name}
                        DropDownView(selectedValue: viewModel.selecedProfile,
                                     showDropDown: profilesDownShow,
                                     values: nameArray) { value in
                            selectedImage = nil
                            viewModel.selecedProfile = value
                            viewModel.getPersonalDetails(profileName: viewModel.selecedProfile)
                        }onShowValue: {
                            profilesDownShow = !profilesDownShow
                        }
                        .id(viewModel.selecedProfile)
                        AddNewButton
                            .asButton(.press) {
                                router.showScreen(.push) { rout in
                                    AddNewProfileScreenView()
                                }
                            }
                            .padding(.top,5)
                    }
                    .padding(.horizontal,24)
                    ImageViewSection
                    
                    PersonalInfoSection
                        .padding(.horizontal,24)
                        .padding(.top,20)
                    
                    SepratorView
                    
                    EmergencyInfoSection
                        .padding(.horizontal,24)
                }
                .scrollIndicators(.hidden)
            }
            
            if viewModel.isloading{
                LoadingView()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear() {
            NotificationCenter.default.addObserver(forName: .showInboxScreen, object: nil, queue: nil,
                                                 using: self.setChatScreen)
            viewModel.getProfileList()
//            viewModel.getPersonalDetails(profileName: selecedProfile)
//            viewModel.testgetPersonalDetails(profileName: selecedProfile)
        }
    }
    
    private func setChatScreen(_ notification: Notification){
        router.dismissScreenStack()
    }
    
    private var PersonalInfoSection: some View{
        VStack(spacing:10){
            HStack(spacing:0){
                Text("Personal Info")
                    .font(.custom(FontContent.plusRegular, size: 17))
                    .foregroundStyle(.appMain)
                Spacer()

            }
            .padding(.bottom,5)
            
//            TitleTextView(title: "Email:", value: viewModel.personalDetail?.email ?? "")
            TitleTextView(title: "Language:", value: viewModel.personalDetail?.language ?? "")
            TitleTextView(title: "DOB:", value: viewModel.personalDetail?.dob!.convertDateFormater(beforeFormat: "YYYY-MM-dd", afterFormat: "MMM,dd YYYY") ?? "")
        }
    }
    
    func convertPersonalDetailModelToAddNewProfileModel() -> AddNewProfileScreenViewModel{
        let viewModelAddNewProfile = AddNewProfileScreenViewModel()
        viewModelAddNewProfile.name = viewModel.personalDetail?.emergencycontact?.relativeName ?? ""
        
        viewModelAddNewProfile.email = viewModel.personalDetail?.emergencycontact?.relativeEmail ?? ""
        
        viewModelAddNewProfile.relation = viewModel.personalDetail?.emergencycontact?.relation ?? ""

        viewModelAddNewProfile.number = viewModel.personalDetail?.emergencycontact?.relativeMobileNo ?? ""

        viewModelAddNewProfile.relationPersonal = viewModel.personalDetail?.relation ?? ""
        
        viewModelAddNewProfile.dateOfBirthSelected = true
        viewModelAddNewProfile.date = dateFormatChangeToDate(dateFormat: "YYYY-MM-dd", dates: (viewModel.personalDetail?.dob ?? "")) ?? Date()
        
        let personalInfo = PersonalInfo(name: viewModel.personalDetail?.firstname,lastName: viewModel.personalDetail?.lastname, language: viewModel.personalDetail?.language, dob: viewModel.personalDetail?.dob, gender: viewModel.personalDetail?.gender, address: viewModel.personalDetail?.address, city: viewModel.personalDetail?.city, state: viewModel.personalDetail?.state,postalCode: viewModel.personalDetail?.zipcode, country: viewModel.personalDetail?.country)

        viewModelAddNewProfile.personalInfoData = personalInfo
        viewModelAddNewProfile.medicalConditionSelected = viewModel.personalDetail?.medicalinfo?.otherDisease ?? ""
        viewModelAddNewProfile.medicalConditionDropDownSelected = viewModel.personalDetail?.medicalinfo?.diseaseTypes ?? [""]
        viewModelAddNewProfile.canHelpInSelect = viewModel.personalDetail?.canHelpIn ?? []
        viewModelAddNewProfile.allergiesValue = viewModel.personalDetail?.medicalinfo?.allergies ?? ""

        viewModelAddNewProfile.profileID = viewModel.personalDetail?.profileid ?? ""
        viewModelAddNewProfile.medicalID = viewModel.personalDetail?.medicalinfo?.medicalID ?? ""

        return viewModelAddNewProfile
    }
    
    private var SepratorView: some View{
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(.F_2_F_2_F_7)
            .padding(.vertical,20)
            .padding(.horizontal,24)
        
    }
    
    private var EmergencyInfoSection: some View{
        VStack(spacing:10){
            HStack(spacing:0){
                Text("Emergency Contact")
                    .font(.custom(FontContent.plusRegular, size: 17))
                    .foregroundStyle(.appMain)

                Spacer()
//                HStack {
//                    Image("edit-two")
//                        .resizable()
//                        .frame(width: 17, height: 17)
//                        .font(.custom(FontContent.plusRegular, size: 17))
//                    
//                    Text("Edit")
//                        .font(.custom(FontContent.plusRegular, size: 16))
//                        .foregroundStyle(._7_C_7_C_80)
//                }
            }
            .padding(.bottom,5)
            
            
            TitleTextView(title: "Name:", value: viewModel.personalDetail?.emergencycontact?.relativeName ?? "")
            TitleTextView(title: "Phone number:", value: "+1 \(viewModel.personalDetail?.emergencycontact?.relativeMobileNo ?? "")")
            TitleTextView(title: "Relation:", value: viewModel.personalDetail?.emergencycontact?.relation ?? "")
            
        }
    }
    
    private func TitleTextView(title: String, value: String)-> some View{
        HStack(spacing:0){
            Text(title)
                .font(.custom(FontContent.plusRegular, size: 15))
                .foregroundStyle(.appMain)

                
            Spacer()
            
            Text(value)
                .font(.custom(FontContent.plusRegular, size: 15))
                .foregroundStyle(._7_C_7_C_80)
        }
        .font(.custom(FontContent.plusRegular, size: 15))
    }
    
    private var ImageViewSection: some View{
        HStack(spacing:15){
            ZStack {
                if let selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .frame(width: 68, height: 68)
                        .clipShape(.rect(cornerRadius: 34))
                        .padding(3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 37)
                                .stroke(.AEAEB_2, lineWidth: 1)
                        )
                }else{
                    ImageLoadingView(imageURL: viewModel.personalDetail?.profilePictureUrl ?? "")
                        .frame(width: 68, height: 68)
                        .clipShape(.rect(cornerRadius: 34))
                        .clipped()
                        .padding(3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 37)
                                .stroke(.AEAEB_2, lineWidth: 1)
                        )
                }
                
                Image("edit")
                    .offset(x:22,y:-25)
            }
            .onTapGesture {
                showsAlertForImageUpload.toggle()
            }
            .actionSheet(isPresented: $showsAlertForImageUpload) {
                ActionSheet(title: Text("Select"), message: Text(""), buttons: [
                .default(Text("Camera")) { 
                    isCam = true
                    showPicker.toggle()
                },
                .default(Text("Gallery")) { 
                    isCam = false
                    showPicker.toggle()
                },
                .destructive(Text("Cancel")){       // << keep as last
                        // just nop - will be just closed
                    }
                ])
            }
            .fullScreenCover(isPresented: $showPicker) {
                CameraPickerView(isCam: isCam) { image in
                    print(image)
                    
                    if let imageData = image.jpegData(compressionQuality: 0){
                        viewModel.uploadProfilePic(profileID: viewModel.personalDetail?.profileid ?? "", file: imageData, fileName: "seeker_image.png") {
                            print("success")
                            selectedImage = image
                        }
                    }
                }
            }
            
            VStack(alignment: .leading, spacing:5){
                Text(viewModel.personalDetail?.profileName ?? "")
                    .font(.custom(FontContent.besMedium, size: 20))
                    .foregroundStyle(.appMain)
                
                HStack {
                    Image("edit-two")
                        .resizable()
                        .frame(width: 17, height: 17)
                        .font(.custom(FontContent.plusRegular, size: 17))
                    
                    Text("Edit")
                        .font(.custom(FontContent.plusRegular, size: 16))
                        .foregroundStyle(._7_C_7_C_80)
                }
                .asButton(.press) {
                    
                    let viewModelAddNewProfile = convertPersonalDetailModelToAddNewProfileModel()
                    
                    router.showScreen(.push) { rout in
                        
                        AddNewProfileScreenView(viewModel: viewModelAddNewProfile)
                    }
                }
                
                .asButton(.press) {
                    showingAlert = true
                }
                .alert("Are you sure you want to delete this profile?", isPresented: $showingAlert) {
                    Button("Confirm", action: {
                        viewModel.deleteProfile {
                            router.showScreen(.push) { rout in
                                AccountView()
                            }
                        }
                    })
                    Button("Cancel", role: .cancel, action: {})
                }
            }
            Spacer()
        }
        .padding(.horizontal,24)
        .padding(.top,30)
    }
    
    private var AddNewButton: some View {
        HStack{
            Text("Add New")
                .font(.custom(FontContent.plusMedium, size: 16))
                .padding(.vertical, 8)
                .padding(.horizontal, 20)
        }
        .background(
            ZStack{
                Capsule(style: .circular)
                    .fill(.appMain)
            }
        )
        .foregroundColor(.white)
    }
}

#Preview {
    ProfileDetailScreenView()
}
