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
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
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
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
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
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
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
    
    func sendOTP(params:[String:Any]?,completionHandler :  @escaping (Results<SendOTPModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.sendOTP) else {
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
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data) as? [String:Any] ?? [String:Any]()
                let apiData = SendOTPModel(jsonData: parsedData)
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
    
    func getLobbyStatus(completionHandler :  @escaping (Results<BGVInterviewSlotBookedStatusModel, NetworkError>) -> Void){
        
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
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data) as? [String:Any] ?? [String:Any]()
                let apiData = BGVInterviewSlotBookedStatusModel(jsondata: parsedData)
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
    
    func getMeetingToken(completionHandler :  @escaping (Results<BGVInterviewMeetingTokenModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.getMeetingToken) else {
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
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data) as? [String:Any] ?? [String:Any]()
                let apiData = BGVInterviewMeetingTokenModel(jsonData: parsedData)
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
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
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
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data) as? [String:Any] ?? [String:Any]()
                let apiData = BGVInterviewSlotsListModel(jsonData: parsedData)
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
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data) as? [String:Any] ?? [String:Any]()
                let apiData = CareGiverDetailModel(jsonData: parsedData)
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
    
    func sendRequestForBookCaregiver(params:[String:Any]?,completionHandler :  @escaping (Results<CareGiverDetailModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:"\(APIConstant.sendRequestForBookCaregiver)") else {
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
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data) as? [String:Any] ?? [String:Any]()
                let apiData = CareGiverDetailModel(jsonData: parsedData)
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
    
    func getRelativeList(params:[String:Any]? = nil,completionHandler :  @escaping (Results<RelativeModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.getRelativeList) else {
            return completionHandler(.failure(NetworkError.invalidURL))
        }
        var request = URLRequest(url: urlStr)
    
        if let parameters = params{
            print(parameters)
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
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
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
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data) as? [String:Any] ?? [String:Any]()
                let apiData = BookingRecommendationModel(jsonData: parsedData)
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
                let parsedData = try JSONSerialization.jsonObject(with: data) as? [String:Any] ?? [String:Any]()
                let apiData = JobsModel(jsonData: parsedData)
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
    
    func getPersonalDetailsGiver(params:[String:Any]? = nil,completionHandler :  @escaping (Results<PersonalGiverModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.personalDetailsGiver) else {
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
                let apiData = try decoder.decode(PersonalGiverModel.self, from: data)
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
    
    func getPersonalDetails(params:[String:Any]? = nil,completionHandler :  @escaping (Results<PersonalModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.getPersonalDetails) else {
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
                let apiData = try decoder.decode(PersonalModel.self, from: data)
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
    
    func getProfileGiver(params:[String:Any]? = nil,completionHandler :  @escaping (Results<ProfileGiverModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.getProfileGiver) else {
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
                let apiData = try decoder.decode(ProfileGiverModel.self, from: data)
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
    
    func getProfile(params:[String:Any]? = nil,completionHandler :  @escaping (Results<ProfileModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.getProfile) else {
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
                let apiData = try decoder.decode(ProfileModel.self, from: data)
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
    
    func getProfileList(params:[String:Any]? = nil,completionHandler :  @escaping (Results<ProfileListModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.profileList) else {
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
                let apiData = try decoder.decode(ProfileListModel.self, from: data)
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
    
    func deleteProfile(params:[String:Any]? = nil,completionHandler :  @escaping (Results<EmptyRegister, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.deleteProfile) else {
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
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
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
    
    func addNewProfile(params:[String:Any]? = nil,completionHandler :  @escaping (Results<EmptyRegister, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.createProfile) else {
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
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
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
    
    func updateProfile(params:[String:Any]? = nil,completionHandler :  @escaping (Results<EmptyRegister, NetworkError>) -> Void){
        
        var urlStr = ""
        
        if Defaults().userType == AppConstants.GiveCare {
            urlStr = APIConstant.updateProfileGiver
        }
        else {
            urlStr = APIConstant.updateProfile
        }
        
        guard let urlStr = URL(string:urlStr) else {
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
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
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
    
    func createBooking(params:[String:Any]? = nil,completionHandler :  @escaping (Results<BookingModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.createBooking) else {
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
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
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
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data) as? [String:Any] ?? [String:Any]()
                let apiData = CareGiverNearByCustomerScreenModel(jsonData: parsedData)
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
    
    func getBookings(params:[String:Any]? = nil,completionHandler :  @escaping (Results<BookingsListModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.getBookings) else {
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
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data) as? [String:Any] ?? [String:Any]()
                let apiData = BookingsListModel(jsondata: parsedData)
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
    
    func getCareGiverBookings(params:[String:Any]? = nil,completionHandler :  @escaping (Results<BookingsListModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.getCareGiverBookings) else {
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
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data) as? [String:Any] ?? [String:Any]()
                let apiData = BookingsListModel(jsondata: parsedData)
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
    
    func getBookingDetailsById(bookingId:String,completionHandler :  @escaping (Results<BookingIDModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:"\(APIConstant.getBookingDetailsById)\(bookingId)") else {
            return completionHandler(.failure(NetworkError.invalidURL))
        }
        var request = URLRequest(url: urlStr)
        
        request.allHTTPHeaderFields = commonHeaders
        request.httpMethod = "GET"//"POST"
        
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
                let parsedData = try JSONSerialization.jsonObject(with: data) as? [String:Any] ?? [String:Any]()

                let apiData = BookingIDModel(jsondata: parsedData)
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
    
    func getUserStatus(completionHandler :  @escaping (Results<UserStatusModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:APIConstant.getUserStatus) else {
            return completionHandler(.failure(NetworkError.invalidURL))
        }
        var request = URLRequest(url: urlStr)
        
        request.allHTTPHeaderFields = commonHeaders
        request.httpMethod = "GET"//"POST"
        
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
                let parsedData = try JSONSerialization.jsonObject(with: data) as? [String:Any] ?? [String:Any]()

                let apiData = UserStatusModel(jsonData: parsedData)
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
        
        guard let urlStr = URL(string:urlStr) else {
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
                let apiData = try decoder.decode(ReviewDetailModel.self, from: data)
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
    
    func getJobsDetails(approachID: String,completionHandler :  @escaping (Results<JobDetailModel, NetworkError>) -> Void){
        
        guard let urlStr = URL(string:"\(APIConstant.bookingDetailsForCaregiver)?approch_id=\(approachID)") else {
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
            print(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")
            do {
                let decoder = JSONDecoder()
                let apiData = try decoder.decode(JobDetailModel.self, from: data)
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
