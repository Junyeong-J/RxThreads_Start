//
//  SearchViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 8/1/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController<SearchView> {
    
    let disposeBag = DisposeBag()
    let viewModel = SearchViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchController()
    }
    
    override func configureView() {
        super.configureView()
    }
    
    override func bindModel() {
        let input = SearchViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.list
            .bind(to: rootView.tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                 
                cell.appNameLabel.text = element
                cell.appIconImageView.backgroundColor = .systemBlue

            }
            .disposed(by: disposeBag)
    }
     
    private func setSearchController() {
        navigationItem.titleView = rootView.searchBar
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(plusButtonClicked))
    }
    
    @objc func plusButtonClicked() {
        print("추가 버튼 클릭")
    }
    
}
