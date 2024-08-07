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
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
    }
    
    override func bindModel() {
        let recentText = PublishSubject<String>()
        
        let input = ShoppingListViewModel.Input(
            addTap: rootView.addButton.rx.tap,
            text: rootView.textField.rx.text.orEmpty,
            recentText: recentText)
        
        let output = viewModel.transform(input: input)
        
        output.recentList
            .bind(to: rootView.collectionView.rx.items(cellIdentifier: ShoppingListcollectionViewCell.identifier, cellType: ShoppingListcollectionViewCell.self)) { (row, element, cell) in
                cell.searchWordLabel.text = element
                
            }
            .disposed(by: disposeBag)
        
        output.shopList
            .bind(to: rootView.tableView.rx.items(cellIdentifier: ShoppingTableViewCell.identifier, cellType: ShoppingTableViewCell.self)) { (row, element, cell) in
//                cell.configureData(data: element)
//                cell.checkListButton.rx.tap
//                    .bind(with: self) { owner, _ in
//                        var currentList = try! owner.list.value()
//                        currentList[row].isCheckList.toggle()
//                        owner.list.onNext(currentList)
//                    }
//                    .disposed(by: cell.disposeBag)
//                
//                cell.saveButton.rx.tap
//                    .bind(with: self) { owner, _ in
//                        var currentList = try! owner.list.value()
//                        currentList[row].saveList.toggle()
//                        owner.list.onNext(currentList)
//                    }
//                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        

        
        rootView.tableView.rx.itemSelected
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(DetailViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}


//        output.nextTap
//            .bind(with: self) { owner, value in
//                var currentList = try! owner.list.value() // 추가버튼 눌러도 계속 유지하기 위해
//                currentList.insert((ShoppingItem(isCheckList: false, listTitle: value, saveList: false)), at: 0)
//                owner.list.onNext(currentList)
//            }
//            .disposed(by: disposeBag)
//
//        rootView.tableView.rx.itemDeleted
//            .observe(on: MainScheduler.asyncInstance)
//            .withUnretained(self)
//            .bind { owner, indexPath in
//                var currentList = try! owner.list.value()
//                currentList.remove(at: indexPath.row)
//                owner.list.onNext(currentList)
//            }
//            .disposed(by: disposeBag)
