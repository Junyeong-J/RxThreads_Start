//
//  BoxOfficeViewModel.swift
//  SeSACRxThreads
//
//  Created by 전준영 on 8/8/24.
//

import Foundation
import RxSwift
import RxCocoa

final class BoxOfficeViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let searchButtonTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }
    
    struct Output {
        let movieList: Observable<[DailyBoxOfficeList]>
    }
    
    func transform(input: Input) -> Output {
        let boxOfficeList = PublishSubject<[DailyBoxOfficeList]>()
        
        input.searchButtonTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .map {
                guard let intText = Int($0) else {
                    return 20240701
                }
                return intText
            }
            .map { return "\($0)" }
            .flatMap { value in
                BoxOfficeNetworkManager.shared.boxOfficeFetch(date: value)
            }
            .subscribe(with: self, onNext: { owner, movie in
                dump(movie.boxOfficeResult.dailyBoxOfficeList)
                boxOfficeList.onNext(movie.boxOfficeResult.dailyBoxOfficeList)
            }, onError: { owner, error in
                print("error: \(error)")
            }, onCompleted: { owner in
                print("completed")
            }, onDisposed: { owner in
                print("disposed")
            })
            .disposed(by: disposeBag)
        
        return Output(movieList: boxOfficeList)
    }
}
