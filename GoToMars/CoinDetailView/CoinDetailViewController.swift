//
//  CoinDetailViewController.swift
//  GoToMars
//
//  Created by youngkyun park on 3/8/25.
//

import UIKit

import Toast

import RxCocoa
import RxSwift
import SnapKit
import DGCharts



final class CoinDetailViewController: UIViewController {

 
    private let disposeBag = DisposeBag()
    
    private let coinDetailView = CoinDetailView()
    let viewModel = CoinDetailViewModel()
    
    private let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorLayout()
        activityIndicator.startAnimating()
        coinDetailView.isHidden = true
        bind()
        chartTest()
    }
    
    private func bind() {
        
        
        let input = CoinDetailViewModel.Input(viewDidLoad: Observable.just(()))
        let ouput = viewModel.transform(input: input)
        
        //여긴 60초 주기 업데이트, 하지만 호출시 업데이트(인기검색어는 10분마다이기 때문에, 일부 차이가 발생 할 수도 있음)
        ouput.marketData.asDriver(onErrorJustReturn: []).drive(with: self) { owner, value in
            
            owner.coinDetailView.priceLabel.text = "₩" + value[0].currentPrice.roundToPlaces(places: 2).formatted()
            
            
            owner.coinStatus(value: value[0].priceChangePercent)
            
            
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
            
            owner.coinDetailView.isHidden = false
            owner.activityIndicator.stopAnimating()
            owner.activityIndicator.isHidden = true
        }.disposed(by: disposeBag)
        
        
        coinDetailView.secondSection.moreButton.rx.tap.subscribe(with: self) { owner, _ in
            owner.view?.makeToast("준비중입니다.", duration: 0.5)
        }.disposed(by: disposeBag)
        
        coinDetailView.thirdSection.moreButton.rx.tap.subscribe(with: self) { owner, _ in
            owner.view?.makeToast("준비중입니다.", duration: 0.5)
        }.disposed(by: disposeBag)
        
    }
    
    
    deinit {
        print("CoinDetailViewController DeInit")
    }


}



extension CoinDetailViewController {
    
    private func coinStatus(value: Double) {
        
        var imageName = ""
        var imageStatus = false
        var title = ""
        var color: UIColor
        

        let status = value > 0.0 ? true : false
        let rating = value.roundToPlaces(places: 2)
        
           
        if value == 0.0 {
            imageName = ""
            imageStatus = true
            title = rating.formatted() + "%"
            color = .projectNavy
            
            
        } else {
            
            if status {
                imageName = "arrowtriangle.up.fill"
                imageStatus = true
                title = rating.formatted() + "%"
                color = .projectRed
            } else {
                imageName = "arrowtriangle.down.fill"
                imageStatus = true
                title = rating.formatted() + "%"
                color = .projectBlue
            }
            
            
        }
        
        
    
        coinDetailView.statusButton.configuration = coinDetailView.statusButton.buttonConfiguration(title: title, color: color, imageStatus: imageStatus, imageName: imageName)
        
    }
    
}

// MARK: - IndicatorLayout
extension CoinDetailViewController {
    
    private func indicatorLayout() {
        view.addSubview(coinDetailView)
        view.addSubview(activityIndicator)
        
        coinDetailView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension CoinDetailViewController {
    
    private func chartTest() {
        
        let values: [Double] = [8, 104, 81, 93, 52, 44, 97, 101, 75, 28,
                                76, 25, 20, 13, 52, 44, 57, 23, 45, 91,
                                99, 14, 84, 48, 40, 71, 106, 41, 45, 61]
 

 
        
        var entries: [ChartDataEntry] = Array()
        for (i, value) in values.enumerated() {
            entries.append(ChartDataEntry(x: Double(i), y:  value))
        }
        
        
        let set1 = LineChartDataSet(entries: entries)
        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = false
        set1.lineWidth = 1.8
    
        let gradColors = [UIColor.projectNavy.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations:[CGFloat] = [1.0, 0.0]
        if let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradColors, locations: colorLocations) {
            set1.fill = LinearGradientFill(gradient: gradient, angle: 90)
        } else {
            set1.fillColor = .projectNavy
        }
        set1.drawFilledEnabled = true
        
        set1.fillAlpha = 1 //배경 투명도
       
        set1.colors = [.projectNavy] // 선 색상
        
        let data = LineChartData(dataSet: set1)
        
        data.setDrawValues(false) //데이터 레이블 미표시
        
        coinDetailView.chartView.data = data
        
 
        
    }
    
}
