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
        let myListText = PublishSubject<String>()
        
        let input = ShoppingListViewModel.Input(
            addTap: rootView.addButton.rx.tap,
            addText: rootView.textField.rx.text.orEmpty,
            recentText: recentText,
            myListText: myListText)
        
        let output = viewModel.transform(input: input)
        
        output.recentList
            .bind(to: rootView.collectionView.rx.items(
                cellIdentifier: ShoppingCollectionViewCell.identifier,
                cellType: ShoppingCollectionViewCell.self)) { (row, element, cell) in
                    cell.configureData(text: element)
                }
                .disposed(by: disposeBag)
        
        output.shopList
            .bind(to: rootView.tableView.rx.items(
                cellIdentifier: ShoppingTableViewCell.identifier,
                cellType: ShoppingTableViewCell.self)) { (row, element, cell) in
                    cell.configureData(data: element)
                }
                .disposed(by: disposeBag)
        
        Observable.zip(
            rootView.tableView.rx.modelSelected(ShoppingItem.self),
            rootView.tableView.rx.itemSelected
        )
        .map { $0.0.listTitle }
        .subscribe(with: self) { owner, value in
            recentText.onNext(value)
        }
        .disposed(by: disposeBag)
        
        Observable.zip(
            rootView.collectionView.rx.modelSelected(String.self),
            rootView.collectionView.rx.itemSelected
        )
        .map { $0.0 }
        .subscribe(with: self) { owner, value in
            myListText.onNext(value)
        }
        .disposed(by: disposeBag)
        
    }
    
}
//        rootView.tableView.rx.itemDeleted
//            .observe(on: MainScheduler.asyncInstance)
//            .withUnretained(self)
//            .bind { owner, indexPath in
//                var currentList = try! owner.list.value()
//                currentList.remove(at: indexPath.row)
//                owner.list.onNext(currentList)
//            }
//            .disposed(by: disposeBag)
