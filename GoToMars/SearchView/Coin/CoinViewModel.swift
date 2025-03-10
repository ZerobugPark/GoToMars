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
        
    }
    
    struct Output {
        let isFinished: PublishRelay<Void>
        let searchData: BehaviorRelay<[SearchCoin]>
        let isEmpty: PublishRelay<Bool>
        
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
        
        input.viewDidLoad.flatMap {
            NetworkManager.shared.callRequest(api: .coingeckoSearch(query: $0), type: CoinGeckoSearchAPI.self)
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
                print(error)
            }
        }.disposed(by: disposeBag)
        
        
        queryObesrvable.flatMap {
            NetworkManager.shared.callRequest(api: .coingeckoSearch(query: $0), type: CoinGeckoSearchAPI.self)
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
                print(error)
            }
            
        }.disposed(by: disposeBag)
        
        

        
        
        return Output(isFinished: isFinished, searchData: searchData, isEmpty: isEmpty)
    }
    
    deinit {
        print("CoinViewModel DeInit")
    }
    
}
