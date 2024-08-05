//
//  SignUpViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import RxSwift
import RxCocoa

enum AAError: Error {
    case invalidEmail
}

final class SignUpViewController: BaseViewController<SignUpView> {
    
    let viewModel = SignUpViewModel()
    
    let basicColor = Observable.just(UIColor.systemGreen)
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureView() {
        super.configureView()
    }
    
    override func bindModel() {
        let input = SignUpViewModel.Input(
            emailText: rootView.emailTextField.rx.text, validationButtonTap: rootView.validationButton.rx.tap,
            nextButtonTap: rootView.nextButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        output.validation
            .bind(to:
                    rootView.nextButton.rx.isEnabled
            )
            .disposed(by: disposeBag)
        
        output.validation
            .bind(with: self) { owner, value in
                let color: UIColor = value ? .systemGreen : .systemRed
                owner.rootView.nextButton.backgroundColor = color
                owner.rootView.validationButton.isHidden = !value
            }
            .disposed(by: disposeBag)
        
        output.emailData
            .bind(to: rootView.emailTextField.rx.text)
            .disposed(by: disposeBag)
        
        basicColor
            .bind(to:
                    rootView.nextButton.rx.backgroundColor,
                  rootView.emailTextField.rx.textColor,
                  rootView.emailTextField.rx.tintColor)
            .disposed(by: disposeBag)
        
        basicColor
            .map { $0.cgColor }
            .bind(to: rootView.emailTextField.layer.rx.borderColor)
            .disposed(by: disposeBag)
        
        output.nextButtonTapped
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(PasswordViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}
