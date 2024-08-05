//
//  PhoneViewModel.swift
//  SeSACRxThreads
//
//  Created by 전준영 on 8/5/24.
//

import Foundation
import RxSwift
import RxCocoa

final class PhoneViewModel {
    
    struct Input {
        let phoneNumberText: ControlProperty<String?>
        let nextTap: ControlEvent<Void>
    }
    
    struct Output {
        let validation: Observable<Bool>
        let nextTapped: ControlEvent<Void>
        let checkNum: Observable<ControlProperty<String>.Element>
        let phoneNumber: BehaviorSubject<String>
    }
    
    func transform(input: Input) -> Output {
        let phoneNumber = BehaviorSubject(value: "010")
        
        let validation = input.phoneNumberText
            .orEmpty
            .map { $0.count >= 10 }
        
        let checkNum = input.phoneNumberText
            .orEmpty
            .map { $0.filter { char in
                guard Int(String(char)) != nil || String(char) == "" else { return false }
                return true
            }
            }
        
        return Output(validation: validation, nextTapped: input.nextTap, checkNum: checkNum, phoneNumber: phoneNumber)
    }
    
}
