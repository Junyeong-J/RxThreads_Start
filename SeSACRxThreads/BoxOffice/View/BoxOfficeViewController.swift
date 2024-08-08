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
        
        let input = BoxOfficeViewModel.Input(
            searchButtonTap: rootView.searchBar.rx.searchButtonClicked,
            searchText: rootView.searchBar.rx.text.orEmpty)
        
        let output = viewModel.transform(input: input)
        
        output.movieList
            .bind(to: rootView.tableView.rx.items(
                cellIdentifier: BoxOfficeTableViewCell.identifier,
                cellType: BoxOfficeTableViewCell.self)) { (row, element, cell) in
                    cell.configureData(data: element, index: row + 1)
                }
                .disposed(by: disposeBag)
    }
    
}
