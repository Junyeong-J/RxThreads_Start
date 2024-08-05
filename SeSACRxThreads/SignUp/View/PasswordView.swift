//
//  PasswordView.swift
//  SeSACRxThreads
//
//  Created by 전준영 on 8/5/24.
//

import UIKit
import SnapKit

final class PasswordView: BaseView {
    
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    let descriptionLabel = UILabel()
    
    override func configureHierarchy() {
        addSubview(passwordTextField)
        addSubview(nextButton)
        addSubview(descriptionLabel)
    }
    
    override func configureLayout() {
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(passwordTextField).inset(3)
            make.top.equalTo(passwordTextField.snp.bottom).offset(3)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
    
    override func configureView() {
        descriptionLabel.text = "8자 이상 입력해주세요"
    }
    
    
}
