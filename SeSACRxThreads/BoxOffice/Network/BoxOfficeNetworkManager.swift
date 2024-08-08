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
    
    func boxOfficeFetch(data: String) -> Observable<Movie> {
        
    }
    
}
