//
//  MovieService.swift
//  fenix
//
//  Created by Ismail Tever on 2.12.2023.
//

import Foundation
import Alamofire

final class MovieService {
    
    static let shared = MovieService()
    
    enum ImagePath {
        case posterPathString
        case backdropPathString
    }
    
    func getMovies(query: String, page: Int, success: @escaping(Movies)->(), failure: @escaping(ErrorMessage)->()) {
        
        let urlWithSearchParams = Request.movies.path + "&query=" + query + "&page=" + String(page)
        NetworkManager.shared.request(type: Movies.self, url: urlWithSearchParams, headers: Header.shared.header(), params: nil, method: .get) { response in
            switch response {
            case .success(let movies):
                success(movies)
            case .messageFailure(let errorMessage):
                failure(errorMessage)
            }
        }
    }
    
    func getMovieImage(imgURL: String,imgPath: ImagePath, success: @escaping (Data?) -> Void,  failure: @escaping(ErrorMessage)->()) {
        
        var imgPathStr = ""
        
        switch imgPath {
        case .backdropPathString:
            imgPathStr = Request.wideImage.path + imgURL
        case .posterPathString:
            imgPathStr = Request.posterImage.path + imgURL
        }
        
        NetworkManager.shared.requestImage(type: Data.self, url: imgPathStr, headers: nil, params: nil, method: .get) { response in
            
            switch response {
            case .success(let movieImageData):
                success(movieImageData)
            case .messageFailure(let errorMessage):
                failure(errorMessage)
            }
        }
    }
}
