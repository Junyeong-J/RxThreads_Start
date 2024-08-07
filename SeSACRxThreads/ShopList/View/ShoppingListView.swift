//
//  ShoppingListView.swift
//  SeSACRxThreads
//
//  Created by 전준영 on 8/5/24.
//

import UIKit
import SnapKit

final class ShoppingListView: BaseView {
    
    let tableView: UITableView = {
        let view = UITableView()
        view.register(ShoppingTableViewCell.self, forCellReuseIdentifier: ShoppingTableViewCell.identifier)
        view.backgroundColor = .white
        view.rowHeight = 44
        view.separatorStyle = .none
        return view
    }()
    
    let collectionView: UICollectionView = { 
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
        collectionView.register(ShoppingCollectionViewCell.self, forCellWithReuseIdentifier: ShoppingCollectionViewCell.identifier)
        return collectionView
    }()
    
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("추가", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "무엇을 구매하실 건가요?"
        textField.backgroundColor = #colorLiteral(red: 0.9039029791, green: 0.9039029791, blue: 0.9039029791, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.tintColor = .black
        textField.textColor = .black
        
        textField.rightViewMode = .always
        textField.rightView = addButton
        return textField
    }()
    
    override func configureHierarchy() {
        addSubview(textField)
        addSubview(collectionView)
        addSubview(tableView)
    }
    
    override func configureLayout() {
        textField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(60)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(10)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
}
