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


final class CoinDetailViewModel: BaseViewModel {
    
    
    struct Input {
        let viewDidLoad: Observable<Void>
     
    }
    
    struct Output {
        let marketData: PublishRelay<[CoinGeckoMarketAPI]>
        let chartData: PublishRelay<[ChartDataEntry]>
        let errorStatus: PublishRelay<APIError>
    }
    
    
    private let disposeBag = DisposeBag()
    
    var id = ""
    var marketData: [CoinGeckoMarketAPI] = []
    
    init() {
        print("CoinDetailViewModel Init")
    }
    
    
    func transform(input: Input) -> Output {
        
        let data = PublishRelay<[CoinGeckoMarketAPI]>()
        let chartData = PublishRelay<[ChartDataEntry]>()
        let errorStatus = PublishRelay<APIError>()
        
        input.viewDidLoad.flatMap {
            
            if NetworkMonitor.shared.isConnected {
                return NetworkManager.shared.callRequest(api: .coingeckoMarket(id: self.id), type: [CoinGeckoMarketAPI].self)
            } else {
                return Single.just(.failure(APIError.noconnection))
            }
            
        }.bind(with: self) { owner, response in
            
            switch response {
            case .success(let value):
                    
                owner.marketData = value
                
                let spark = owner.setChartData(data: value[0].sparklineIn7d)
                chartData.accept(spark)
                data.accept(owner.marketData)
                    
            case .failure(let error):
                errorStatus.accept(error)
            }
            
        }.disposed(by: disposeBag)
          
        
        return Output(marketData: data, chartData: chartData, errorStatus: errorStatus)
    }
    
    deinit {
        print("CoinDetailViewModel DeInit")
    }
    
}


extension CoinDetailViewModel {
    
    private func setChartData(data:[String : [Double]]) -> [ChartDataEntry] {

        var entries: [ChartDataEntry] = Array()
        
        for (i, data) in data["price"]!.enumerated()  {
            entries.append(ChartDataEntry(x: Double(i), y:  data))
        }

        return entries
    }
}


