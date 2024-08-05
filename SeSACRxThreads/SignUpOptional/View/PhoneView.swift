//
//  PhoneView.swift
//  SeSACRxThreads
//
//  Created by 전준영 on 8/5/24.
//

import UIKit
import SnapKit

final class PhoneView: BaseView {
    
    let phoneTextField = SignTextField(placeholderText: "연락처를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    let descriptionLabel = UILabel()
    
    override func configureHierarchy() {
        addSubview(phoneTextField)
        addSubview(descriptionLabel)
        addSubview(nextButton)
    }
    
    override func configureLayout() {
        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(phoneTextField)
            make.top.equalTo(phoneTextField.snp.bottom).offset(2)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(phoneTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
    
}
