//
//  CoinInfomationViewController.swift
//  GoToMars
//
//  Created by youngkyun park on 3/6/25.
//

import UIKit
import RxSwift
import RxCocoa
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
        navigationConfiguration()
        
        view.backgroundColor = .white
        
        

 
        coninInfoView.collectionView.register(CoinInfoCollectionViewCell.self, forCellWithReuseIdentifier: "CoinInfoCollectionViewCell")
        coninInfoView.collectionView.register(NFTInfoCollectionViewCell.self, forCellWithReuseIdentifier: "NFTInfoCollectionViewCell")
        coninInfoView.collectionView.register(CollectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderReusableView.id) // forSupplementaryViewOfKind 밑에서 쓰는 kind
        
        bind()
        collectionViewDataSource()

        
//        Observable.just(()).flatMap {
//            NetworkManager.shared.callRequest(api: .coingeckoTrending, type: CoinGeckoTrendingAPI.self)
//        }.bind(with: self) { owner, response in
//            switch response {
//            case .success(let value):
//                dump(value)
//            case .failure(let error):
//                print(error)
//            }
//        }.disposed(by: disposeBag)

        
    }
    
    
    func bind() {
        
    
        let input = CoinInfoViewModel.Input(viewdidLoad: Observable.just(()))
        
        
        let output = viewModel.transform(input: input)
        
        
        output.trending.asDriver().drive(coninInfoView.collectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        
        
//        let test: [SectionItem] = [.firstSection(Test(items: Ment(word: "123"))),.firstSection(Test(items: Ment(word: "12"))),.firstSection(Test(items: Ment(word: "12"))),.firstSection(Test(items: Ment(word: "12"))),.firstSection(Test(items: Ment(word: "12"))),.firstSection(Test(items: Ment(word: "12"))),.firstSection(Test(items: Ment(word: "12"))),.firstSection(Test(items: Ment(word: "12"))),.firstSection(Test(items: Ment(word: "12"))),.firstSection(Test(items: Ment(word: "12"))),.firstSection(Test(items: Ment(word: "12"))),.firstSection(Test(items: Ment(word: "12"))),.firstSection(Test(items: Ment(word: "12")))
//                                   
//        ]
//        
//        let test2: [SectionItem] = [.secondSection(Test2(items: Ment2(word: "123"))),.secondSection(Test2(items: Ment2(word: "12"))),.secondSection(Test2(items: Ment2(word: "12"))),.secondSection(Test2(items: Ment2(word: "12"))),.secondSection(Test2(items: Ment2(word: "12"))),.secondSection(Test2(items: Ment2(word: "12"))),.secondSection(Test2(items: Ment2(word: "12")))
                                    
//        ]
        
//        
//        let sections: Observable<[CollectionViewSectionModel]> = Observable.just([
//            .coin(test),
//            .ntf(test2)
//        ])
        
//        sections.bind(to: coninInfoView.collectionView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
//        
    }
    

    
    
    
    private func navigationConfiguration() {
        
        let view = NavigationTitleView()
        view.titleLabel.text = "가상자산 / 심볼 검색"
        navigationItem.titleView = view
    }
}


extension CoinInformationViewController {
    
    private func collectionViewDataSource() {
 
    }
}
