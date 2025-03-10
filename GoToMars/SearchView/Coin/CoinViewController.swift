//
//  CoinViewController.swift
//  GoToMars
//
//  Created by youngkyun park on 3/10/25.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class CoinViewController: UIViewController {
    
    
    private let tableView = UITableView()
    
    private let activityIndicator = UIActivityIndicatorView()
    private let infoLabel = CustomLabel(bold: true, fontSize: 16, color: .projectNavy)
    
    
    let viewModel = CoinViewModel()

    var query = ""
        
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        activityIndicator.startAnimating()
        tableView.isHidden = true
        infoLabel.isHidden = true
        
        configurationTableView()
        layout()
        bind()
        
     
    }
    
    
    private func bind() {
        
        
        let input = CoinViewModel.Input(viewDidLoad: Observable.just(query))
        
        let output = viewModel.transform(input: input)
        
        
        output.searchData.asDriver().drive(tableView.rx.items(cellIdentifier: CoinTableViewCell.id, cellType: CoinTableViewCell.self)) { row, element, cell in
          
            cell.setup(data: element)
            
        }.disposed(by: disposeBag)
        
        
        tableView.rx.modelSelected(SearchCoin.self).bind(with: self) { owner, element in
            
            let vc = CoinDetailViewController()
            
            vc.viewModel.id = element.id
            owner.navigationController?.pushViewController(vc, animated: true)
  
        }.disposed(by: disposeBag)
        
        
        output.isEmpty.asDriver(onErrorJustReturn: false).drive(with: self) { owner, status in
            
            if status {
                owner.infoLabel.isHidden = false
            } else {
                owner.infoLabel.isHidden = true
            }
            
        }.disposed(by: disposeBag)
        
        output.isFinished.asDriver(onErrorJustReturn: ()).drive(with: self) { owner, _ in
            
            owner.tableView.isHidden = false
            owner.activityIndicator.stopAnimating()
            owner.activityIndicator.isHidden = true
            
        }.disposed(by: disposeBag)
        
    }
}





// MARK: -  Layout
extension CoinViewController {
    
    private func configurationTableView() {
        
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.id)
        
        tableView.rowHeight = 60
      
    }
    
    private func layout() {
        
        view.addSubview(tableView)
        view.addSubview(infoLabel)
        view.addSubview(activityIndicator)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()

        }
        
        
        infoLabel.text = "검색 결과가 없습니다."
    }
}




