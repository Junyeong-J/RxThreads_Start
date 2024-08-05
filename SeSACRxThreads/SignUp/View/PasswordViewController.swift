//
//  PasswordViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PasswordViewController: BaseViewController<PasswordView> {
    
    let viewModel = PasswordViewModel()
    let basicColor = Observable.just(UIColor.red)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
    }
    
    override func bindModel() {
        let input = PasswordViewModel.Input(
            passwordText: rootView.passwordTextField.rx.text,
            nextButtonTap: rootView.nextButton.rx.tap)
        
        let output = viewModel.transform(input: input)
        
        //조건에따라 변함
        output.validation
            .bind(with: self) { owner, value in
            owner.rootView.nextButton.backgroundColor = value ? UIColor.black : UIColor.gray
            owner.rootView.descriptionLabel.isHidden = value
            owner.rootView.nextButton.isEnabled = value
        }
        .disposed(by: disposeBag)
        
        //버튼 터치후 다음 화면 이동
        output.nextButtonTapped
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(PhoneViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        basicColor
            .bind(to: rootView.descriptionLabel.rx.textColor)
            .disposed(by: disposeBag)
    }
    
}
