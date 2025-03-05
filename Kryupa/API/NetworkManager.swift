//
//  APIClient.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 15/05/24.
//

import Foundation
import Network

final class NetworkManager {
    
    static let shared = NetworkManager()
    private let defaults = Defaults()
    
    public var commonHeaders: [String: String] {
        //        let  currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        //        let deviceID = Device.udid
        //        let salt = randomString(length: 10)
        //        let headerHashString = "IOS|\(currentVersion)|\(deviceID)|\(salt)"
        //        let headerHash = Data(headerHashString.utf8)
        //        let hashed = sha256(data: headerHash)
        //        let hashedString = (hexStringFromData(input: NSData(data: hashed)))
        
        var headerField = [String: String]()
        headerField["Content-type"] = "application/json"
        //        headerField["os"] = "IOS"
        //        headerField["appversion"] = currentVersion
        //        headerField["deviceID"] = deviceID
        //        headerField["salt"] = salt
        //        headerField["headerHash"] = encryptString(hashedString)
        
        if !self.defaults.accessToken.isEmpty {
            headerField["Authorization"] = "Bearer \(defaults.accessToken)"
        }
        return headerField
    }
    
    
    func setApplePayTransactionStatus(params:[String:Any]?,completionHandler :  @escaping (Results<ApplePayModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.setApplePayStatus, method: .POST,parameters: params,headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = ApplePayModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
    func getCardVerificationDetails(completionHandler :  @escaping (Results<CardVerificationModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.getCardVerificationInfo, method: .GET,headers: commonHeaders) { result in
            switch result {
            case .success(let response):
                let apiData = CardVerificationModel(jsonData: response)
                completionHandler(.success(apiData))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
    func setCardVerificationDetails(completionHandler :  @escaping (Results<CardVerificationModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.setCardVerificationInfo,
                                 method: .POST,
                                 headers: commonHeaders) { result in
            switch result{
            case .success(let response):
                let apiData = CardVerificationModel(jsonData: response)
                completionHandler(.success(apiData))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func uploadPDFFile(file:Data, fileName: String,completionHandler :  @escaping (Results<UploadDocumentModel, NetworkError>) -> Void){
        let mimeType = "application/pdf"
        
        guard let url = URL(string: APIConstant.uploadPDFFiles) else {return}
        let request = MultipartFormDataRequest(url: url)
        request.addDataField(fieldName:  "file", fileName: fileName, data: file, mimeType: mimeType)
        URLSession.shared.dataTask(with: request, completionHandler: {[weak self](data, response, error) in
            
            if let error = error{
                print(error)
                completionHandler(.failure(.custom(error.localizedDescription)))
                return
            }
            print(response as? HTTPURLResponse ?? HTTPURLResponse())
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200,response.statusCode < 400 else {
                return completionHandler(.failure(NetworkError.invalidResponse))
            }
            
            guard  let data = data else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiData = try decoder.decode(UploadDocumentModel.self, from: data)
                if apiData.success{
                    completionHandler(.success(apiData))
                }else{
                    completionHandler(.failure(.custom(apiData.message)))
                }
                
            }catch{
                completionHandler(.failure(.somethingWentWrong))
            }
        }).resume()
    }
    
    func uploadProfilePicGiver(file:Data, fileName: String,completionHandler :  @escaping (Results<EmptyRegister, NetworkError>) -> Void){
        let url = URL(string: APIConstant.updateProfilePicGiver)!
        
        // Create the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Set authorization header if needed
//        request.setValue("Bearer \(defaults.accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("Bearer \(defaults.accessToken)", forHTTPHeaderField: "Authorization")

        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        
        // Add image data
        data.append("--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        data.append(file)
        data.append("\r\n".data(using: .utf8)!)
        
        data.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Set the request body
        request.httpBody = data
        
        // Create URLSession task
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            // Handle response if needed
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
                // Handle success or failure based on status code
            }
            
            if let data = data {
                // Handle response data if needed
                let responseString = String(data: data, encoding: .utf8)
                print("Response: \(responseString ?? "")")
                do {
                    if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        let apiData = EmptyRegister(jsonData: jsonObject)
                        if apiData.success{
                            completionHandler(.success(apiData))
                        }else{
                            completionHandler(.failure(.custom(apiData.message)))
                        }
                    }else{
                        completionHandler(.failure(.somethingWentWrong))
                    }
                    
                }catch{
                    completionHandler(.failure(.somethingWentWrong))
                }
            }
        }.resume()
        
    }
    
    func uploadProfilePicSeeker(profileID: String, file:Data, fileName: String,completionHandler :  @escaping (Results<EmptyRegister, NetworkError>) -> Void){
        let url = URL(string: APIConstant.updateProfilePicSeeker)!
        
        // Create the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Set authorization header if needed
        request.setValue("Bearer \(defaults.accessToken)", forHTTPHeaderField: "Authorization")
        
        // Prepare the multipart form data
        let parameters = ["key": "value", "profileId": profileID] // Updated parameters
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        
        // Add parameters
        for (key, value) in parameters {
            data.append("--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            data.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        // Add image data
        data.append("--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        data.append(file)
        data.append("\r\n".data(using: .utf8)!)
        
        data.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Set the request body
        request.httpBody = data
        
        // Create URLSession task
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            // Handle response if needed
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
                // Handle success or failure based on status code
            }
            
            if let data = data {
                // Handle response data if needed
                let responseString = String(data: data, encoding: .utf8)
                print("Response: \(responseString ?? "")")
                do {
                    if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        let apiData = EmptyRegister(jsonData: jsonObject)
                        if apiData.success{
                            completionHandler(.success(apiData))
                        }else{
                            completionHandler(.failure(.custom(apiData.message)))
                        }
                    }else{
                        completionHandler(.failure(.somethingWentWrong))
                    }
                    
                }catch{
                    completionHandler(.failure(.somethingWentWrong))
                }
            }
        }.resume()
        
    }
        
    func uploadProfile(file:Data, fileName: String,completionHandler :  @escaping (Results<EmptyRegister, NetworkError>) -> Void){
        let mimeType = "image/png"
        
        guard let url = URL(string: APIConstant.uploadProfile) else {return}
        let request = MultipartFormDataRequest(url: url)
        request.addDataField(fieldName:  "file", fileName: fileName, data: file, mimeType: mimeType)
        URLSession.shared.dataTask(with: request, completionHandler: {[weak self](data, response, error) in
            
            if let error = error{
                print(error)
                completionHandler(.failure(.custom(error.localizedDescription)))
                return
            }
            print(response as? HTTPURLResponse ?? HTTPURLResponse())
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200,response.statusCode < 400 else {
                return completionHandler(.failure(NetworkError.invalidResponse))
            }
            
            guard  let data = data else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
            
            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    let apiData = EmptyRegister(jsonData: jsonObject)
                    if apiData.success{
                        completionHandler(.success(apiData))
                    }else{
                        completionHandler(.failure(.custom(apiData.message)))
                    }
                }else{
                    completionHandler(.failure(.somethingWentWrong))
                }
            }catch{
                completionHandler(.failure(.somethingWentWrong))
            }
        }).resume()
    }
    
    func activateAccount(params:[String:Any]?,completionHandler :  @escaping (Results<Empty, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.activateAccount, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = Empty(jsonData: object)
                if responseModel.success {
                    self.defaults.accessToken = responseModel.data.accessToken
                    self.defaults.refreshToken = responseModel.data.refrenceToken
                    self.defaults.userType = responseModel.data.userTypes
                    self.defaults.firstName = responseModel.data.userInfo.name
                    self.defaults.userId = responseModel.data.userInfo.id
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
    func postGoogleSignup(params:[String:Any]?,completionHandler :  @escaping (Results<Empty, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.googleSignup, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = Empty(jsonData: object)
                if responseModel.success {
                    self.defaults.accessToken = responseModel.data.accessToken
                    self.defaults.refreshToken = responseModel.data.refrenceToken
                    self.defaults.userType = responseModel.data.userTypes
                    self.defaults.firstName = responseModel.data.userInfo.name
                    self.defaults.userId = responseModel.data.userInfo.id
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func postCareGiverCreateProfile(params:[String:Any]?,completionHandler :  @escaping (Results<EmptyRegister, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.careGiverCreateProfile, method: .POST,parameters: params,headers: commonHeaders) { result in
            switch result {
            case .success(let response):
                let apiData = EmptyRegister(jsonData: response)
                if apiData.success{
                    completionHandler(.success(apiData))
                }else{
                    completionHandler(.failure(.custom(apiData.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func postCareSeekerCreateProfile(params:[String:Any]?,completionHandler :  @escaping (Results<EmptyRegister, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.profileUpdate, method: .POST,parameters: params,headers: commonHeaders) { result in
            switch result {
            case .success(let response):
                let apiData = EmptyRegister(jsonData: response)
                if apiData.success{
                    completionHandler(.success(apiData))
                }else{
                    completionHandler(.failure(.custom(apiData.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func sendOTP(params:[String:Any]?,completionHandler :  @escaping (Results<SendOTPModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.sendOTP, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = SendOTPModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func verifyOTP(params:[String:Any]?,completionHandler :  @escaping (Results<SendOTPModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.verifyOTP, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = SendOTPModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func updateNotification(params:[String:Any]?,completionHandler :  @escaping (Results<SendOTPModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.updateNotification, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = SendOTPModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func deactivateAccount(completionHandler :  @escaping (Results<SendOTPModel, NetworkError>) -> Void){
        
        
        APIClient.shared.request(endpoint: APIConstant.deactivateAccount, method: .POST, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = SendOTPModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getLobbyStatus(completionHandler :  @escaping (Results<BGVInterviewSlotBookedStatusModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.lobbyStatus, method: .POST, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = BGVInterviewSlotBookedStatusModel(jsondata: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getInboxList(params:[String:Any]?,completionHandler :  @escaping (Results<ChatListModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.getInboxList, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = ChatListModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getMyServices(completionHandler :  @escaping (Results<MyServiceModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.myServices,
                                 method: .GET,
                                 headers: commonHeaders) { result in
            switch result{
            case .success(let response):
                let apiData = MyServiceModel(jsonData: response)
                if apiData.success{
                    completionHandler(.success(apiData))
                }else{
                    completionHandler(.failure(.custom(apiData.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
    func getDistanceArray(completionHandler :  @escaping (Results<DistanceModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.getDistanceArray, method: .POST, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = DistanceModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getBankList(completionHandler :  @escaping (Results<BankListModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.getBankList,
                                 method: .GET,
                                 headers: commonHeaders) { result in
            switch result{
            case .success(let response):
                let apiData = BankListModel(jsonData: response)
                if apiData.success{
                    completionHandler(.success(apiData))
                }else{
                    completionHandler(.failure(.custom(apiData.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getWallet(completionHandler :  @escaping (Results<WalletAmountModel, NetworkError>) -> Void){
        APIClient.shared.request(endpoint: APIConstant.getWalletById,
                                 method: .GET,
                                 headers: commonHeaders) { result in
            switch result{
            case .success(let response):
                let apiData = WalletAmountModel(jsonData: response)
                if apiData.success{
                    completionHandler(.success(apiData))
                }else{
                    completionHandler(.failure(.custom(apiData.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getNotification(completionHandler :  @escaping (Results<SettingNotificationModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.getNotification,
                                 method: .GET,
                                 headers: commonHeaders) { result in
            switch result{
            case .success(let response):
                let apiData = SettingNotificationModel(jsonData: response)
                if apiData.success{
                    completionHandler(.success(apiData))
                }else{
                    completionHandler(.failure(.custom(apiData.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getAllTransaction(params:[String:Any]?,completionHandler :  @escaping (Results<TransectionListModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.getAllTransaction, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = TransectionListModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
    func addBank(params:[String:Any]?,completionHandler :  @escaping (Results<TransectionListModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.createBankAccount, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = TransectionListModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func transferAmountToStripe(params:[String:Any]?,completionHandler :  @escaping (Results<TransectionListModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.transferAmountToStripe, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = TransectionListModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func transferAmountToAccount(params:[String:Any]?,completionHandler :  @escaping (Results<TransectionListModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.transferAmountToAccount, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = TransectionListModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getMeetingToken(completionHandler :  @escaping (Results<BGVInterviewMeetingTokenModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.getMeetingToken, method: .POST, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = BGVInterviewMeetingTokenModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func bookSlot(params:[String:Any]?,completionHandler :  @escaping (Results<EmptyRegister, NetworkError>) -> Void){
       
        APIClient.shared.request(endpoint: APIConstant.bookSlot, method: .POST,parameters: params,headers: commonHeaders) { result in
            switch result {
            case .success(let response):
                let apiData = EmptyRegister(jsonData: response)
                if apiData.success{
                    completionHandler(.success(apiData))
                }else{
                    completionHandler(.failure(.custom(apiData.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getSlotList(params:[String:Any]?,completionHandler :  @escaping (Results<BGVInterviewSlotsListModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.getSlotList, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = BGVInterviewSlotsListModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom("Server Error")))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getOrderInvoice(params:[String:Any]?,completionHandler :  @escaping (Results<PaymentOrderModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.serviceInvoice, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = PaymentOrderModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func payCaregiverBooking(params:[String:Any]?,completionHandler :  @escaping (Results<PaymentOrderModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.payCaregiverBooking, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = PaymentOrderModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getChatHistory(params:[String:Any]?,completionHandler :  @escaping (Results<MessageModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.getChatHistory, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = MessageModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom("Server Error")))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func chatVideoCall(params:[String:Any]?,completionHandler :  @escaping (Results<BGVInterviewMeetingTokenModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.chatVideoCall, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = BGVInterviewMeetingTokenModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func chatVideoCallID(params:[String:Any]?,completionHandler :  @escaping (Results<BGVInterviewMeetingTokenModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.chatVideoCallRecieve, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = BGVInterviewMeetingTokenModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getPaypalOrderID(params:[String:Any]?,completionHandler :  @escaping (Results<PaypalOrderModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.getPaypalOrderID, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = PaypalOrderModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func confirmPaypalOrderID(params:[String:Any]?,completionHandler :  @escaping (Results<PaymentModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.confirmPaypalOrderID, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = PaymentModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func applePayPaymentConfirm(params:[String:Any]?,completionHandler :  @escaping (Results<PaymentModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.applePayPayment, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = PaymentModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getCareGiverDetails(giverId: String,bookingId: String,completionHandler :  @escaping (Results<CareGiverDetailModel, NetworkError>) -> Void){
        APIClient.shared.request(endpoint: "\(APIConstant.getCareGiverInCustomerDetails)\(giverId)&booking_id=\(bookingId)",
                                 method: .GET,
                                 headers: commonHeaders) { result in
            switch result{
            case .success(let response):
                let apiData = CareGiverDetailModel(jsonData: response)
                if apiData.success{
                    completionHandler(.success(apiData))
                }else{
                    completionHandler(.failure(.custom(apiData.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getCustomerRequirements(param:[String:Any],completionHandler :  @escaping (Results<RecommendedBookingModel, NetworkError>) -> Void){
        APIClient.shared.request(endpoint: APIConstant.getCustomerRequirements, method: .POST,parameters: param,headers: commonHeaders) { result in
            switch result{
            case .success(let response):
                let apiData = RecommendedBookingModel(jsonData: response)
                if apiData.success{
                    completionHandler(.success(apiData))
                }else{
                    completionHandler(.failure(.custom(apiData.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
    func sendRequestForBookCaregiver(params:[String:Any]?,completionHandler :  @escaping (Results<RecommendGiverModel, NetworkError>) -> Void){
        
        
        APIClient.shared.request(endpoint: APIConstant.sendRequestForBookCaregiver, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = RecommendGiverModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func conversationWithAdmin(params:[String:Any]?,completionHandler :  @escaping (Results<FAQModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.conversationWithAdmin, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = FAQModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func deletebooking(params:[String:Any]?,completionHandler :  @escaping (Results<RecommendGiverModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.deletebooking, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = RecommendGiverModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func createConversation(params:[String:Any]?,completionHandler :  @escaping (Results<RecommendGiverModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.createConversation, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = RecommendGiverModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getRelativeList(params:[String:Any]? = nil,completionHandler :  @escaping (Results<RelativeModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.getRelativeList, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = RelativeModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getRecommandationList(params:[String:Any]? = nil,completionHandler :  @escaping (Results<BookingRecommendationModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.getRecommandationList, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = BookingRecommendationModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func customerSvcAct(completionHandler :  @escaping (Results<ServiceStartModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.customerSvcAct, method: .POST, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = ServiceStartModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func logout(completionHandler :  @escaping (Results<ServiceStartModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.logout, method: .POST, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = ServiceStartModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func caregiverSvcAct(completionHandler :  @escaping (Results<ServiceStartModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.caregiverSvcAct, method: .POST, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = ServiceStartModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getBannerUrls(params:[String:Any]? = nil,completionHandler :  @escaping (Results<BannerModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.getBannerUrls, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = BannerModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func customerConfirmStartService(params:[String:Any]? = nil,completionHandler :  @escaping (Results<ServiceStartModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.customerConfirmStartService, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = ServiceStartModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func payForService(params:[String:Any]? = nil,completionHandler :  @escaping (Results<ServiceStartModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.payForService, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = ServiceStartModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func giverConfirmStartService(params:[String:Any]? = nil,completionHandler :  @escaping (Results<ServiceStartModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.giverConfirmStartService, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = ServiceStartModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func giverCancelStartService(params:[String:Any]? = nil,completionHandler :  @escaping (Results<ServiceStartModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.cancelStartService, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = ServiceStartModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getJobsNearYouList(params:[String:Any]? = nil,completionHandler :  @escaping (Results<JobsModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.getJobsNearYouList, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = JobsModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
    func stripeCardList(completionHandler :  @escaping (Results<StripeCardListModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.stripeCardList,
                                 method: .GET,headers: commonHeaders) { result in
            switch result{
            case .success(let response):
                let apiData = StripeCardListModel(jsonData: response)
                if apiData.success{
                    completionHandler(.success(apiData))
                }else{
                    completionHandler(.failure(.custom(apiData.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func deleteStripeCard(params:[String:Any]?,completionHandler :  @escaping (Results<StripeCustomerModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.deleteStripeCard, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = StripeCustomerModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func stripeCharge(params:[String:Any]?,completionHandler :  @escaping (Results<StripeCustomerModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.stripeCharge, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = StripeCustomerModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func stripeCreateCustomer(params:[String:Any]?,completionHandler :  @escaping (Results<StripeCustomerModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.stripeCreateCustomer, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = StripeCustomerModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func stripeCreateSetupIntent(params:[String:Any]?,completionHandler :  @escaping (Results<StripeClientSecretModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.stripeCreateSetupIntent, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = StripeClientSecretModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getPersonalDetailsGiver(params:[String:Any]? = nil,completionHandler :  @escaping (Results<PersonalGiverModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.personalDetailsGiver, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = PersonalGiverModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom("Server Error")))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
    
    func getProfileGiver(params:[String:Any]? = nil,completionHandler :  @escaping (Results<ProfileGiverModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.getProfileGiver, method: .POST,parameters: params,headers: commonHeaders) { result in
            switch result{
            case .success(let response):
                let apiData = ProfileGiverModel(jsonData: response)
                if apiData.success{
                    print(apiData)
                    completionHandler(.success(apiData))
                }else{
                    completionHandler(.failure(.custom(apiData.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getAddress(params:[String:Any]? = nil,completionHandler :  @escaping (Results<ZipCpdeModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.getAddress, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = ZipCpdeModel(jsonData: object)
                
                completionHandler(.success(responseModel))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getProfile(params:[String:Any]? = nil,completionHandler :  @escaping (Results<ProfileModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.getProfile, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = ProfileModel(jsonData: object)
                
                completionHandler(.success(responseModel))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getProfileList(params:[String:Any]? = nil,completionHandler :  @escaping (Results<ProfileListModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.profileList, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = ProfileListModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message ?? "")))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getPersonalDetails(params:[String:Any]? = nil,completionHandler :  @escaping (Results<PersonalModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.getPersonalDetails, method: .POST,parameters: params,headers: commonHeaders) { result in
            switch result{
            case .success(let response):
                let personalModel = PersonalModel(jsonData: response)
                if personalModel.success{
                    completionHandler(.success(personalModel))
                }else{
                    completionHandler(.failure(.custom(personalModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func deleteProfile(params:[String:Any]? = nil,completionHandler :  @escaping (Results<EmptyRegister, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.deleteProfile, method: .POST,parameters: params,headers: commonHeaders) { result in
            switch result {
            case .success(let response):
                let apiData = EmptyRegister(jsonData: response)
                if apiData.success{
                    completionHandler(.success(apiData))
                }else{
                    completionHandler(.failure(.custom(apiData.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func addNewProfile(params:[String:Any]? = nil,completionHandler :  @escaping (Results<EmptyRegister, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.profileUpdate, method: .POST,parameters: params,headers: commonHeaders) { result in
            switch result {
            case .success(let response):
                let apiData = EmptyRegister(jsonData: response)
                if apiData.success{
                    completionHandler(.success(apiData))
                }else{
                    completionHandler(.failure(.custom(apiData.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func updateProfile(params:[String:Any]? = nil,completionHandler :  @escaping (Results<EmptyRegister, NetworkError>) -> Void){
        
        var urlStr = ""
        
        if Defaults().userType == AppConstants.GiveCare {
            urlStr = APIConstant.updateProfileGiver
        }
        else {
            urlStr = APIConstant.profileUpdate
        }
        
        APIClient.shared.request(endpoint: urlStr, method: .POST,parameters: params,headers: commonHeaders) { result in
            switch result {
            case .success(let response):
                let apiData = EmptyRegister(jsonData: response)
                if apiData.success{
                    completionHandler(.success(apiData))
                }else{
                    completionHandler(.failure(.custom(apiData.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func createDraftBooking(params:[String:Any]? = nil,completionHandler :  @escaping (Results<CreateDraftModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.createDraftBooking, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = CreateDraftModel(jsonData: object)
                if responseModel.status {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func createBooking(params:[String:Any]? = nil,completionHandler :  @escaping (Results<BookingModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.createBooking, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = BookingModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func findCareGiverBookingID(params:[String:Any]? = nil,completionHandler :  @escaping (Results<CareGiverNearByCustomerScreenModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.findCareGiverBookingID, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = CareGiverNearByCustomerScreenModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getBookings(params:[String:Any]? = nil,completionHandler :  @escaping (Results<BookingsListModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.getBookings, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = BookingsListModel(jsondata: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getDraftList(params:[String:Any]? = nil,completionHandler :  @escaping (Results<DraftListModel, NetworkError>) -> Void){
        
        
        APIClient.shared.request(endpoint: APIConstant.getDraftList, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = DraftListModel(jsondata: object)
                if responseModel.status {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getOrderList(params:[String:Any]? = nil,completionHandler :  @escaping (Results<OrderListModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.OrderList, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = OrderListModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getJobList(params:[String:Any]? = nil,completionHandler :  @escaping (Results<JobsModel, NetworkError>) -> Void){
        
        
        APIClient.shared.request(endpoint: APIConstant.getJobList, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = JobsModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func addReview(params:[String:Any]? = nil,completionHandler :  @escaping (Results<BookingsListModel, NetworkError>) -> Void){
        var url = String()
        if Defaults().userType == AppConstants.GiveCare {
            url = APIConstant.addReviewGiver
        }else{
            url = APIConstant.addReview
        }
        
        APIClient.shared.request(endpoint: url, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = BookingsListModel(jsondata: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
    func bookingCancel(params:[String:Any]? = nil,completionHandler :  @escaping (Results<CancelSeriveDetailModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.bookingCancel, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = CancelSeriveDetailModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    func updateMyService(params:[String:Any]? = nil,completionHandler :  @escaping (Results<CancelSeriveDetailModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.updateMyService, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = CancelSeriveDetailModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func cancelBookingData(params:[String:Any]? = nil,completionHandler :  @escaping (Results<CancelSeriveDetailModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.cancelBookingData, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = CancelSeriveDetailModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getBookingReview(params:[String:Any]? = nil,completionHandler :  @escaping (Results<ReviewDetailModel, NetworkError>) -> Void){
        var url = String()
        if Defaults().userType == AppConstants.GiveCare {
            url = APIConstant.bookingReviewsGiver
        }else{
            url = APIConstant.bookingReviews
        }
        
        APIClient.shared.request(endpoint: url, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = ReviewDetailModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getCareGiverBookings(params:[String:Any]? = nil,completionHandler :  @escaping (Results<BookingsListModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.getCareGiverBookings, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = BookingsListModel(jsondata: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }

    }
    
    func getDraftDetails(draftId:String,completionHandler :  @escaping (Results<DraftDetailModel, NetworkError>) -> Void){
        
        let parameters = ["draft_id":draftId]
        
        APIClient.shared.request(endpoint: APIConstant.getDraftDetails, method: .POST,parameters: parameters,headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = DraftDetailModel(jsonData: object)
                if responseModel.status {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getBookingDetailsById(bookingId:String,completionHandler :  @escaping (Results<BookingIDModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: "\(APIConstant.getBookingDetailsById)\(bookingId)", method: .GET,headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = BookingIDModel(jsondata: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getUserStatus(completionHandler :  @escaping (Results<UserStatusModel, NetworkError>) -> Void){
        
        APIClient.shared.request(endpoint: APIConstant.getUserStatus, method: .GET,headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = UserStatusModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getMyReviews(myReviews: Bool, careGiver: Bool, params:[String:Any]? = nil,completionHandler :  @escaping (Results<ReviewModel, NetworkError>) -> Void){
        
        var url = ""
        
        if myReviews {
            url = APIConstant.reviewsSeeker
            if careGiver {
                url = APIConstant.reviewsGiver
            }
        }
        else {
            url = APIConstant.givenReviewsSeeker
            if careGiver {
                url = APIConstant.givenReviewsGiver
            }
        }
        
        guard let urlStr = URL(string:url) else {
            return completionHandler(.failure(NetworkError.invalidURL))
        }
        var request = URLRequest(url: urlStr)
    
        if let parameters = params{
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = jsonData
        }
        
        request.allHTTPHeaderFields = commonHeaders
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) {[weak self](data, response, error) in
            
            if let error = error{
                print(error)
                completionHandler(.failure(.custom(error.localizedDescription)))
                return
            }
            print(response as? HTTPURLResponse ?? HTTPURLResponse())
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200,response.statusCode < 400 else {
                return completionHandler(.failure(NetworkError.invalidResponse))
            }
            
            guard  let data = data else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
            
            do {
                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiData = try decoder.decode(ReviewModel.self, from: data)
                if apiData.success{
                    print(apiData)
                    completionHandler(.success(apiData))
                }else{
                    completionHandler(.failure(.custom(apiData.message ?? "")))

                }
            }catch{
                completionHandler(.failure(.somethingWentWrong))
            }
        }
        task.resume()
    }
    
    func viewReviews(careGiver: Bool, params:[String:Any]? = nil,completionHandler :  @escaping (Results<ReviewDetailModel, NetworkError>) -> Void){
                
        var urlStr = APIConstant.viewReviewSeeker
        if careGiver {
            urlStr = APIConstant.viewReviewGiver
        }
        
        APIClient.shared.request(endpoint: urlStr, method: .POST, parameters: params, headers: commonHeaders) { result in
            switch result {
            case .success(let object):
                let responseModel = ReviewDetailModel(jsonData: object)
                if responseModel.success {
                    completionHandler(.success(responseModel))
                }else{
                    completionHandler(.failure(.custom(responseModel.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func updateApprochStatus(params:[String:Any]? = nil,completionHandler :  @escaping (Results<JobAcceptModel, NetworkError>) -> Void){
                
        guard let urlStr = URL(string:APIConstant.updateApprochStatus) else {
            return completionHandler(.failure(NetworkError.invalidURL))
        }
        var request = URLRequest(url: urlStr)
    
        if let parameters = params{
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = jsonData
        }
        
        request.allHTTPHeaderFields = commonHeaders
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) {[weak self](data, response, error) in
            
            if let error = error{
                print(error)
                completionHandler(.failure(.custom(error.localizedDescription)))
                return
            }
            print(response as? HTTPURLResponse ?? HTTPURLResponse())
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200,response.statusCode < 400 else {
                return completionHandler(.failure(NetworkError.invalidResponse))
            }
            
            guard  let data = data else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
            
            do {
                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiData = try decoder.decode(JobAcceptModel.self, from: data)
                if apiData.success{
                    print(apiData)
                    completionHandler(.success(apiData))
                }else{
                    completionHandler(.failure(.custom(apiData.message)))

                }
            }catch{
                completionHandler(.failure(.somethingWentWrong))
            }
        }
        task.resume()
    }
    
    
    func getJobsDetailsForCustomer(approachID: String,completionHandler :  @escaping (Results<JobDetailModel, NetworkError>) -> Void){
        APIClient.shared.request(endpoint: "\(APIConstant.bookingDetailsForCustomer)?approch_id=\(approachID)",
                                 method: .GET,headers: commonHeaders) { result in
            switch result{
            case .success(let response):
                let apiData = JobDetailModel(jsonData: response)
                if apiData.success{
                    completionHandler(.success(apiData))
                }else{
                    completionHandler(.failure(.custom(apiData.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getJobsDetails(approachID: String,completionHandler :  @escaping (Results<JobDetailModel, NetworkError>) -> Void){
        APIClient.shared.request(endpoint: "\(APIConstant.bookingDetailsForCaregiver)?approch_id=\(approachID)",
                                 method: .GET,headers: commonHeaders) { result in
            switch result{
            case .success(let response):
                let apiData = JobDetailModel(jsonData: response)
                if apiData.success{
                    completionHandler(.success(apiData))
                }else{
                    completionHandler(.failure(.custom(apiData.message)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
