//
//  CoinDetailViewModel.swift
//  GoToMars
//
//  Created by youngkyun park on 3/9/25.
//

import Foundation

import RxCocoa
import RxSwift

import DGCharts
import RealmSwift

final class CoinDetailViewModel: BaseViewModel {
    
    struct Input {
        let callRequest: BehaviorRelay<Void>
        let likeButtonTapped: ControlEvent<()>
    }
    
    struct Output {
        let marketData: PublishRelay<[CoinGeckoMarketAPI]>
        let chartData: PublishRelay<[ChartDataEntry]>
        let errorStatus: BehaviorRelay<APIError>
        let likeButtonStatus: PublishRelay<Bool>
        let likeStatusMessage: PublishRelay<String>
    }
    
    
    private let disposeBag = DisposeBag()
    
    private let repository: LikeRepository = LikeTableRepository()
    
    private var isLiked = false
    
    private var marketData: [CoinGeckoMarketAPI] = []
    private var list: Results<LikeTable>!
    
    var id = ""
    
    init() {
        print("CoinDetailViewModel Init")
        repository.getFileURL()
    }
    
    
    func transform(input: Input) -> Output {
        
        let data = PublishRelay<[CoinGeckoMarketAPI]>()
        let chartData = PublishRelay<[ChartDataEntry]>()
        let errorStatus = BehaviorRelay<APIError>(value: .unknown)
        let likeButtonStatus = PublishRelay<Bool>()
        let likeStatusMessage = PublishRelay<String>()
        
        input.callRequest.flatMap {
            
            if NetworkMonitor.shared.isConnected {
                return NetworkManager.shared.callRequest(api: .coingeckoMarket(id: self.id), type: [CoinGeckoMarketAPI].self)
                
            } else {
                return Single.just(Result.failure(APIError.noconnection))
            }
            
        }.bind(with: self) { owner, response in
            
            switch response {
            case .success(let value):
                    
                owner.marketData = value
                
                let spark = owner.setChartData(data: value[0].sparklineIn7d)
                chartData.accept(spark)
                
                owner.isLiked = owner.getRealmData(id: owner.id)
                likeButtonStatus.accept(owner.isLiked)
                data.accept(owner.marketData)
                
                //dump(value)
            case .failure(let error):
                errorStatus.accept(error)
            }
            
        }.disposed(by: disposeBag)
          
        input.likeButtonTapped.bind(with: self) { owner, _ in

            owner.isLiked.toggle()
            
            if owner.isLiked {
                owner.repository.createItem(id: owner.id, status: owner.isLiked)
                let msg = "\(owner.id)이(가) 즐겨찾기에 추가되었습니다."
                likeStatusMessage.accept(msg)
            } else {
                let msg = "\(owner.id)이(가) 즐겨찾기에서 삭제되었습니다."
                likeStatusMessage.accept(msg)
                owner.repository.deleteItem(data: owner.list[0])
            }
            
            NotificationCenter.default.post(name: .isLiked, object: nil, userInfo: ["id": owner.id , "isLiked" : owner.isLiked])

            likeButtonStatus.accept(owner.isLiked)

        }.disposed(by: disposeBag)
    
        
        return Output(marketData: data, chartData: chartData, errorStatus: errorStatus, likeButtonStatus: likeButtonStatus, likeStatusMessage: likeStatusMessage)
    }
    
    deinit {
        print("CoinDetailViewModel DeInit")
    }
    
}

// MARK: - Get Chart Data
extension CoinDetailViewModel {
    
    private func setChartData(data:[String : [Double]]) -> [ChartDataEntry] {

        var entries: [ChartDataEntry] = Array()
        
        for (i, data) in data["price"]!.enumerated()  {
            entries.append(ChartDataEntry(x: Double(i), y:  data))
        }

        return entries
    }

}


// MARK: - Load Realm
extension CoinDetailViewModel {
    
    private func getRealmData(id: String) -> Bool {
        
        list = repository.fetchAll().where{ $0.coinID == id }
        
        if list.isEmpty {
            return false
        }
        
        return list[0].isLiked ? true : false
        
    }
    
}
