//
//  CoinInfomationViewController.swift
//  GoToMars
//
//  Created by youngkyun park on 3/6/25.
//

import UIKit

import RxCocoa
import RxSwift
import RxDataSources



final class CoinInformationViewController: UIViewController {
    
    private let coninInfoView = CoinInformationView()
    private let viewModel = CoinInfoViewModel()
    
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
    
    override func loadView() {
        view = coninInfoView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
      //  navigationConfiguration()
        collectionViewRegister()
        bind()
    }
    
    
    private func bind() {

        let input = CoinInfoViewModel.Input(viewdidLoad: Observable.just(()))
        let output = viewModel.transform(input: input)
        output.trending.asDriver().drive(coninInfoView.collectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
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
        
        
        
        
        
    }
    

    private func navigationConfiguration() {
        
        let view = NavigationTitleView()
        view.titleLabel.text = "가상자산 / 심볼 검색"
        view.sizeToFit()
        navigationItem.titleView = view

//        navigationItem.titleView?.sizeToFit()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationConfiguration()
    }
    

}


extension CoinInformationViewController {
    
    private func collectionViewRegister() {
        coninInfoView.collectionView.register(CoinInfoCollectionViewCell.self, forCellWithReuseIdentifier: "CoinInfoCollectionViewCell")
        coninInfoView.collectionView.register(NFTInfoCollectionViewCell.self, forCellWithReuseIdentifier: "NFTInfoCollectionViewCell")
        coninInfoView.collectionView.register(CollectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderReusableView.id) // dataSource에서 쓰는 kind
    }
}
