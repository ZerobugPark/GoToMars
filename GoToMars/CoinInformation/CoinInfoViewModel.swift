//
//  CoinInfoViewModel.swift
//  GoToMars
//
//  Created by youngkyun park on 3/8/25.
//

import Foundation

import RxCocoa
import RxSwift
import RxDataSources

enum SectionItem { //셀의 종류
    case firstSection(TrendingCoinItem)
    case secondSection(Nfts)
}

enum CollectionViewSectionModel { //섹션 정의
    case coin([SectionItem])
    case ntf([SectionItem])
}

extension CollectionViewSectionModel: SectionModelType {
    
    typealias Item = SectionItem
    
    var items: [SectionItem] {
        switch self {
        case .coin(let items):
            return items
        case .ntf(let items):
            return items
        }
    }
    
    
    init(original: CollectionViewSectionModel, items: [Self.Item]) {
        self = original
        
    }
}


final class CoinInfoViewModel: BaseViewModel {
    
    struct Input {
        let viewdidLoad: Observable<Int>
        let searchButtonTapped: Observable<ControlProperty<String>.Element>
    }
    
    struct Output {
        let trending: BehaviorRelay<[CollectionViewSectionModel]>
        let blankResult: PublishRelay<Void>
        let searchText: PublishRelay<String>
    }
    
    
    private var coinTrend: [SectionItem] = []
    private var ntfTrend: [SectionItem] = []
    private let disposeBag = DisposeBag()
      
    
    init() {
        print("CoinInfoViewModel Init")
    }
    
    func transform(input: Input) -> Output {
        
        let trending = BehaviorRelay<[CollectionViewSectionModel]>(value: [.coin(coinTrend),
                                                                           .ntf(ntfTrend)])
        
        let blank = PublishRelay<Void>()
        let search = PublishRelay<String>()
        
        input.viewdidLoad.flatMap { _ in
            NetworkManager.shared.callRequest(api: .coingeckoTrending, type: CoinGeckoTrendingAPI.self)
        }.bind(with: self) { owner, response in
            switch response {
            case .success(let value):
                owner.coinTrend = []
                owner.getInfo(data: value.coins)
                owner.getInfo(data: value.nfts)
                trending.accept([.coin(owner.coinTrend),.ntf(owner.ntfTrend)])
            case .failure(let error):
                print(error)
            }
        }.disposed(by: disposeBag)
        
        input.searchButtonTapped.distinctUntilChanged().subscribe(with: self) { owner, text in
            
            let result = text.replacingOccurrences(of: " ", with: "")
            if result.isEmpty {
                blank.accept(())
            } else {
                search.accept(result)
            }
    
            
        }.disposed(by: disposeBag)
        

        return Output(trending: trending, blankResult: blank, searchText: search)
    }
    
    
    
    deinit {
        print("CoinInfoViewModel DeInit")
    }
    
}

// MARK: - Section 타입으로 변환
extension CoinInfoViewModel {
    
    private func getInfo(data: [TrendingCoinItem]) {
        
        for item in data {
            coinTrend += [.firstSection(item)]
        }
        coinTrend.removeLast() // Input 데이터는 15개, 실제 보여주는 데이터는 14개
        
    }
    
    private func getInfo(data: [Nfts]) {
        
        for item in data {
            ntfTrend += [.secondSection(item)]
        }
        
    }
}
