//
//  BirthdayViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import RxSwift
import RxCocoa

final class BirthdayViewController: BaseViewController<BirthdayView> {
    
    let disposeBag = DisposeBag()
    let viewModel = BirthdayViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
    }
    
    override func bindModel() {
        let input = BirthdayViewModel.Input(
            birthday: rootView.birthDayPicker.rx.date,
            nextTap: rootView.nextButton.rx.tap,
            date: rootView.birthDayPicker.rx.date)
        
        let output = viewModel.transform(input: input)
        
        output.validation
            .bind(with: self) { owner, value in
                owner.rootView.infoLabel.textColor = value ? UIColor.blue : UIColor.red
                owner.rootView.infoLabel.text = value ? "가입 가능한 나이입니다." : "만 17세 이상만 가입 가능합니다."
                owner.rootView.nextButton.backgroundColor = value ? UIColor.blue : UIColor.lightGray
                owner.rootView.nextButton.isEnabled = value
            }
            .disposed(by: disposeBag)
        
        output.year
            .map { "\($0)년" }
            .bind(to: rootView.yearLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.month
            .bind(with: self, onNext: { owner, value in
                owner.rootView.monthLabel.text = "\(value)월"
            })
            .disposed(by: disposeBag)
        
        output.day
            .observe(on: MainScheduler.instance)
            .subscribe(with: self, onNext: { owner, value in
                owner.rootView.dayLabel.text = "\(value)일"
            })
            .disposed(by: disposeBag)
        
        
        output.nextTapped
            .bind(with: self) { owner, _ in
                owner.showAlert()
            }
            .disposed(by: disposeBag)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "가입 완료", message: "가입이 완료되었습니다.", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            self.navigationController?.pushViewController(ShoppingListViewController(), animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
