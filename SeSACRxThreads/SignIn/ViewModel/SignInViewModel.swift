//
//  SignInViewModel.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import Foundation
import RxSwift
import RxCocoa

final class SignInViewModel {
    
    struct Input {
        let signUpTap: ControlEvent<Void>
    }
    
    struct Output {
        let signUpTapped: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        return Output(signUpTapped: input.signUpTap)
    }
    
}
