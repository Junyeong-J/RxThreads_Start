//
//  NicknameViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import RxSwift
import RxCocoa

final class NicknameViewController: BaseViewController<NicknameView> {
    
    private let viewModel = NicknameViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
    }
    
    override func bindModel() {
        let input = NicknameViewModel.Input(
            nextButtonTap: rootView.nextButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.nextButtonTapped
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(BirthdayViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}
