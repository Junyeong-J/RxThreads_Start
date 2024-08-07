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
    
    private let shoppingList = Observable.just(
        [ShoppingItem(isCheckList: true, listTitle: "그립톡 구매하기", saveList: true),
         ShoppingItem(isCheckList: false, listTitle: "사이다 구매", saveList: false),
         ShoppingItem(isCheckList: false, listTitle: "아이패드 케이스 최저가 알아보기", saveList: true),
         ShoppingItem(isCheckList: false, listTitle: "양말", saveList: true)
        ])
    
    private let recentList = ["a", "b"]
    
    struct Input {
        let addTap: ControlEvent<Void>
        let text: ControlProperty<String>
        let recentText: PublishSubject<String>
    }
    
    struct Output {
        let shopList: Observable<[ShoppingItem]>
        let recentList: BehaviorSubject<[String]>
        let nextTap: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        let recentList = BehaviorSubject(value: recentList)
        
        let addTap = input.addTap
            .withLatestFrom(input.text) { void, text in
                return text
            }
            .filter { !$0.isEmpty } // 빈값은 추가 못하게 하기
        
        return Output(shopList: shoppingList, recentList: recentList, nextTap: addTap)
    }
    
}
