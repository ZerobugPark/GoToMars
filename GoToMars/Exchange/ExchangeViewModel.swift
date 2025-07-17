//
//  ExchangeViewModel.swift
//  GoToMars
//
//  Created by youngkyun park on 3/6/25.
//

import Foundation

import RxSwift
import RxCocoa

final class ExchangeViewModel: BaseViewModel {
    
    struct Input {
        let viewDidLoad: Observable<Int>
        let filterButtonTapped: Observable<Int>
    }
    
    struct Output {
        
        let coinList: BehaviorRelay<[UpBitAPI]>
        let filterStatus: PublishRelay<Filter>
        let errorStatus: BehaviorRelay<APIError>
    }
    
    var disposeBag = DisposeBag()
    
    private var coinList: [UpBitAPI] = []
    
    private var previousFilterStatus = Filter.normalState.rawValue
    private var currentFilter: Filter = .normalState
    private var filterCount = 0
    
    
    init() {
        print("ExchangeViewModel Init")
    }
    
    
    func transform(input: Input) -> Output {
        
        let coninList = BehaviorRelay(value: coinList)
        let filterStatus = PublishRelay<Filter>()
        let errorStatus = BehaviorRelay<APIError>(value: .unknown)
        
        
        input.viewDidLoad.flatMap { _ in
            
            if NetworkMonitor.shared.isConnected {
                return NetworkManager.shared.callRequest(api: .upbit, type: [UpBitAPI].self)
            } else {
                return Single.just(Result.failure(APIError.noconnection))
            }
              
        }.bind(with: self) { owner, response in
            
                switch response {
                case .success(let value):
                    owner.coinList = value
                    owner.changeTitle(data: owner.coinList)
                    owner.applyFillter(filter: owner.currentFilter)
                    
                    coninList.accept(owner.coinList)
                case .failure(let error):
                    errorStatus.accept(error)
                }
                
                
            }.disposed(by: disposeBag)
        
        
        input.filterButtonTapped.bind(with: self) { owner, value in
            
            switch value {
            case 0:
                if owner.previousFilterStatus == value {
                    owner.currentFilter = .upCurrentPrice
                    owner.filterCount += 1
                } else {
                    owner.currentFilter = .downCurrentPrice
                    owner.filterCount = 0
                }
            case 1:
                if owner.previousFilterStatus == value {
                    owner.currentFilter = .upCompare
                    owner.filterCount += 1
                } else {
                    owner.currentFilter = .downCompare
                    owner.filterCount = 0
                }
            case 2:
                if owner.previousFilterStatus == value {
                    owner.currentFilter = .upTrade
                    owner.filterCount += 1
                } else {
                    owner.currentFilter = .downTrade
                    owner.filterCount = 0
                }
            default:
                print("오류발생")
            }
            
            
            if owner.filterCount == 2 {
                owner.currentFilter = .normalState
                owner.filterCount = 0
                owner.previousFilterStatus = Filter.normalState.rawValue
                filterStatus.accept(owner.currentFilter)
            } else {
                owner.previousFilterStatus = value
                filterStatus.accept(owner.currentFilter)
            }
            owner.applyFillter(filter: owner.currentFilter)
            coninList.accept(owner.coinList)
            
        }.disposed(by: disposeBag)
        
        return Output(coinList: coninList, filterStatus: filterStatus, errorStatus: errorStatus)
        
        
        
    }
    
    
    
    deinit {
        print("ExchangeViewModel DeInit")
    }
    
    
    
}

extension ExchangeViewModel {
    
    
    private func changeTitle(data: [UpBitAPI]) {
        
        for i in 0..<data.count {
            coinList[i].market = swapMarketTitle(str: data[i].market)
            
        }
    
    }
    
    private func swapMarketTitle(str: String) -> String {
        
        var code: String = ""
        var name: String = ""
        for i in 0..<str.count {
            
            if i < 3 {
                code += str[i] ?? "Error"
            } else if i > 3 {
                name += str[i] ?? "Error"
            } else { }
        
        }
        
        return name + "/" + code

    }
    
    private func applyFillter(filter: Filter) {
        
        var data: [UpBitAPI] = []
        switch filter {
        case .downTrade:
            data = coinList.sorted { $0.accTrade > $1.accTrade }
        case .upTrade:
            data = coinList.sorted { $0.accTrade < $1.accTrade }
        case .downCompare:
            data = coinList.sorted { $0.changeRate > $1.changeRate }
        case .upCompare:
            data = coinList.sorted { $0.changeRate < $1.changeRate }
        case .downCurrentPrice:
            data = coinList.sorted { $0.trade > $1.trade }
        case .upCurrentPrice:
            data = coinList.sorted { $0.trade < $1.trade }
        case .normalState:
            data = coinList.sorted { $0.accTrade > $1.accTrade }
        }
        coinList = data
        
    }
    
}

