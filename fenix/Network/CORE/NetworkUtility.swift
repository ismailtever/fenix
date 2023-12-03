//
//  NetworkUtility.swift
//  fenix
//
//  Created by Ismail Tever on 2.12.2023.
//

import Foundation
import Alamofire

enum ApiConfig: String {
    case baseUrl = "https://api.themoviedb.org/3"
    case apiKey = "ae304e3f4d3830d95075ae6914b55ddf"
    case baseImgURL = "https://image.tmdb.org/t/p"
}

struct Header {
    static let shared = Header()
    func header() -> HTTPHeaders { return ["Content-Type": "application/json"] }
}

enum NetworkResponse<T> {
    case success(T)
    case messageFailure(ErrorMessage)
}

enum Endpoint: String {
    case search = "/search/movie"
    case posterImage = "/w220_and_h330_face/"
    case wideImage = "/w500/"
}

enum Request {
    case movies, posterImage, wideImage
    var path: String {
        switch self {
        case .movies:
            return requestUrl(url: Endpoint.search.rawValue)
        case .posterImage:
            return requestImage(url: Endpoint.posterImage.rawValue)
        case .wideImage:
            return requestImage(url: Endpoint.wideImage.rawValue)
        }
    }
    
    func requestUrl(url: String) -> String {
        return ApiConfig.baseUrl.rawValue + url + "?api_key=\(ApiConfig.apiKey.rawValue)"
    }
    
    func requestImage(url: String) -> String {
        return ApiConfig.baseImgURL.rawValue + url
    }
}

extension Data {
    func decode<T: Decodable>() throws -> T {
        return (try! JSONDecoder().decode(T.self, from: self))
    }
}
