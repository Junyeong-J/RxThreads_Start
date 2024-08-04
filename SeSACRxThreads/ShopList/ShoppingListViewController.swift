//
//  ShoppingListViewController.swift
//  SeSACRxThreads
//
//  Created by 전준영 on 8/4/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

struct ShoppingItem {
    var isCheckList: Bool
    let listTitle: String
    var saveList: Bool
}

final class ShoppingListViewController: UIViewController {
    
    var shoppingListItems = [
        ShoppingItem(isCheckList: true, listTitle: "그립톡 구매하기", saveList: true),
        ShoppingItem(isCheckList: false, listTitle: "사이다 구매", saveList: false),
        ShoppingItem(isCheckList: false, listTitle: "아이패드 케이스 최저가 알아보기", saveList: true),
        ShoppingItem(isCheckList: false, listTitle: "양말", saveList: true)
    ]
    
    lazy var list = BehaviorSubject(value: shoppingListItems)
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(ShoppingTableViewCell.self, forCellReuseIdentifier: ShoppingTableViewCell.identifier)
        view.backgroundColor = .white
        view.rowHeight = 44
        view.separatorStyle = .none
        return view
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("추가", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var textField: UITextField = {
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
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
        bind()
    }
    
    private func configure() {
        view.addSubview(textField)
        view.addSubview(tableView)
        
        textField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(60)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(10)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
    }
    
    private func bind() {
        list
            .bind(to: tableView.rx.items(cellIdentifier: ShoppingTableViewCell.identifier, cellType: ShoppingTableViewCell.self)) { row, item, cell in
                cell.configureData(data: item)
                
                cell.checkListButton.rx.tap
                    .bind(with: self) { owner, _ in
                        var currentList = try! owner.list.value()
                        currentList[row].isCheckList.toggle()
                        owner.list.onNext(currentList)
                    }
                    .disposed(by: cell.disposeBag)
                
                cell.saveButton.rx.tap
                    .bind(with: self) { owner, _ in
                        var currentList = try! owner.list.value()
                        currentList[row].saveList.toggle()
                        owner.list.onNext(currentList)
                    }
                    .disposed(by: cell.disposeBag)
                
            }
            .disposed(by: disposeBag)
        
        addButton.rx.tap
            .withLatestFrom(textField.rx.text.orEmpty) { void, text in
                return text
            }
            .filter { !$0.isEmpty } // 빈값은 추가 못하게 하기
            .bind(with: self) { owner, value in
                var currentList = try! owner.list.value() // 추가버튼 눌러도 계속 유지하기 위해
                currentList.insert((ShoppingItem(isCheckList: false, listTitle: value, saveList: false)), at: 0)
                owner.list.onNext(currentList)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemDeleted
            .observe(on: MainScheduler.asyncInstance)
            .withUnretained(self)
            .bind { owner, indexPath in
                var currentList = try! owner.list.value()
                currentList.remove(at: indexPath.row)
                owner.list.onNext(currentList)
            }
            .disposed(by: disposeBag)
        
    }
    
}
