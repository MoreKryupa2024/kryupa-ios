//
//  APIClient.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 15/05/24.
//

import Foundation

public enum RequestMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

class NetworkManager{
    
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
            print("Bearer: \(defaults.accessToken)")
        }
        return headerField
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
            print(String(data: data, encoding: .utf8)!)
            
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
            print(String(data: data, encoding: .utf8)!)
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiData = try decoder.decode(EmptyRegister.self, from: data)
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
    
    
    func postGoogleSignup(params:[String:Any]?,completionHandler :  @escaping (Results<Empty, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.googleSignup) else {
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
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiData = try decoder.decode(Empty.self, from: data)
                if apiData.success{
                    self?.defaults.accessToken = apiData.data.accessToken
                    self?.defaults.refreshToken = apiData.data.refrenceToken
                    self?.defaults.userType = apiData.data.userTypes
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
    
    func postCareGiverCreateProfile(params:[String:Any]?,completionHandler :  @escaping (Results<EmptyRegister, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.careGiverCreateProfile) else {
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
            print(String(data: data, encoding: .utf8)!)
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiData = try decoder.decode(EmptyRegister.self, from: data)
                if apiData.success{
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
    
    func postCareSeekerCreateProfile(params:[String:Any]?,completionHandler :  @escaping (Results<EmptyRegister, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.customerCreateProfile) else {
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
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiData = try decoder.decode(EmptyRegister.self, from: data)
                if apiData.success{
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
    
    func getLobbyStatus(completionHandler :  @escaping (Results<BGVInterviewSlotStatusModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.lobbyStatus) else {
            return completionHandler(.failure(NetworkError.invalidURL))
        }
        var request = URLRequest(url: urlStr)
        
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
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiData = try decoder.decode(BGVInterviewSlotStatusModel.self, from: data)
                if apiData.success{
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
    
    func bookSlot(params:[String:Any]?,completionHandler :  @escaping (Results<BGVInterviewSlotStatusModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.bookSlot) else {
            return completionHandler(.failure(NetworkError.invalidURL))
        }
        var request = URLRequest(url: urlStr)
    
        if let parameters = params{
            print(parameters)
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
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiData = try decoder.decode(BGVInterviewSlotStatusModel.self, from: data)
                if apiData.success{
                    completionHandler(.success(apiData))
                }else{
                    completionHandler(.failure(.somethingWentWrong))
                }
                
            }catch{
                completionHandler(.failure(.somethingWentWrong))
            }
        }
        task.resume()
    }
    
    func getSlotList(params:[String:Any]?,completionHandler :  @escaping (Results<BGVInterviewSlotsListModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.getSlotList) else {
            return completionHandler(.failure(NetworkError.invalidURL))
        }
        var request = URLRequest(url: urlStr)
    
        if let parameters = params{
            print(parameters)
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
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiData = try decoder.decode(BGVInterviewSlotsListModel.self, from: data)
                if apiData.success{
                    completionHandler(.success(apiData))
                }else{
                    completionHandler(.failure(.somethingWentWrong))
                }
                
            }catch{
                completionHandler(.failure(.somethingWentWrong))
            }
        }
        task.resume()
    }
    
    func getCareGiverDetails(giverId: String,completionHandler :  @escaping (Results<CareGiverDetailModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:"\(APIConstant.getCareGiverInCustomerDetails)\(giverId)") else {
            return completionHandler(.failure(NetworkError.invalidURL))
        }
        var request = URLRequest(url: urlStr)

        request.allHTTPHeaderFields = commonHeaders
        request.httpMethod = "GET"
        
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
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiData = try decoder.decode(CareGiverDetailModel.self, from: data)
                if apiData.success{
                    completionHandler(.success(apiData))
                }else{
                    completionHandler(.failure(.somethingWentWrong))
                }
                
            }catch{
                completionHandler(.failure(.somethingWentWrong))
            }
        }
        task.resume()
    }
    
    func getRelativeList(params:[String:Any]? = nil,completionHandler :  @escaping (Results<RelativeModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.getRelativeList) else {
            return completionHandler(.failure(NetworkError.invalidURL))
        }
        var request = URLRequest(url: urlStr)
    
        if let parameters = params{
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = jsonData
        }
        
        request.allHTTPHeaderFields = commonHeaders
        request.httpMethod = "GET"
        
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
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiData = try decoder.decode(RelativeModel.self, from: data)
                if apiData.success{
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
    
    func getRecommandationList(params:[String:Any]? = nil,completionHandler :  @escaping (Results<BookingRecommendationModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.getRecommandationList) else {
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
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiData = try decoder.decode(BookingRecommendationModel.self, from: data)
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
    
    func getJobsNearYouList(params:[String:Any]? = nil,completionHandler :  @escaping (Results<JobsModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.getJobsNearYouList) else {
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
                let apiData = try decoder.decode(JobsModel.self, from: data)
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
    
    func createBooking(params:[String:Any]? = nil,completionHandler :  @escaping (Results<BookingModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.createBooking) else {
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
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiData = try decoder.decode(BookingModel.self, from: data)
                if apiData.success{
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
    
    func findCareGiverBookingID(params:[String:Any]? = nil,completionHandler :  @escaping (Results<CareGiverNearByCustomerScreenModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.findCareGiverBookingID) else {
            return completionHandler(.failure(NetworkError.invalidURL))
        }
        var request = URLRequest(url: urlStr)
        print(params)
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
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiData = try decoder.decode(CareGiverNearByCustomerScreenModel.self, from: data)
                if apiData.success{
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
}

enum Results<T, F> {
  case success(T)
  case failure(F)
}

enum NetworkError:Error {
    case invalidURL
    case invalidHeaderValue
    case encryptionFailure
    case decryptionFailure
    case invalidResponse
    case noNetwork
    case somethingWentWrong
    case custom(String)
    
    func getMessage() -> String {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidHeaderValue: return "Header value is not string"
        case .encryptionFailure: return "Encryption Failed"
        case .decryptionFailure: return "Decryption Failed"
        case .invalidResponse: return "Invalid Response"
        case .noNetwork: return "Please Check Your Internet Connection."
        case .somethingWentWrong: return "Something went wrong"
        case let .custom(msg): return msg
        }
    }
}

struct MultipartFormDataRequest {
    private let boundary: String = UUID().uuidString
    var httpBody = NSMutableData()
    let url: URL
    private let defaults = Defaults()
    
    init(url: URL) {
        self.url = url
    }
    
    func addTextField(named name: String, value: String) {
        httpBody.appendString(textFormField(named: name, value: value))
    }
    
    private func textFormField(named name: String, value: String) -> String {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "Content-Type: text/plain; charset=ISO-8859-1\r\n"
        fieldString += "Content-Transfer-Encoding: 8bit\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"
        
        return fieldString
    }
    
    
    func addDataField(fieldName: String, fileName: String, data: Data, mimeType: String) {
        httpBody.append(dataFormField(fieldName: fieldName,fileName:fileName,data: data, mimeType: mimeType))
    }
    
    private func dataFormField(fieldName: String,
                               fileName: String,
                               data: Data,
                               mimeType: String) -> Data {
        let fieldData = NSMutableData()
        
        fieldData.appendString("--\(boundary)\r\n")
        fieldData.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
        fieldData.appendString("Content-Type: \(mimeType)\r\n")
        fieldData.appendString("\r\n")
        fieldData.append(data)
        fieldData.appendString("\r\n")
        return fieldData as Data
    }
    
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        if !self.defaults.accessToken.isEmpty {
            request.setValue("Bearer \(defaults.accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        httpBody.appendString("--\(boundary)--")
        request.httpBody = httpBody as Data
        return request
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}


extension URLSession {
    func dataTask(with request: MultipartFormDataRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
    -> URLSessionDataTask {
        return dataTask(with: request.asURLRequest(), completionHandler: completionHandler)
    }
}
