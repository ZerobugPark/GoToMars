//
//  ExchangeViewModel.swift
//  GoToMars
//
//  Created by youngkyun park on 3/6/25.
//

import Foundation

import RxSwift
import RxCocoa
import RxGesture



final class ExchangeViewModel: BaseViewModel {
    
    
    struct Input {
        let viewDidLoad: Observable<Int>
        
        let test: Observable<Int>
    }
    
    struct Output {
        
        let coinList: BehaviorRelay<[UpBitAPI]>
    }
    
    private let disposeBag = DisposeBag()
    
    var coinList: [UpBitAPI] = []
    
    init() {
        print("ExchangeViewModel Init")
    }
    
    
    
    
    
    
    func transform(input: Input) -> Output {
        
        let outputConinList = BehaviorRelay(value: coinList)
        
        
        input.viewDidLoad.flatMapLatest { _ in NetworkManager.shared.callRequest(api: .upbit, type: [UpBitAPI].self) }
            .bind(with: self) { owner, response in
                
                switch response {
                case .success(let value):
                    owner.coinList = value
                    owner.changeTitle(data: owner.coinList)
                    
                    outputConinList.accept(owner.coinList)

                case .failure(let error):
                    print(error)
                }
                
                
            }.disposed(by: disposeBag)
        
        
        input.test.bind(with: self) { owner, value in
            
            print(value)
            
        }.disposed(by: disposeBag)
        
        return Output(coinList: outputConinList)
        
        
        
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
    
}

