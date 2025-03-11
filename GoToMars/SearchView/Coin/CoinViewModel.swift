//
//  CoinViewModel.swift
//  GoToMars
//
//  Created by youngkyun park on 3/10/25.
//

import Foundation

import RxCocoa
import RxSwift
import RealmSwift


final class CoinViewModel: BaseViewModel {
    
    struct Input {
        
        let callRequest: BehaviorRelay<String>
        let likeButtonTapped: PublishRelay<Int>
    }
    
    struct Output {
        let isFinished: PublishRelay<Void>
        let searchData: BehaviorRelay<[SearchCoin]>
        let isEmpty: PublishRelay<Bool>
        let errorStatus: BehaviorRelay<APIError>
        
    }
    
    private let disposeBag = DisposeBag()
    
    private let queryObesrvable = PublishSubject<String>()

    private let repository: LikeRepository = LikeTableRepository()
    
    var coinData: [SearchCoin] = []
    var list: Results<LikeTable>!
    

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
        let errorStatus = BehaviorRelay<APIError>(value: .unknown)
        

        input.callRequest.flatMap {
            
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
                    owner.getLikeStatus()
                    searchData.accept(owner.coinData)
                    isEmpty.accept(false)
                }
                isFinished.accept(())
            case .failure(let error):
                errorStatus.accept(error)
            }
            
        }.disposed(by: disposeBag)
        
        
        input.likeButtonTapped.asDriver(onErrorJustReturn: 0).drive(with: self) { owner, index in
            
            owner.coinData[index].isLiked.toggle()
            
            if owner.coinData[index].isLiked {
                owner.repository.createItem(id: owner.coinData[index].id, status: owner.coinData[index].isLiked)
                
            } else {
                owner.repository.deleteItem(data: owner.list[index])
            }
            
            searchData.accept(owner.coinData)
        }.disposed(by: disposeBag)
        

        NotificationCenter.default.rx.notification(.isLiked).compactMap {
            
            let id = $0.userInfo?["id"] as? String
            let likeStatus = $0.userInfo?["isLiked"] as? Bool
            
            return (id, likeStatus)
        }.bind(with: self) { owner, value in
            
            let data = owner.coinData.firstIndex{ $0.id == value.0! }
                       
            if let index = data {
                owner.coinData[index].isLiked = value.1!
            }
            searchData.accept(owner.coinData)
        }.disposed(by: disposeBag)
        
        return Output(isFinished: isFinished, searchData: searchData, isEmpty: isEmpty, errorStatus: errorStatus)
    }
    
    deinit {
        print("CoinViewModel DeInit")
    }
    
}



extension CoinViewModel {
    
    
    private func getLikeStatus() {
        
        list = repository.fetchAll()
        
        if list.isEmpty {
            return
        }
        
        for i in 0..<coinData.count {
            
            let data = list.where { $0.coinID == coinData[i].id }
            
            if !data.isEmpty {
                coinData[i].isLiked = data[0].isLiked
            }
        }
        
    }
    
}


