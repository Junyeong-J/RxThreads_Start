//
//  SignUpViewModel.swift
//  SeSACRxThreads
//
//  Created by 전준영 on 8/5/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SignUpViewModel {
    let disposeBag = DisposeBag()
    struct Input {
        let emailText: ControlProperty<String?>
        let validationButtonTap: ControlEvent<Void>
        let nextButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let validation: Observable<Bool>
        let nextButtonTapped: ControlEvent<Void>
        let emailData: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        
        let validation = input.emailText
            .orEmpty
            .map { $0.count >= 4 }
        
        let emailData = PublishSubject<String>()
        
        input.validationButtonTap
            .bind(onNext: { _ in
                emailData.onNext("b@b.com")
            })
            .disposed(by: disposeBag)
        
        return Output(validation: validation, nextButtonTapped: input.nextButtonTap, emailData: emailData.asObserver())
    }
    
}
