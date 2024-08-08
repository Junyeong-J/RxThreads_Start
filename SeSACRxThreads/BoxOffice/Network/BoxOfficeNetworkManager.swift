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
    
    func boxOfficeFetch(date: String) -> Observable<Movie> {
        let url = "\(APIURL.boxOfficeURL)\(date)"
        
        let result = Observable<Movie>.create { observer in
            guard let url = URL(string: url) else {
                observer.onError(APIError.invalidURL)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    observer.onError(APIError.unknownResponse)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    observer.onError(APIError.statusError)
                    return
                }
                
                if let data = data, let appData = try? JSONDecoder().decode(Movie.self, from: data) {
                    observer.onNext(appData)
                    observer.onCompleted()
                } else {
                    observer.onError(APIError.unknownResponse)
                }
                
            }.resume()
            
            return Disposables.create()
        }
        
        return result
    }
    
}
