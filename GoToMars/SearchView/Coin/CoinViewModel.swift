//
//  CoinViewModel.swift
//  GoToMars
//
//  Created by youngkyun park on 3/10/25.
//

import Foundation

import RxCocoa
import RxSwift


final class CoinViewModel: BaseViewModel {
    
    struct Input {
        let viewDidLoad: Observable<String>
        let startButtonTapped: PublishRelay<Int>
        
    }
    
    struct Output {
        let isFinished: PublishRelay<Void>
        let searchData: BehaviorRelay<[SearchCoin]>
        let isEmpty: PublishRelay<Bool>
        let errorStatus: PublishRelay<APIError>
        
    }
    
    private let disposeBag = DisposeBag()
    
    var coinData: [SearchCoin] = []
    
    private let queryObesrvable = PublishSubject<String>()
    
    var query = "" {
        didSet {
            queryObesrvable.onNext(query)
        }
    }
    
    
    
    init() {
        print("CoinViewModel Init")
    }

    func transform(input: Input) -> Output {
        
        let searchData = BehaviorRelay(value: coinData)
        let isEmpty = PublishRelay<Bool>()
        let isFinished = PublishRelay<Void>()
        let errorStatus = PublishRelay<APIError>()
        
        input.viewDidLoad.flatMap {
        
            if NetworkMonitor.shared.isConnected {
                return NetworkManager.shared.callRequest(api: .coingeckoSearch(query: $0), type: CoinGeckoSearchAPI.self)
            } else {
                return Single.just(.failure(APIError.noconnection))
            }
            
            
        }.bind(with: self) { owner, response in
            switch response {
            case .success(let data):
                owner.coinData = data.coins
                
                if owner.coinData.isEmpty {
                    isEmpty.accept(true)
                } else {
                    searchData.accept(owner.coinData)
                    isEmpty.accept(false)
                }
                
                isFinished.accept(())
                
            case .failure(let error):
                errorStatus.accept(error)
            }
        }.disposed(by: disposeBag)
        
        
        queryObesrvable.flatMap {
            
            if NetworkMonitor.shared.isConnected {
                return NetworkManager.shared.callRequest(api: .coingeckoSearch(query: $0), type: CoinGeckoSearchAPI.self)
            } else {
                return Single.just(.failure(APIError.noconnection))
            }
            
        }.bind(with: self) { owner, response in
            
            switch response {
            case .success(let data):
                owner.coinData = data.coins
                
                if owner.coinData.isEmpty {
                    isEmpty.accept(true)
                } else {
                    searchData.accept(owner.coinData)
                    isEmpty.accept(false)
                }
         
            case .failure(let error):
                errorStatus.accept(error)
            }
            
        }.disposed(by: disposeBag)
        
        
        input.startButtonTapped.asDriver(onErrorJustReturn: 0).drive(with: self) { owner, index in
            
            owner.coinData[index].isLiked.toggle()
            searchData.accept(owner.coinData)
        }.disposed(by: disposeBag)
        
        

        
        
        return Output(isFinished: isFinished, searchData: searchData, isEmpty: isEmpty, errorStatus: errorStatus)
    }
    
    deinit {
        print("CoinViewModel DeInit")
    }
    
}
