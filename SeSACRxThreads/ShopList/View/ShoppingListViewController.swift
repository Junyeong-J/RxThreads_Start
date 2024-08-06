//
//  ShoppingListViewController.swift
//  SeSACRxThreads
//
//  Created by 전준영 on 8/4/24.
//

import UIKit
import RxSwift
import RxCocoa

final class ShoppingListViewController: BaseViewController<ShoppingListView> {
    
    let viewModel = ShoppingListViewModel()
    
    var shoppingListItems = [
        ShoppingItem(isCheckList: true, listTitle: "그립톡 구매하기", saveList: true),
        ShoppingItem(isCheckList: false, listTitle: "사이다 구매", saveList: false),
        ShoppingItem(isCheckList: false, listTitle: "아이패드 케이스 최저가 알아보기", saveList: true),
        ShoppingItem(isCheckList: false, listTitle: "양말", saveList: true)
    ]
    
    lazy var list = BehaviorSubject(value: shoppingListItems)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
    }
    
    override func bindModel() {
        
        let input = ShoppingListViewModel.Input(
            text: rootView.textField.rx.text.orEmpty,
            addTap: rootView.addButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        list
            .bind(to: rootView.tableView.rx.items(cellIdentifier: ShoppingTableViewCell.identifier, cellType: ShoppingTableViewCell.self)) { row, item, cell in
                cell.configureData(data: item)
                
                cell.checkListButton.rx.tap
                    .bind(with: self) { owner, _ in
                        var currentList = try! owner.list.value()
                        currentList[row].isCheckList.toggle()
                        owner.list.onNext(currentList)
                    }
                    .disposed(by: cell.disposeBag)
                
                cell.saveButton.rx.tap
                    .bind(with: self) { owner, _ in
                        var currentList = try! owner.list.value()
                        currentList[row].saveList.toggle()
                        owner.list.onNext(currentList)
                    }
                    .disposed(by: cell.disposeBag)
                
            }
            .disposed(by: disposeBag)
        
        output.nextTap
            .bind(with: self) { owner, value in
                var currentList = try! owner.list.value() // 추가버튼 눌러도 계속 유지하기 위해
                currentList.insert((ShoppingItem(isCheckList: false, listTitle: value, saveList: false)), at: 0)
                owner.list.onNext(currentList)
            }
            .disposed(by: disposeBag)
        
        rootView.tableView.rx.itemDeleted
            .observe(on: MainScheduler.asyncInstance)
            .withUnretained(self)
            .bind { owner, indexPath in
                var currentList = try! owner.list.value()
                currentList.remove(at: indexPath.row)
                owner.list.onNext(currentList)
            }
            .disposed(by: disposeBag)
        
        rootView.tableView.rx.itemSelected
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(DetailViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}
