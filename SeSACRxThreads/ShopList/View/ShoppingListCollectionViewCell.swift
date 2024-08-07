//
//  ShoppingListCollectionViewCell.swift
//  SeSACRxThreads
//
//  Created by 전준영 on 8/7/24.
//

import UIKit
import SnapKit

final class ShoppingListcollectionViewCell: BaseCollectionViewCell {
    
    let searchWordLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(searchWordLabel)
    }
    
    override func configureLayout() {
        searchWordLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    override func configureView() {
        searchWordLabel.textAlignment = .center
        searchWordLabel.font = .systemFont(ofSize: 13)
        
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
}
