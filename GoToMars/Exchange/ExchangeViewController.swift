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

    
    enum FillterButton {
        case current
        case compare
        case transaction
    }
    
//    var filterStatus: FillterButton = .transaction {
//        didSet {
//            switch oldValue {
//            case .current:
//            case .compare:
//            case .transaction:
//            }
//        }
//    }
//    

    
    let exchangeView = ExchangeView()
    let viewModel = ExchangeViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = exchangeView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationConfiguration()
        
        
        exchangeView.tableView.register(UpbitTableViewCell.self, forCellReuseIdentifier: UpbitTableViewCell.id)
        exchangeView.tableView.rowHeight = 40
        
        bind()

        
    }
    
    
    private func bind() {
        
        
        let input = ExchangeViewModel.Input(viewDidLoad: Observable.just(()), test: Observable.merge(exchangeView.currentPriceView.rx.tapGesture().when(.recognized).asObservable()
            .map { [weak self] _ in self?.exchangeView.currentPriceView.tag ?? 0 },
                                                                   exchangeView.compareView.rx.tapGesture().when(.recognized).asObservable().map { [weak self] _ in self?.exchangeView.compareView.tag ?? 1}, exchangeView.transactionValueView.rx.tapGesture().when(.recognized).asObservable().map { [weak self] _ in self?.exchangeView.transactionValueView.tag ?? 2}))


        let output = viewModel.transform(input: input)
        
        output.coinList.asDriver().drive(exchangeView.tableView.rx.items(cellIdentifier: UpbitTableViewCell.id, cellType: UpbitTableViewCell.self)) { row, element, cell in
            
            cell.setup(data: element)
            
            
        }.disposed(by: disposeBag)
        
        
        
        
        
        
    }
    

 
    
    private func navigationConfiguration() {
        
        let view = NavigationTitleView()
        view.titleLabel.text = "거래소"
        navigationItem.titleView = view
    }
    
    deinit {
        //사실 불필요 첫화면이라 Deinit 안될텐뎅
        print("ExchangeViewController Deinit")
    }

    
    
}

