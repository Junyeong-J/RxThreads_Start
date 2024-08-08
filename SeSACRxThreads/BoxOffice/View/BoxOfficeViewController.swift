//
//  BoxOfficeViewController.swift
//  SeSACRxThreads
//
//  Created by 전준영 on 8/8/24.
//

import UIKit
import RxSwift
import RxCocoa

final class BoxOfficeViewController: BaseViewController<BoxOfficeView> {
    
    private let viewModel = BoxOfficeViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        navigationItem.titleView = rootView.searchBar
    }
    
    override func bindModel() {
        let recentText = PublishSubject<String>()
        let recentDate = PublishSubject<String>()
        
        let input = BoxOfficeViewModel.Input(
            searchButtonTap: rootView.searchBar.rx.searchButtonClicked,
            searchText: rootView.searchBar.rx.text.orEmpty,
            recentText: recentText,
            recentDate: recentDate)
        
        let output = viewModel.transform(input: input)
        
        output.recentList
            .bind(to: rootView.collectionView.rx.items(
                cellIdentifier: BoxOfficeCollectionViewCell.identifier,
                cellType: BoxOfficeCollectionViewCell.self)) { (row, element, cell) in
                    cell.configureData(text: element)
                }
                .disposed(by: disposeBag)
        
        output.movieList
            .bind(to: rootView.tableView.rx.items(
                cellIdentifier: BoxOfficeTableViewCell.identifier,
                cellType: BoxOfficeTableViewCell.self)) { (row, element, cell) in
                    cell.configureData(data: element, index: row + 1)
                }
                .disposed(by: disposeBag)
        
        Observable.zip(
            rootView.collectionView.rx.modelSelected(String.self),
            rootView.collectionView.rx.itemSelected
        )
        .map { $0.0 }
        .subscribe(with: self) { owner, value in
            recentDate.onNext(value)
        }
        .disposed(by: disposeBag)
        
    }
    
}
