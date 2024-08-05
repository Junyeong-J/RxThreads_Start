//
//  NicknameViewModel.swift
//  SeSACRxThreads
//
//  Created by 전준영 on 8/5/24.
//

import Foundation
import RxSwift
import RxCocoa

final class NicknameViewModel {
    
    struct Input {
        let nextButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let nextButtonTapped: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        return Output(nextButtonTapped: input.nextButtonTap)
    }
    
}
