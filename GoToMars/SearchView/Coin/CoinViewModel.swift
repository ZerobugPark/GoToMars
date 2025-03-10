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
        
    }
    
    struct Output {
        
    }
    
    
    var query = ""
    
    
    
    init() {
        print("CoinViewModel Init")
    }
    
    
    
    
    func transform(input: Input) -> Output {
        
        return Output()
    }
    
    deinit {
        print("CoinViewModel DeInit")
    }
    
}
