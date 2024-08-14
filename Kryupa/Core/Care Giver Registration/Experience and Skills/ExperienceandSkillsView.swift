//
//  ExperienceandSkillsView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 20/05/24.
//

import SwiftUI
import SwiftfulUI
import UniformTypeIdentifiers

struct FileData{
    var type: String
    var name: String
    var filePath: Foundation.URL
    var fileSize: String
    var fileData: Data
    var serverUrl:String
}

struct ExperienceandSkillsView: View {
    
    @Environment(\.router) var router
    
    var parameters:[String:Any] = [String:Any]()
    
    @StateObject private var viewModel = ExperienceandSkillsViewModel()
    @State var fileArray: [FileData] = [FileData]()
    
    var body: some View {
        ZStack{
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
                
                Text("Experience and Skills")
                    .font(.custom(FontContent.besMedium, size: 22))
                    .frame(height: 28)
                    .padding(.top,30)
                
                ScrollView {
                    VStack(spacing:0){
                        
                        textFieldViewWithHeader(
                            title: "Bio",
                            placeHolder: "About You",
                            value: $viewModel.exprienceAndSkillsData.bio,
                            keyboard: .asciiCapable
                        )
                        .padding([.leading,.trailing],24)
                        .padding(.top,20)
                        
                        sepratorView
                        
                        yearsofExperienceView
                            .padding([.leading,.trailing],24)
                            .frame(maxWidth: .infinity,alignment: .leading)
                        
                        sepratorView
                        
                        areaOfExpertise
                            .padding([.leading,.trailing],24)
                            .frame(maxWidth: .infinity,alignment: .leading)
                        
                        sepratorView
                        
                        VStack(spacing:0){
                            certificationDocumentsView
                                .padding(.bottom,10)
                                .padding([.leading,.trailing],24)
                            FileView
                        }
                        
                        HStack{
                            previousButton
                                .padding(.leading,24)
                                .asButton(.press) {
                                    router.dismissScreen()
                                }
                            Spacer()
                            nextButton
                                .padding(.trailing,24)
                                .asButton(.press) {
                                    viewModel.dataChecks(filesArray: fileArray) { alertStr in
                                        presentAlert(title: "Kryupa", subTitle: alertStr)
                                    } next: { param in
                                        var params = parameters
                                        params["exprienceAndSkills"] = param
                                        router.showScreen(.push) { rout in
                                            PreferenceView(parameters:params)
                                        }
                                    }
                                }
                        }
                        .padding(.top,30)
                        
                    }
                }
                .scrollIndicators(.hidden)
                .toolbar(.hidden, for: .navigationBar)
            }
            
            if viewModel.isLoading{
                LoadingView()
            }
        }
        .modifier(DismissingKeyboard())
    }
    
    private var FileView: some View{
        ForEach(fileArray,id: \.name){ file in
            HStack(spacing: 10){
                Image("fileSaveIcone")
                    .padding(.leading,20)
                VStack(alignment: .leading, spacing:4){
                    Text(file.name)
                        .foregroundStyle(.appMain)
                        .font(.custom(FontContent.plusRegular, size: 13))
                    Text(file.fileSize)
                        .foregroundStyle(._7_C_7_C_80)
                        .font(.custom(FontContent.plusRegular, size: 11))
                }
                
                Spacer()
                Image("close")
                    .padding(.trailing,20)
                    .asButton(.press){
                        fileArray = fileArray.filter{$0.name !=  file.name}
                    }
            }
            .frame(height: 59)
            .background(.F_2_F_2_F_7)
            .cornerRadius(16)
            .padding(.top,15)
            .padding([.leading,.trailing],24)
        }
    }
    
    //MARK: Send Code Button View
    private var nextButton: some View {
        HStack{
            Text("Next")
                .font(.custom(FontContent.plusMedium, size: 16))
                .padding([.top,.bottom], 16)
        }
        .frame(width: 144)
        .background(
            ZStack{
                Capsule(style: .circular)
                    .fill(.appMain)
            }
        )
        .foregroundColor(.white)
        
    }
    
    //MARK: Send Code Button View
    private var previousButton: some View {
        HStack{
            Text("Previous")
                .font(.custom(FontContent.plusMedium, size: 16))
                .padding([.top,.bottom], 16)
        }
        .frame(width: 144)
        .background(
            ZStack{
                Capsule(style: .circular)
                    .stroke(lineWidth: 1)
                    .fill(.appMain)
            }
        )
        .foregroundColor(.appMain)
    }
    
    private var sepratorView: some View{
        RoundedRectangle(cornerRadius: 4)
            .foregroundStyle(.F_2_F_2_F_7)
            .frame(height: 1)
            .padding([.top,.bottom],15)
            .padding(.horizontal,24)
    }
    
    private var certificationDocumentsView: some View{
        VStack{
            HStack(spacing:0){
                Text("Certification & documents")
                Text("*")
                    .foregroundStyle(.red)
                Spacer()
            }
            
            .font(.custom(FontContent.plusMedium, size: 17))
            
            
            HStack(spacing: 4){
                Text("Certification & documents")
                    .foregroundStyle(._7_C_7_C_80)
                    .font(.custom(FontContent.plusRegular, size: 16))
                Spacer()
                Image("uploadFileIcon")
            }
            .padding([.leading,.trailing],10)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.D_1_D_1_D_6)
                    .frame(height: 48)
            }
            .padding(.top,10)
            .onTapGesture {
                viewModel.showFilePicker.toggle()
            }
            .fileImporter(isPresented: $viewModel.showFilePicker, allowedContentTypes: [.pdf]) { result in
                do{
                    let fileUrl = try result.get()
                    
                    guard fileUrl.startAccessingSecurityScopedResource() else { // Notice this line right here
                         return
                    }
                    
                    let file = try Data(contentsOf: fileUrl)
                    
                    var fileData: FileData = FileData(
                        type: fileUrl.pathExtension,
                        name:  fileUrl.lastPathComponent,
                        filePath: fileUrl,
                        fileSize: fileUrl.fileSizeString, 
                        fileData: file, serverUrl: "")
                    if fileArray.contains(where: {$0.name == fileData.name}){
                        presentAlert(title: "Kryupa", subTitle: "Selected Document already Added.")
                    }else{
                        viewModel.uploadCertificateAndDocuments(file: fileData.fileData, fileName: fileData.name, certificateUrl: { certificateUrl in
                            fileData.serverUrl = certificateUrl
                            fileArray.append(fileData)
                        })
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func loadFileFromLocalPath(_ localFilePath: String) ->Data? {
       return try? Data(contentsOf: URL(fileURLWithPath: localFilePath))
    }
    
    private var areaOfExpertise: some View{
        
        VStack(alignment: .leading){
            HStack(spacing:0){
                Text("Area Of Expertise")
            }
            .font(.custom(FontContent.plusMedium, size: 17))
            
            
            ZStack{
                NonLazyVGrid(columns: 2, alignment: .leading, spacing: 4, items: AppConstants.needServiceInArray) { expertise in
                    if let expertise{
                        CheckBoxView(
                            isSelected: !viewModel.areaOfExpertiseSelected.contains(expertise),
                            name: expertise
                        )
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .asButton(.press) {
                            if viewModel.areaOfExpertiseSelected.contains(expertise){
                                viewModel.areaOfExpertiseSelected = viewModel.areaOfExpertiseSelected.filter{ $0 != expertise}
                            }else{
                                viewModel.areaOfExpertiseSelected.append(expertise)
                            }
                        }
                    }else{
                        EmptyView()
                    }
                }
            }
        }
        
    }
    
    private var yearsofExperienceView: some View{
        
        VStack(alignment: .leading){
            HStack(spacing:0){
                Text("Years of Experience")
                    .font(.custom(FontContent.plusMedium, size: 17))
                
                Spacer()
                
                HStack(spacing: 0){
                    Text("-")
                        .frame(width: 30,height: 30)
                        .foregroundStyle(viewModel.yearsOfExprience == 0 ? .D_1_D_1_D_6 : .appMain)
                        .asButton(.press) {
                            if viewModel.yearsOfExprience > 0 {
                                viewModel.yearsOfExprience -= 1
                                viewModel.exprienceAndSkillsData.yearsOfExprience = "\(viewModel.yearsOfExprience)"
                            }
                        }
                    TextField("0", text: $viewModel.exprienceAndSkillsData.yearsOfExprience.toUnwrapped(defaultValue: "0").max(2))
                        .frame(width: 30,height: 30)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .onChange(of: viewModel.exprienceAndSkillsData.yearsOfExprience) {
                            viewModel.yearsOfExprience = Int(viewModel.exprienceAndSkillsData.yearsOfExprience ?? "0") ?? 0
                        }
                    
                    Text("+")
                        .frame(width: 30,height: 30)
                        .asButton(.press) {
                            viewModel.yearsOfExprience += 1
                            viewModel.exprienceAndSkillsData.yearsOfExprience = "\(viewModel.yearsOfExprience)"
                        }
                }
                
                .background{
                    RoundedRectangle(cornerRadius: 25.0)
                        .stroke(lineWidth: 1)
                        .foregroundStyle(.D_1_D_1_D_6)
                }
            }
        }
    }
    
    
    private func textFieldViewWithHeader(title:String?, placeHolder: String, value: Binding<String?>,keyboard: UIKeyboardType)-> some View{
        VStack(alignment: .leading, content: {
            if let title{
                HStack(spacing:0){
                    Text(title)
                }
                .font(.custom(FontContent.plusMedium, size: 17))
            }
            TextEditor(text: value.toUnwrapped(defaultValue: ""))
            .frame(height: 120)
            .keyboardType(keyboard)
            .font(.custom(FontContent.plusRegular, size: 15))
            .padding([.leading,.trailing],10)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.D_1_D_1_D_6)
                    .frame(height: 125)
            }
            .padding(.top,10)
        })
    }
    
}

#Preview {
    ExperienceandSkillsView()
}


struct DocPicker: FileDocument{
    var url: String
    static var readableContentTypes: [UTType]{[.pdf]}
    
    init(url: String) {
        self.url = url
    }
    init(configuration: ReadConfiguration) throws {
        
        url = ""
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let file = try! FileWrapper(url: URL(filePath: url),options: .immediate)
        
        return file
    }
}
