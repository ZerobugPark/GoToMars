//
//  CoinDetailViewController.swift
//  GoToMars
//
//  Created by youngkyun park on 3/8/25.
//

import UIKit

import RxCocoa
import RxSwift


import SnapKit

final class CoinDetailViewController: UIViewController {

    var id = ""
    
    private let disposeBag = DisposeBag()
    
    private let coinDetailView = DetailInfoView()
    
//    override func loadView() {
//        view = coinDetailView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(coinDetailView)
        
        coinDetailView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(300)
        }
        
//
//        Observable.just(()).flatMap { _ in
//            NetworkManager.shared.callRequest(api: .coingeckoMarket(id: self.id), type: [CoinGeckoMarketAPI].self)
//        }.bind(with: self) { owner, response in
//            
//            switch response {
//            case .success(let data):
//                dump(data)
//            case .failure(let error):
//                print(error)
//            }
//            
//            
//        }.disposed(by: disposeBag)
    }


}
