//
//  SearchViewModel.swift
//  SeSACRxThreads
//
//  Created by 전준영 on 8/5/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {
    
    struct Input {
        
    }
    
    struct Output {
        let list: Observable<[String]>
    }
    
    func transform(input: Input) -> Output {
        var list = Observable.just(["A", "B", "C", "AB", "D", "ABC", "BBB", "EC", "SA", "AAAB", "ED", "F", "G", "H"])
        
        return Output(list: list)
    }
    
}
