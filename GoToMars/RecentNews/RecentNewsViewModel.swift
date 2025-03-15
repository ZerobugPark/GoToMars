//
//  RecentNewsViewModel.swift
//  GoToMars
//
//  Created by youngkyun park on 3/13/25.
//

import Foundation

import RxSwift
import RxCocoa
import RxDataSources

struct News {
    let title: String
    var items: [Items]
}




extension News: SectionModelType {
    
    typealias Item = Items
    
    init(original: News, items: [Items]) {
        self = original
        self.items = items
    }
}




class RecentNewsViewModel: BaseViewModel {
    
    struct Input {
        let callRequest: Observable<Int>
        
    }
    
    struct Output {
        
        
        let newsData: BehaviorRelay<[News]>
    }
    
    private let disposeBag = DisposeBag()
    
    private var data = [News]()
    
    init() {
        print("RecentNewsViewModel Init")
    }
    
    func transform(input: Input) -> Output {
        
        let newsData = BehaviorRelay(value: data)
        
        input.callRequest.flatMap { _ in
            
            if NetworkMonitor.shared.isConnected {
                return  Single.zip(NetworkManager.shared.callRequest(api: .naverSearch(query: "경제"), type: NaverNewsAPI.self), NetworkManager.shared.callRequest(api: .naverSearch(query: "주식"), type: NaverNewsAPI.self), NetworkManager.shared.callRequest(api: .naverSearch(query: "코인"), type: NaverNewsAPI.self))
                
            } else {
                return Single.zip(Single.just(.failure(APIError.noconnection)), Single.just(.failure(APIError.noconnection)), Single.just(.failure(APIError.noconnection)))
            }
            
        }.bind(with: self) { owner, value in
            
            let (economyResult, stockResult, coinResult) = value
            
            switch economyResult {
            case .success(let data):
                
                let economyNews = News(title: "경제", items: data.items)
                
                owner.data.append(economyNews)
                
            case .failure(let error):
           
                print("Error in economy search: \(error)")
            }
            
            switch stockResult {
            case .success(let data):
                let stockNews = News(title: "주식", items: data.items)
                owner.data.append(stockNews)
            case .failure(let error):
       
                print("Error in stock search: \(error)")
            }
            
            switch coinResult {
            case .success(let data):
                let coinNews = News(title: "코인", items: data.items)
                owner.data.append(coinNews)
            case .failure(let error):
                print("Error in coin search: \(error)")
            }
            
            newsData.accept(owner.data)
                        
        }.disposed(by: disposeBag)
        
        
        return Output(newsData: newsData)
    }
    
    
    
    deinit {
        print("RecentNewsViewModel DeInit")
    }
    
    
}
