//
//  BirthdayViewModel.swift
//  SeSACRxThreads
//
//  Created by 전준영 on 8/5/24.
//

import Foundation
import RxSwift
import RxCocoa

final class BirthdayViewModel {
    let disposeBag = DisposeBag()
    
    struct Input {
        let birthday: ControlProperty<Date>
        let nextTap: ControlEvent<Void>
        let date: ControlProperty<Date>
    }
    
    struct Output {
        let year: BehaviorRelay<Int>
        let month: BehaviorRelay<Int>
        let day: BehaviorRelay<Int>
        let nextTapped: ControlEvent<Void>
        let validation: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        let year = BehaviorRelay(value: 2024)
        let month = BehaviorRelay(value: 8)
        let day = BehaviorRelay(value: 5)
        
        input.birthday
            .bind(with: self) { owner, date in
                let component = Calendar.current.dateComponents([.day, .month, .year], from: date)
                
                year.accept(component.year!)
                month.accept(component.month!)
                day.accept(component.day!)
            }
            .disposed(by: disposeBag)
        
        let validation = input.date
            .map {
                let ageComponent = Calendar.current.dateComponents([.year], from: $0, to: Date())
                let age = ageComponent.year!
                return age >= 17
            }
        
        return Output(year: year, month: month, day: day, nextTapped: input.nextTap, validation: validation)
    }
}
