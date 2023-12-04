//
//  MovieService.swift
//  fenix
//
//  Created by Ismail Tever on 2.12.2023.
//

import Foundation
import Alamofire
class MovieService {
    
    static let shared = MovieService()

    func getMovies(query: String , success: @escaping(Movies)->(), failure: @escaping(ErrorMessage)->()) {
    
        let urlWithSearchParams = Request.movies.path + "&query=" + query
        NetworkManager.shared.request(type: Movies.self, url: urlWithSearchParams, headers: Header.shared.header(), params: nil, method: .get) { response in
            switch response {
            case .success(let movies):
                success(movies)
            case .messageFailure(let errorMessage):
                failure(errorMessage)
            }
        }
    }
    
    func getMoviePosterImage(imgURL: String, completion: @escaping (Data?) -> Void) {
        let backdropPathString = Request.posterImage.path + imgURL
        guard let backdropURL = URL(string: backdropPathString) else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: backdropURL) { (data, response, error) in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            completion(data)
        }
        task.resume()
    }
    
    func getMovieWideImage(imgURL: String) -> Data? {
        let backdropPathString = Request.wideImage.path + imgURL
        guard let backdropURL = URL(string: backdropPathString) else { return nil }
            if let imageData = try? Data(contentsOf: backdropURL) {
                return imageData
            } else {
                print("Unable to fetch data")
                return nil
            }
    }
}
