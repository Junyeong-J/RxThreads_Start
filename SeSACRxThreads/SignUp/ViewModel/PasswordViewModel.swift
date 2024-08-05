//
//  PasswordViewModel.swift
//  SeSACRxThreads
//
//  Created by 전준영 on 8/5/24.
//

import Foundation
import RxSwift
import RxCocoa

final class PasswordViewModel {
    
    struct Input {
        let passwordText: ControlProperty<String?>
        let nextButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let validation: Observable<Bool>
        let nextButtonTapped: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let validation = input.passwordText
            .orEmpty
            .map { $0.count >= 8 }
        
        return Output(validation: validation, nextButtonTapped: input.nextButtonTap)
    }
    
}
