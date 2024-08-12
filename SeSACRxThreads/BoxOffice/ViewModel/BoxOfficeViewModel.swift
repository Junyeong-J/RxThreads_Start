//
//  BoxOfficeViewModel.swift
//  SeSACRxThreads
//
//  Created by 전준영 on 8/8/24.
//

import Foundation
import RxSwift
import RxCocoa

final class BoxOfficeViewModel: BaseViewModel {
    
    let disposeBag = DisposeBag()
    
    private var recentList = ["20240801", "20240802"]
    
    struct Input {
        let searchButtonTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
        let recentText: PublishSubject<String>
        let recentDate: PublishSubject<String>
    }
    
    struct Output {
        let movieList: Observable<[DailyBoxOfficeList]>
        let recentList: BehaviorSubject<[String]>
    }
    
    func transform(input: Input) -> Output {
        let recentList = BehaviorSubject(value: recentList)
        let boxOfficeList = PublishSubject<[DailyBoxOfficeList]>()
        
        func fetchBoxOffice(date: String) {
            Observable.just(date)
                .flatMap { date in
                    BoxOfficeNetworkManager.shared.boxOfficeFetch(date: date)
                        .catch { error in
                            return Single.just(Movie(boxOfficeResult: BoxOfficeResult(dailyBoxOfficeList: [])))
                        }
                }
                .subscribe(with: self, onNext: { owner, movie in
                    dump(movie.boxOfficeResult.dailyBoxOfficeList)
                    boxOfficeList.onNext(movie.boxOfficeResult.dailyBoxOfficeList)
                }, onError: { owner, error in
                    print("error: (error)")
                }, onCompleted: { owner in
                    print("completed")
                }, onDisposed: { owner in
                    print("disposed")
                })
                .disposed(by: disposeBag)
        }
        
        
        
        input.recentDate
            .map { Int($0) ?? 20240807 }
            .map { "\($0)" }
            .filter { !$0.isEmpty }
            .subscribe(onNext: { date in
                fetchBoxOffice(date: date)
            })
            .disposed(by: disposeBag)
        
        input.searchButtonTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .map {
                guard let intText = Int($0) else {
                    return 20240807
                }
                return intText
            }
            .map { return "\($0)" }
            .filter { !$0.isEmpty }
            .subscribe(onNext: { date in
                fetchBoxOffice(date: date)
            })
            .disposed(by: disposeBag)
        
        input.searchButtonTap
            .withLatestFrom(input.searchText) { void, text in
                return text
            }
            .filter { !$0.isEmpty }
            .subscribe(with: self) { owner, value in
                owner.recentList.insert(value, at: 0)
                recentList.onNext(owner.recentList)
            }
            .disposed(by: disposeBag)
        
        input.recentText
            .subscribe(with: self) { owner, value in
                owner.recentList.append(value)
                recentList.onNext(owner.recentList)
            }
            .disposed(by: disposeBag)
        
        return Output(movieList: boxOfficeList, recentList: recentList)
    }
}
