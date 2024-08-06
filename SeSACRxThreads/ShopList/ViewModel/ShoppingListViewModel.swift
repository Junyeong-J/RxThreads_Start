//
//  ShoppingListViewModel.swift
//  SeSACRxThreads
//
//  Created by 전준영 on 8/5/24.
//

import Foundation
import RxSwift
import RxCocoa

final class ShoppingListViewModel {
    
    let disposeBag = DisposeBag()
    
    var shoppingListItems = [
        ShoppingItem(isCheckList: true, listTitle: "그립톡 구매하기", saveList: true),
        ShoppingItem(isCheckList: false, listTitle: "사이다 구매", saveList: false),
        ShoppingItem(isCheckList: false, listTitle: "아이패드 케이스 최저가 알아보기", saveList: true),
        ShoppingItem(isCheckList: false, listTitle: "양말", saveList: true)
    ]
    
    lazy var list = BehaviorSubject(value: shoppingListItems)
    
    struct Input {
        let text: ControlProperty<String>
        let addTap: ControlEvent<Void>
    }
    
    struct Output {
        let nextTap: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        
        let addTap = input.addTap
            .withLatestFrom(input.text) { void, text in
                return text
            }
            .filter { !$0.isEmpty } // 빈값은 추가 못하게 하기
        
        return Output(nextTap: addTap)
    }
    
}
