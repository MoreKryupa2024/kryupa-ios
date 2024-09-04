//
//  PersonalDetailView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 10/06/24.
//

import SwiftUI
import SwiftfulUI
import PhotosUI

struct PersonalDetailView: View {

    @State var strBio: String = ""
    @State private var intExp = 0
    @StateObject private var viewModel = PersonalDetailViewModel()
    @State var showsAlertForImageUpload = false
    @State private var selectedItem: PhotosPickerItem?
    @State var showPicker = Bool()
    @State var isCam = Bool()
    @State var selectedImage: UIImage = UIImage(imageLiteralResourceName: "personal")
    @State var didImageSelected: Bool = false
    @State var editProfile: Bool = false
    @State var educationDownShow: Bool = false
    @State var languageDropDownShow: Bool = false

    var body: some View {
        ZStack{
            
            ScrollView(showsIndicators: false){
                HeaderTopView
                PersonalInfoSection
                    .padding(.horizontal,24)
                    .padding(.top,20)
                line
                textFieldViewWithHeader(
                    title: "Bio",
                    placeHolder: "Input text",
                    value: $strBio,
                    keyboard: .asciiCapable
                ).disabled(!editProfile)
                line
                yearOfExpView.disabled(!editProfile)
                line
                AdditionalInfoView.disabled(!editProfile)
                line
                QualificationView
                
                if editProfile {
                    languageDropdownView.disabled(!editProfile)
                    bottomButtonView
                }
            }
            .overlay(alignment: .top) {
                Color.clear
                    .background(.regularMaterial)
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 0)
            }
            .toolbar(.hidden, for: .navigationBar)
            .onAppear() {
                UIScrollView.appearance().bounces = false
                viewModel.getPersonalDetails() {
                    strBio = viewModel.personalDetail?.expertise.bio ?? ""
                    intExp = viewModel.personalDetail?.expertise.exprience ?? 0
                    viewModel.additionalInfoSelected = viewModel.personalDetail?.additionalRequirements ?? []
                }
            }
            if viewModel.isloading{
                LoadingView()
            }
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
    
    private var PersonalInfoSection: some View{
        VStack(spacing:10){
            HStack(spacing:0){
                Text("Personal Info")
                    .font(.custom(FontContent.plusMedium, size: 17))
                    .foregroundStyle(.appMain)
                Spacer()
            }
            .padding(.bottom,5)
            TitleTextView(title: "Email:", value: viewModel.personalDetail?.email ?? "")
            TitleTextView(title: "DOB:", value: (viewModel.personalDetail?.dob ?? "").convertDateFormater(beforeFormat: "YYYY-MM-dd", afterFormat: "MMM dd YYYY"))
        }
    }
    
    private var languageDropdownView: some View{
        VStack(alignment: .leading, spacing:0,
               content: {
//            HStack(spacing:0){
//                Text("Language")
//                Text("*")
//                    .foregroundStyle(.red)
//            }
//            .frame(height: 21)
//            .font(.custom(FontContent.plusMedium, size: 17))
//            .padding(.bottom,10)
            
            DropDownWithCheckBoxView(
                selectedValue: viewModel.languageDropDownSelected,
                placeHolder: "Select Language",
                showDropDown: languageDropDownShow,
                values: AppConstants.languageSpeakingArray) { value in
                    viewModel.languageDropDownSelected = value
                }onShowValue: {
                    languageDropDownShow = !languageDropDownShow
                    educationDownShow = false
                }
                .id(viewModel.languageDropDownSelected.first)
            

        })
        .padding(.horizontal,24)
        .padding(.top, 10)
        .padding(.bottom,-10)
    }
    
    private var bottomButtonView: some View {
        HStack(spacing: 30) {
            
            Text("Save")
                .font(.custom(FontContent.plusRegular, size: 16))
                .foregroundStyle(.white)
                .frame(height: 53)
                .frame(width: 135)
                .background{
                    RoundedRectangle(cornerRadius: 48)
                }
                .asButton(.press) {
                    viewModel.personalDetail?.expertise.bio = strBio
                    viewModel.personalDetail?.expertise.exprience = intExp
                    viewModel.validateData { alertStr in
                        presentAlert(title: "Kryupa", subTitle: alertStr)
                    } next: { param in
                        viewModel.updateProfile(param: param) {
                            editProfile = false
                        }
                    }
                }

            Spacer()
            
            Text("Cancel")
                .font(.custom(FontContent.plusRegular, size: 16))
                .foregroundStyle(.appMain)
                .frame(height: 53)
                .frame(width: 135)
                .asButton(.press) {
                    editProfile = !editProfile
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 48)
                        .inset(by: 1)
                        .stroke(.appMain, lineWidth: 1)
                )

        }
        .padding(.horizontal , 24)
        .padding(.top , 50)

    }
    
    private var EducationDropdownView: some View{
        VStack(alignment: .leading, spacing:0,
               content: {
            HStack(spacing:0){
                Text("Education")
                Text("*")
                    .foregroundStyle(.red)
            }
            .frame(height: 21)
            .font(.custom(FontContent.plusMedium, size: 17))
            .padding(.bottom,10)
            
            DropDownView(
                selectedValue: viewModel.education,
                placeHolder: "College Degree",
                showDropDown: educationDownShow,
                values: viewModel.educationList) { value in
                    viewModel.education = value
                }onShowValue: {
                    educationDownShow = !educationDownShow
                    languageDropDownShow = false
                }
        })
        .padding(.horizontal,24)
        .padding(.top, 10)
    }
    
    private var QualificationView: some View{
        
        VStack(alignment: .leading, spacing: 10) {
//            Text("Qualifications")
//                .font(.custom(FontContent.plusMedium, size: 17))
//                .foregroundStyle(._242426)
//            
//            
//            HStack {
//                Text("Education:")
//                    .font(.custom(FontContent.plusRegular, size: 12))
//                    .foregroundStyle(._242426)
//                Spacer()
//                Text("College Degree")
//                    .font(.custom(FontContent.plusRegular, size: 12))
//                    .foregroundStyle(._242426)
//            }
            
            Text("Language")
                .font(.custom(FontContent.plusMedium, size: 17))
                .foregroundStyle(._242426)

            HStack {
//                Text("Languages:")
//                    .font(.custom(FontContent.plusRegular, size: 12))
//                    .foregroundStyle(._242426)
//                Spacer()
                Text( viewModel.languageDropDownSelected.isEmpty ? "-" : "\(viewModel.languageDropDownSelected.joined(separator: ","))")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._242426)
                Spacer()
            }
        }
        .padding(.horizontal,24)
        .padding(.top, 10)
    }
    
    private var AdditionalInfoView: some View{
        
        VStack(alignment: .leading){
            HStack(spacing:0){
                Text("Additional info")
            }
            .font(.custom(FontContent.plusMedium, size: 17))
            
            
            ZStack{
                NonLazyVGrid(columns: 1, alignment: .leading, spacing: 10, items: AppConstants.additionalInfoArray) { service in
                    if let service{
                        CheckBoxView(
                            isSelected: !viewModel.additionalInfoSelected.contains(service),
                            name: service
                        )
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .asButton(.press) {
                            if viewModel.additionalInfoSelected.contains(service){
                                viewModel.additionalInfoSelected = viewModel.additionalInfoSelected.filter{ $0 != service}
                            }else{
                                viewModel.additionalInfoSelected.append(service)
                            }
                        }
                    }else{
                        EmptyView()
                    }
                }
            }
        }
        .padding(.horizontal,24)
        .padding(.top,10)
    }
        
    private var yearOfExpView: some View{
        
        return HStack {
            Text("Years of experience")
                .font(.custom(FontContent.plusMedium, size: 17))
            
            Spacer()
            
            HStack(spacing:15) {
                Image("minus")
                    .asButton(.press) {
                        if Int(intExp) == 0 {
                            print("minus no")
                            intExp = 0
                        }
                        else {
                            print("minus in")
                            intExp = intExp - 1
                        }
                    }
                Text(String(intExp))
                    .font(.custom(FontContent.plusRegular, size: 16))
                Image("plus")
                    .asButton(.press) {
                        print("plus")
                        intExp = intExp + 1
                        print(intExp)
                    }
            }
            .padding(.horizontal, 15)
            .frame(height: 32)
            .overlay(
                RoundedRectangle(cornerRadius: 60)
                    .inset(by: 1)
                    .stroke(.D_1_D_1_D_6, lineWidth: 1)
            )
        }
        .padding(.horizontal,24)
        .padding(.top,10)
    }
    
    private var line: some View {
        Divider()
            .background(.F_2_F_2_F_7)
            .padding(.trailing, 30)
            .padding(.leading, 0)
            .padding(.top, 10)
        }
    
    private func textFieldViewWithHeader(title:String?, placeHolder: String, value: Binding<String>,keyboard: UIKeyboardType)-> some View{
        
        VStack(alignment: .leading, content: {
            if let title{
                HStack(spacing:0){
                    Text(title)
                }
                .font(.custom(FontContent.plusMedium, size: 17))
            }
            TextEditor(text: value)
            .frame(height: 120)
            .keyboardType(.asciiCapable)
            .font(.custom(FontContent.plusRegular, size: 15))
            .padding([.leading,.trailing],10)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.D_1_D_1_D_6)
                    .frame(height: 125)
            }
        })
        .padding(.horizontal,24)
        .padding(.top,24)

    }
    
    private var HeaderTopView: some View{
        VStack {
            
            HeaderView(title: "Personal Details", showBackButton: true)
                        
            HStack {
                
                ZStack {
                    
                    if didImageSelected {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(30)

                    }
                    else {
                        ImageLoadingView(imageURL: viewModel.personalDetail?.profilePictureUrl ?? "")
                            .frame(width: 60, height: 60)
                            .cornerRadius(30)
                            .clipped()
                    }
                }
                .frame(width: 67, height: 67)
                .overlay(
                    ZStack{
                        RoundedRectangle(cornerRadius: 33)
                            .inset(by: 1)
                            .stroke(.AEAEB_2, lineWidth: 1)
                        
                        Image("edit")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .offset(x:18,y:-25)
                    }
                )
                .asButton {
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
                            viewModel.uploadProfilePic(file: imageData, fileName: "giver_image.png") {
                                print("success")
                                selectedImage = image
                                didImageSelected = true
                            }
                        }
                    }
                }
                
                
                VStack(alignment: .leading) {
                    Text(viewModel.personalDetail?.name ?? "")
                        .font(.custom(FontContent.besMedium, size: 17))
                        .foregroundStyle(._242426)
                    
                    Text(viewModel.personalDetail?.gender ?? "")
                        .font(.custom(FontContent.plusRegular, size: 12))
                        .foregroundStyle(._242426)
                    
                    Text("Verified")
                        .frame(width: 62 ,height: 23)
                        .font(.custom(FontContent.plusRegular, size: 11))
                        .foregroundStyle(.white)
                        .background(._018_ABE)
                        .clipShape(Capsule())
                }
                
                Spacer()
                
                VStack() {
                    if editProfile {
                       /* Text("Save")
                            .frame(width: 62 ,height: 23)
                            .font(.custom(FontContent.plusRegular, size: 11))
                            .foregroundStyle(.white)
                            .background(.appMain)
                            .clipShape(Capsule())
                            .asButton(.press) {
                                viewModel.personalDetail?.expertise.bio = strBio
                                viewModel.personalDetail?.expertise.exprience = intExp
                                viewModel.validateData { alertStr in
                                    presentAlert(title: "Kryupa", subTitle: alertStr)
                                } next: { param in
                                    viewModel.updateProfile(param: param) {
                                        editProfile = false
                                    }
                                }
                            }
                        
                        Spacer()*/
                        
                        HStack {
                            Image("edit-two")
                                .frame(width: 13, height: 13)
                                .hidden()
                            
                            Text("Edit Profile")
                                .font(.custom(FontContent.plusRegular, size: 11))
                                .foregroundStyle(._7_C_7_C_80)
                                .hidden()

                        }
                        
                        Spacer()

                    }
                    else {
                        HStack {
                            Image("edit-two")
                                .frame(width: 13, height: 13)
                            
                            Text("Edit Profile")
                                .font(.custom(FontContent.plusRegular, size: 11))
                                .foregroundStyle(._7_C_7_C_80)
                        }
                        .asButton(.press) {
                            editProfile = true
                        }
                        
                        Spacer()
                    }
                    
                }
                .padding()
                
            }
            .padding(.horizontal, 20)
        }
        .background(.F_2_F_2_F_7)
        .frame(height: 205)
        .clipShape(
            .rect (
                bottomLeadingRadius: 20,
                bottomTrailingRadius: 20
            )
        )
        
    }
}

#Preview {
    PersonalDetailView()
}
