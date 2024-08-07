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
    
    private var shoppingList =
        [ShoppingItem(isCheckList: true, listTitle: "그립톡 구매하기", saveList: true),
         ShoppingItem(isCheckList: false, listTitle: "사이다 구매", saveList: false),
         ShoppingItem(isCheckList: false, listTitle: "아이패드 케이스 최저가 알아보기", saveList: true),
         ShoppingItem(isCheckList: false, listTitle: "양말", saveList: true)
        ]
    
    private var recentList = ["키보드", "손풍기", "컵", "마우스패드", "샌들"]
    
    struct Input {
        let addTap: ControlEvent<Void>
        let addText: ControlProperty<String>
        let recentText: PublishSubject<String>
        let myListText: PublishSubject<String>
    }
    
    struct Output {
        let shopList: Observable<[ShoppingItem]>
        let recentList: BehaviorSubject<[String]>
    }
    
    func transform(input: Input) -> Output {
        let recentList = BehaviorSubject(value: recentList)
        let shoppingList = BehaviorSubject(value: shoppingList)
        
        input.recentText
            .subscribe(with: self) { owner, value in
                owner.recentList.insert(value, at: 0)
                recentList.onNext(owner.recentList)
            }
            .disposed(by: disposeBag)
        
        input.myListText
            .subscribe(with: self) { owner, value in
                owner.shoppingList.insert(ShoppingItem(isCheckList: false, listTitle: value, saveList: false), at: 0)
                shoppingList.onNext(owner.shoppingList)
            }
            .disposed(by: disposeBag)
        
        input.addTap
            .withLatestFrom(input.addText) { void, text in
                return text
            }
            .filter { !$0.isEmpty } // 빈값은 추가 못하게 하기
            .subscribe(with: self) { owner, value in
                owner.recentList.insert(value, at: 0)
                recentList.onNext(owner.recentList)
                owner.shoppingList.insert(ShoppingItem(isCheckList: false, listTitle: value, saveList: false), at: 0)
                shoppingList.onNext(owner.shoppingList)
            }
            .disposed(by: disposeBag)
        
        return Output(shopList: shoppingList, recentList: recentList)
    }
    
}
