//
//  NetworkManager.swift
//  fenix
//
//  Created by Ismail Tever on 2.12.2023.
//

import Foundation
import Alamofire
import AlamofireImage

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    func request<T: Decodable>(type: T.Type, url: String, headers:HTTPHeaders?, params:[String:Any]?, method:HTTPMethod, completion: @escaping(NetworkResponse<T>)->Void) {
        AF.request(url,
                   method: method,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: headers).responseData { response in
            self.handleResponseData(response: response) { complete in
                completion(complete)
            }
        }
    }
    
    func requestImage<T: Decodable>(type: T.Type, url: String, headers:HTTPHeaders?, params:[String:Any]?, method:HTTPMethod, completion: @escaping(NetworkResponse<T>)->Void) {
        AF.request(url,
                   method: method,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: headers).responseImage { response in
            self.handleResponseImage(response: response) { complete in
                completion(complete)
            }
        }
    }
    
    func handleResponseData<T: Decodable>(response: AFDataResponse<Data>, completion: (NetworkResponse<T>) -> ()) {
        if let code = response.response?.statusCode {
            switch code {
            case 200...299:
                guard let data = response.data, let model = try? JSONDecoder().decode(T.self, from: data) else { return }
                completion(.success(model))
                
            default:
                completion(.messageFailure(ErrorMessage(error: "Server Error")))
            }
        }
    }
    
    func handleResponseImage<T: Decodable>(response: AFDataResponse<Image>, completion: (NetworkResponse<T>) -> ()) {
        if let code = response.response?.statusCode {
            switch code {
            case 200...299:
                let imageData = response.data
                completion(.success(imageData as! T))
            default:
                completion(.messageFailure(ErrorMessage(error: "Server Error")))
            }
        }
    }
}
