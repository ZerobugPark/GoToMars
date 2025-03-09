//
//  CoinDetailViewModel.swift
//  GoToMars
//
//  Created by youngkyun park on 3/9/25.
//

import Foundation

import RxCocoa
import RxSwift


final class CoinDetailViewModel: BaseViewModel {
    
    
    struct Input {
        let viewDidLoad: Observable<Void>
    }
    
    struct Output {
        let marketData: PublishRelay<[CoinGeckoMarketAPI]>
    }
    
    
    private let disposeBag = DisposeBag()
    
    var id = ""
    var marketData: [CoinGeckoMarketAPI] = []
    
    init() {
        print("CoinDetailViewModel Init")
    }
    
    
    func transform(input: Input) -> Output {
        
        let data = PublishRelay<[CoinGeckoMarketAPI]>()
        
        input.viewDidLoad.flatMap {
            NetworkManager.shared.callRequest(api: .coingeckoMarket(id: self.id), type: [CoinGeckoMarketAPI].self)
        }.bind(with: self) { owner, response in
            
            switch response {
            case .success(let value):
                    
                owner.marketData = value
                data.accept(owner.marketData)
                    
            case .failure(let error):
                print(error)
            }
            
        }.disposed(by: disposeBag)
        
        
        return Output(marketData: data)
    }
    
    deinit {
        print("CoinDetailViewModel DeInit")
    }
    
}


