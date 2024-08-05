//
//  SignUpView.swift
//  SeSACRxThreads
//
//  Created by 전준영 on 8/5/24.
//

import UIKit
import SnapKit

final class SignUpView: BaseView {
    
    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let validationButton = UIButton()
    let nextButton = PointButton(title: "다음")
    
    override func configureHierarchy() {
        addSubview(emailTextField)
        addSubview(validationButton)
        addSubview(nextButton)
    }
    
    override func configureLayout() {
        validationButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(safeAreaLayoutGuide).offset(200)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            make.width.equalTo(100)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(safeAreaLayoutGuide).offset(200)
            make.leading.equalTo(safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(validationButton.snp.leading).offset(-8)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
    
    override func configureView() {
        validationButton.setTitle("중복확인", for: .normal)
        validationButton.setTitleColor(Color.black, for: .normal)
        validationButton.layer.borderWidth = 1
        validationButton.layer.borderColor = Color.black.cgColor
        validationButton.layer.cornerRadius = 10
    }
    
}
