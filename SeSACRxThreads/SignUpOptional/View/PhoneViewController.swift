//
//  PhoneViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import RxSwift
import RxCocoa

final class PhoneViewController: BaseViewController<PhoneView> {
    
    let disposeBag = DisposeBag()
    let viewModel = PhoneViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
    }
    
    override func bindModel() {
        let input = PhoneViewModel.Input(
            phoneNumberText: rootView.phoneTextField.rx.text,
            nextTap: rootView.nextButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.phoneNumber
            .bind(to: rootView.phoneTextField.rx.text)
            .disposed(by: disposeBag)
        
        output.checkNum
            .bind(to: rootView.phoneTextField.rx.text)
            .disposed(by: disposeBag)
        
        output.validation
            .bind(with: self) { owner, value in
                owner.rootView.nextButton.backgroundColor = value ? UIColor.black : UIColor.gray
                owner.rootView.descriptionLabel.text = value ? "" : "10자 이상 입력해주세요"
                owner.rootView.nextButton.isEnabled = value
            }
            .disposed(by: disposeBag)
        
        output.nextTapped
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(NicknameViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}
