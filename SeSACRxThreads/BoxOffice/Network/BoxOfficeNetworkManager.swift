//
//  BoxOfficeNetworkManager.swift
//  SeSACRxThreads
//
//  Created by 전준영 on 8/8/24.
//

import Foundation
import RxSwift

enum APIError: Error {
    case invalidURL
    case unknownResponse
    case statusError
}

final class BoxOfficeNetworkManager {
    
    static let shared = BoxOfficeNetworkManager()
    private init() { }
    
    func boxOfficeFetch(date: String) -> Single<Movie> {
        let url = "\(APIURL.boxOfficeURL)\(date)"
        
        let result = Single<Movie>.create { single in
            guard let url = URL(string: url) else {
                single(.failure(APIError.invalidURL))
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    single(.failure(APIError.unknownResponse))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    single(.failure(APIError.statusError))
                    return
                }
                
                guard let data = data else {
                    single(.failure(APIError.unknownResponse))
                    return
                }
                
                do {
                    let appData = try JSONDecoder().decode(Movie.self, from: data)
                    single(.success(appData))
                } catch {
                    single(.failure(APIError.unknownResponse))
                }
                
            }.resume()
            
            return Disposables.create()
        }
        
        return result
    }
    
}
