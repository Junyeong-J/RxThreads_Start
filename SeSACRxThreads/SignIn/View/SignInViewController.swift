//
//  SignInViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import RxSwift
import RxCocoa

final class SignInViewController: BaseViewController<SignInView> {
    
    private let viewModel = SignInViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureView() {
        super.configureView()
    }
    
    override func bindModel() {
        let input = SignInViewModel.Input(
            signUpTap: rootView.signUpButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.signUpTapped
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(SignUpViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}
