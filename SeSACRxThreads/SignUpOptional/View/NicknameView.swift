//
//  NicknameView.swift
//  SeSACRxThreads
//
//  Created by 전준영 on 8/5/24.
//

import UIKit
import SnapKit

final class NicknameView: BaseView {
    
    let nicknameTextField = SignTextField(placeholderText: "닉네임을 입력해주세요")
    let nextButton = PointButton(title: "다음")
    
    override func configureHierarchy() {
        addSubview(nicknameTextField)
        addSubview(nextButton)
    }
    
    override func configureLayout() {
        nicknameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
}
