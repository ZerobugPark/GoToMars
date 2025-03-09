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

 
    private let disposeBag = DisposeBag()
    
    private let coinDetailView = CoinDetailView()
    let viewModel = CoinDetailViewModel()
 
    
    override func loadView() {
        view = coinDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        bind()
        
    }
    
    private func bind() {
        
        
        let input = CoinDetailViewModel.Input(viewDidLoad: Observable.just(()))
        
        let ouput = viewModel.transform(input: input)
        
        
        ouput.marketData.asDriver(onErrorJustReturn: []).drive(with: self) { owner, value in
            
            owner.coinDetailView.secondSection.priceTitleLabel.text = "24시간 고가"
            owner.coinDetailView.secondSection.priceLabel.text = "₩" + value[0].high24h.roundToPlaces(places: 2).formatted()
            
            owner.coinDetailView.secondSection.lowPriceTitleLabel.text = "24시간 저가"
            owner.coinDetailView.secondSection.lowPriceLabel.text = "₩" + value[0].low24h.roundToPlaces(places: 2).formatted()
            
            owner.coinDetailView.secondSection.athPriceTitleLabel.text = "역대 최고가"
            owner.coinDetailView.secondSection.athPriceLabel.text = "₩" + value[0].ath.roundToPlaces(places: 2).formatted()
            owner.coinDetailView.secondSection.athDateLabel.text = value[0].athDate
            
            owner.coinDetailView.secondSection.atlPriceTitleLabel.text = "역대 최저가"
            owner.coinDetailView.secondSection.atlPriceLabel.text = "₩" + value[0].atl.roundToPlaces(places: 2).formatted()
            owner.coinDetailView.secondSection.atlDateLabel.text = value[0].atlDate
            
            
            
          
            owner.coinDetailView.thirdSection.marketCapTitleLabel  .text = "시가 총액"
            owner.coinDetailView.thirdSection.marketCapLabel.text = "₩" + value[0].marketCap.roundToPlaces(places: 2).formatted()
            
            owner.coinDetailView.thirdSection.fdvTitleLabel.text = "완전 희석 가치(FDV)"
            owner.coinDetailView.thirdSection.fdvLabel.text = "₩" + value[0].fullyDilutedValuation.roundToPlaces(places: 2).formatted()
            owner.coinDetailView.thirdSection.totalVolumeTitleLabel.text = "총 거래량"
            owner.coinDetailView.thirdSection.totalVolumeLabel.text = "₩" + value[0].totalVolume.roundToPlaces(places: 2).formatted()
            
            
            
            
            
            
            
        }.disposed(by: disposeBag)
        
    }
    
    
    deinit {
        print("CoinInfoViewModel DeInit")
    }


}

