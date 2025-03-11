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
    private let likeButtonTapped = PublishRelay<Int>()
    
    
    var query = ""
    
    lazy var callRequest = BehaviorRelay(value: query)
    
    private let viewModel = CoinViewModel()

    private let disposeBag = DisposeBag()
    
    init(query: String) {
        self.query = query
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        
        let input = CoinViewModel.Input(callRequest: callRequest, likeButtonTapped: likeButtonTapped)
        
        let output = viewModel.transform(input: input)

        
        output.searchData.asDriver().drive(tableView.rx.items(cellIdentifier: CoinTableViewCell.id, cellType: CoinTableViewCell.self)) { [weak self] row, element, cell in
          
            guard let self = self else { return }
            
            cell.setup(data: element)
            
            let image = element.isLiked ? "star.fill" : "star"
            cell.likeButton.setImage(UIImage(systemName: image), for: .normal)
            
            
            cell.likeButton.rx.tap.bind(with: self) { owner, _ in
                
                let msg = element.isLiked ? "즐겨찾기에서 삭제되었습니다" : "즐겨찾기에 추가되었습니다"
                
                owner.likeButtonTapped.accept(row)
                owner.view.makeToast("\(element.symbol)이(가) " + msg, duration: 0.5)

            }.disposed(by: cell.disposeBag)
            
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
                let vc = PopupViewController()
                
                vc.connectedNetwork.asDriver(onErrorJustReturn: ()).drive(with: owner) { owner, _ in
                    
                    let currentQuery = owner.callRequest.value
                    owner.callRequest.accept(currentQuery)
                    
                }.disposed(by: owner.disposeBag)
                
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .crossDissolve
                owner.present(vc, animated: true)
                
            case .unknown:
                break
    
            }
        }.disposed(by: disposeBag)
        
    }
}





// MARK: -  Layout
extension CoinViewController {
    
    private func configurationTableView() {
        
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.id)
        
        tableView.rowHeight = 60
        tableView.showsVerticalScrollIndicator = false
      
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


extension CoinViewController {
    
   private func showAlert(msg: String) {
        
        let title = "안내"
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        
        present(alert, animated: true)
        
        
    }
    
}
