//
//  ExchangeViewController.swift
//  GoToMars
//
//  Created by youngkyun park on 3/6/25.
//

import UIKit

import SnapKit
import RxCocoa
import RxSwift
import RxGesture

final class ExchangeViewController: UIViewController {

    
    private let exchangeView = ExchangeView()
    private let viewModel = ExchangeViewModel()
    
    private var disposeBag = DisposeBag()
    

    override func loadView() {
        view = exchangeView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationConfiguration()
        exchangeView.tableView.register(UpbitTableViewCell.self, forCellReuseIdentifier: UpbitTableViewCell.id)
        exchangeView.tableView.rowHeight = 40
        
    }
    
    
    private func bind() {
        

        //startWith. 처음에 이벤트를 넣어주는 역할
        let input = ExchangeViewModel.Input(viewDidLoad: Observable<Int>.interval(.seconds(5), scheduler: MainScheduler.instance).startWith(0),
                                            filterButtonTapped: Observable.merge(exchangeView.currentPriceView.rx.tapGesture().when(.recognized).asObservable()
                                                .map { [weak self] _ in self?.exchangeView.currentPriceView.tag ?? 0 },
                                                                   exchangeView.compareView.rx.tapGesture().when(.recognized).asObservable()
                                                .map { [weak self] _ in self?.exchangeView.compareView.tag ?? 1}, exchangeView.accTradeView.rx.tapGesture().when(.recognized).asObservable()
                                                .map { [weak self] _ in self?.exchangeView.accTradeView.tag ?? 2}))


        let output = viewModel.transform(input: input)
        
        output.coinList.asDriver().drive(exchangeView.tableView.rx.items(cellIdentifier: UpbitTableViewCell.id, cellType: UpbitTableViewCell.self)) { row, element, cell in
            
            cell.setup(data: element)
            
            
        }.disposed(by: disposeBag)
        
        
        output.filterStatus.asDriver(onErrorJustReturn: Filter.normalState).drive(with: self) { owner, status in
            owner.changButtonStatus(status)
        }.disposed(by: disposeBag)
        
        
        output.errorStatus.asDriver(onErrorJustReturn: APIError.unknown).drive(with: self) { owner, error in
            switch error {
            case .badRequest:
                owner.showAlert(msg: error.message)
            case .unauthorized:
                owner.showAlert(msg: error.message)
            case .forbidden:
                owner.showAlert(msg: error.message)
            case .baseURLError:
                owner.showAlert(msg: error.message)
            case .tooManyRequests:
                owner.showAlert(msg: error.message)
            case .internalServerError:
                owner.showAlert(msg: error.message)
            case .serviceUnavailable:
                owner.showAlert(msg: error.message)
            case .accessDenied:
                owner.showAlert(msg: error.message)
            case .apiKeyMissing:
                owner.showAlert(msg: error.message)
            case .noconnection:
                print("hereddd")
                let vc = PopupViewController()
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .crossDissolve
                owner.present(vc, animated: true)
                
            case .unknown:
                break
    
            }
        }.disposed(by: disposeBag)
        
 
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bind()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        disposeBag = DisposeBag()
        viewModel.disposeBag = DisposeBag()
    }

 
    
    private func navigationConfiguration() {
        
        let navigationTitleView = NavigationTitleView()
        navigationTitleView.titleLabel.text = "거래소"
        
        let leftItem =  UIBarButtonItem(customView: navigationTitleView)
        navigationItem.leftBarButtonItem = leftItem

    }
    
    deinit {
        print("ExchangeViewController Deinit")
    }

    
    
}

// MARK: - filter 관련 UI 적용

extension ExchangeViewController {
    
    private func changButtonStatus(_ status: Filter) {
        
        exchangeView.currentFilterButton.titleLabel.textColor = .projectGray
        exchangeView.currentFilterButton.topImage.tintColor = .projectGray
        exchangeView.currentFilterButton.bottomImage.tintColor = .projectGray
        
        exchangeView.compareViewFilterButton.titleLabel.textColor = .projectGray
        exchangeView.compareViewFilterButton.topImage.tintColor = .projectGray
        exchangeView.compareViewFilterButton.bottomImage.tintColor = .projectGray
        
        exchangeView.accTradeFilterButton.titleLabel.textColor = .projectGray
        exchangeView.accTradeFilterButton.topImage.tintColor = .projectGray
        exchangeView.accTradeFilterButton.bottomImage.tintColor = .projectGray
        
        
        switch status {
        case .downTrade:
            exchangeView.accTradeFilterButton.titleLabel.textColor = .projectNavy
            exchangeView.accTradeFilterButton.bottomImage.tintColor = .projectNavy
        case .upTrade:
            exchangeView.accTradeFilterButton.titleLabel.textColor = .projectNavy
            exchangeView.accTradeFilterButton.topImage.tintColor = .projectNavy
        case .downCompare:
            exchangeView.compareViewFilterButton.titleLabel.textColor = .projectNavy
            exchangeView.compareViewFilterButton.bottomImage.tintColor = .projectNavy
        case .upCompare:
            exchangeView.compareViewFilterButton.titleLabel.textColor = .projectNavy
            exchangeView.compareViewFilterButton.topImage.tintColor = .projectNavy
        case .downCurrentPrice:
            exchangeView.currentFilterButton.titleLabel.textColor = .projectNavy
            exchangeView.currentFilterButton.bottomImage.tintColor = .projectNavy
        case .upCurrentPrice:
            exchangeView.currentFilterButton.titleLabel.textColor = .projectNavy
            exchangeView.currentFilterButton.topImage.tintColor = .projectNavy
        case .normalState:
            break
        }
    }
    
}

extension ExchangeViewController {
    
   private func showAlert(msg: String) {
        
        let title = "안내"
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        
        present(alert, animated: true)
        
        
    }
    
}
