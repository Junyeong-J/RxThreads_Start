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
        
    }
    
}
