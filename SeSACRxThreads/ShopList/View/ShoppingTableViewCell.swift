//
//  ShoppingTableViewCell.swift
//  SeSACRxThreads
//
//  Created by 전준영 on 8/4/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ShoppingTableViewCell: BaseTableViewCell {
    
    var disposeBag = DisposeBag()
    
    let toDoListLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    let checkListButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        button.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        button.tintColor = .black
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star.fill"), for: .selected)
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .black
        button.isUserInteractionEnabled = true
        return button
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func configureHierarchy() {
        contentView.addSubview(checkListButton)
        contentView.addSubview(toDoListLabel)
        contentView.addSubview(saveButton)
    }
    
    override func configureLayout() {
        checkListButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.size.equalTo(32)
        }
        
        
        toDoListLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(checkListButton.snp.trailing).offset(20)
        }
        
        saveButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(32)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = #colorLiteral(red: 0.9039029791, green: 0.9039029791, blue: 0.9039029791, alpha: 1)
        self.selectionStyle = .none
    }
    
    func configureData(data: ShoppingItem) {
        toDoListLabel.text = data.listTitle
        checkListButton.isSelected = data.isCheckList
        saveButton.isSelected = data.saveList
    }
}

