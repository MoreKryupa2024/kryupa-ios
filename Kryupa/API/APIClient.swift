//
//  APIClient.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 22/05/24.
//

import Foundation
import Network

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

struct APIClient {
    
    static let shared = APIClient()
    
    private init() {}  // Singleton
    
    func request(
        endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]? = nil,
        headers: [String: String] = [:],
        completion: @escaping (Result<[String: Any], NetworkError>) -> Void
    ) {
        print("------------API Call Start\n")
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        print("URL:- \(endpoint)\n")
        print("Type:- \(method.rawValue)\n")
        print("Bearer: \(Defaults().accessToken)\n")
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        if let params = parameters, method != .GET {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
//                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                print("Parameters:- \(params)\n")
            } catch {
                completion(.failure(.custom("Failed to encode parameters")))
                return
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.custom(error.localizedDescription)))
                return
            }
            
            print("Response:- \(response as? HTTPURLResponse ?? HTTPURLResponse())\n")
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            print("Json:- \(String(data: data, encoding: String.Encoding.utf8) as String? ?? "Data not found")\n")
            
            print("------------API Call End\n")
            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    completion(.success(jsonObject))
                } else {
                    completion(.failure(.somethingWentWrong))
                }
            } catch {
                completion(.failure(.somethingWentWrong))
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
