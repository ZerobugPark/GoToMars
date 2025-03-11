//
//  CoinInfomationViewController.swift
//  GoToMars
//
//  Created by youngkyun park on 3/6/25.
//

import UIKit

import SnapKit
import RxCocoa
import RxSwift
import RxDataSources



final class CoinInformationViewController: UIViewController {
    
    private let coninInfoView = CoinInformationView()
    private let viewModel = CoinInfoViewModel()
    
    private let activityIndicator = UIActivityIndicatorView()
    private let disposeBag = DisposeBag()
    
    
    private lazy var dataSource = RxCollectionViewSectionedReloadDataSource<CollectionViewSectionModel> (configureCell: { dataSource, collectionView, indexPath, item in
        
        
        switch dataSource[indexPath] { // dataSource Type == sectionItem
        case .firstSection(let coin):
            
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoinInfoCollectionViewCell.id, for: indexPath) as? CoinInfoCollectionViewCell else { return UICollectionViewCell() }
            
            cell.setup(data: coin, index: indexPath.row)
            
            return cell
            
        case .secondSection(let nft):
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NFTInfoCollectionViewCell.id, for: indexPath) as? NFTInfoCollectionViewCell else { return UICollectionViewCell() }
            
            cell.setup(data: nft)
            
            
            
            
            return cell
            
        }
        
    }, configureSupplementaryView: { dataSource, collectionView, kind , indexPath in
        if indexPath.section == 0 {
            
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionHeaderReusableView.id, for: indexPath) as? CollectionHeaderReusableView else {
                return  UICollectionReusableView() }
            
            headerView.titleLabel.text = "인기 검색어"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM.dd hh:mm"
            headerView.timeLabel.text = dateFormatter.string(from: Date())
            
            
            
            return headerView
            
            
        } else if indexPath.section == 1 {
            
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionHeaderReusableView.id, for: indexPath) as? CollectionHeaderReusableView else {
                return  UICollectionReusableView() }
            
            headerView.titleLabel.text = "인기 NFT"
            
            return headerView
        }
        else {
            return UICollectionReusableView()
        }
        
        
    })
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationConfiguration()
        layout()
        collectionViewRegister()
        coninInfoView.isHidden = true
        activityIndicator.startAnimating()
        bind()
        hideKeyboard()
    }
    
    
    private func bind() {
        
        
        let input = CoinInfoViewModel.Input(viewdidLoad: Observable<Int>.interval(.seconds(600), scheduler: MainScheduler.instance).startWith(0), searchButtonTapped:  coninInfoView.searchBar.rx.searchButtonClicked.withLatestFrom(coninInfoView.searchBar.rx.text.orEmpty))
        
        let output = viewModel.transform(input: input)
        
        
        // do: 구독시점이 아닌 방출 시점에 처리 (구독보다 do가 먼저 실행됨)
        output.trending.asDriver().do { [weak self] value in
            
            if !value[0].items.isEmpty {
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                self?.coninInfoView.isHidden = false
            }
            
        }.drive(coninInfoView.collectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        
        coninInfoView.collectionView.rx.modelSelected(SectionItem.self).bind(with: self) { owner, element in
            
            switch element {
            case .firstSection(let coin):
                
                let vc = CoinDetailViewController()
                
                vc.viewModel.id = coin.item.id
                
                owner.navigationController?.pushViewController(vc, animated: true)
                
            case .secondSection:
                return
            }
            
        }.disposed(by: disposeBag)
        
        
        output.blankResult.asDriver(onErrorJustReturn: ()).drive(with: self, onNext: { owenr, _ in
            owenr.view.endEditing(true)
        }).disposed(by: disposeBag)
        
        
        output.searchText.asDriver(onErrorJustReturn: "").drive(with: self) { owner, text in
            
            let vc = SearchViewController()
            vc.searchText = text
            owner.navigationController?.pushViewController(vc, animated: true)
            
            
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
                
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .crossDissolve
                owner.present(vc, animated: true)
                
            case .unknown:
                owner.showAlert(msg: error.message)
    
            }
        }.disposed(by: disposeBag)
        
        
    }
    
    
    private func navigationConfiguration() {
        
        let navigationTitleView = NavigationTitleView()
        navigationTitleView.titleLabel.text = "가상자산 / 심볼 검색"
        navigationItem.backButtonTitle = ""
        let leftItem =  UIBarButtonItem(customView: navigationTitleView)
        navigationItem.leftBarButtonItem = leftItem
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.endEditing(true)
    }

    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//        self.view.endEditing(true)
//    }
//    
    private func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

// MARK: - CollectionView Register
extension CoinInformationViewController {
    
    private func collectionViewRegister() {
        coninInfoView.collectionView.register(CoinInfoCollectionViewCell.self, forCellWithReuseIdentifier: "CoinInfoCollectionViewCell")
        coninInfoView.collectionView.register(NFTInfoCollectionViewCell.self, forCellWithReuseIdentifier: "NFTInfoCollectionViewCell")
        coninInfoView.collectionView.register(CollectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderReusableView.id) // dataSource에서 쓰는 kind
    }
}

// MARK: - IndicatorLayout
extension CoinInformationViewController {
    
    private func layout() {
        view.addSubview(coninInfoView)
        view.addSubview(activityIndicator)
        
        coninInfoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}


extension CoinInformationViewController {
    
   private func showAlert(msg: String) {
        
        let title = "안내"
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        
        present(alert, animated: true)
        
        
    }
    
}
