//
//  CoinDetailViewController.swift
//  GoToMars
//
//  Created by youngkyun park on 3/8/25.
//

import UIKit
import RxSwift
import RxCocoa

final class CoinDetailViewController: UIViewController {

    var id = ""
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        
        
        Observable.just(()).flatMap { _ in
            NetworkManager.shared.callRequest(api: .coingeckoMarket(id: self.id), type: [CoinGeckoMarketAPI].self)
        }.bind(with: self) { owner, response in
            
            switch response {
            case .success(let data):
                dump(data)
            case .failure(let error):
                print(error)
            }
            
            
        }.disposed(by: disposeBag)
    }


}
