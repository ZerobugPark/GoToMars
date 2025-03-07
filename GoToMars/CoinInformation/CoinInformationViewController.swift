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






enum SectionItem { //셀의 종류
    case firstSection(Test)
    case secondSection(Test2)
}

enum CollectionViewSectionModel { //섹션 정의
    case coin([SectionItem])
    case ntf([SectionItem])
}



extension CollectionViewSectionModel: SectionModelType {
    
    typealias Item = SectionItem
    
    var items: [SectionItem] {
        switch self {
        case .coin(let items):
            return items
        case .ntf(let items):
            return items
        }
    }
    
    
    init(original: CollectionViewSectionModel, items: [Self.Item]) {
        self = original
        
    }
}

struct Test {
    var items: Ment
}

struct Ment {
    let word: String
    
}


struct Test2 {
    var items: Ment2
}

struct Ment2 {
    let word: String
    
}




final class CoinInformationViewController: UIViewController {
    
    
    
    let coninInfoView = CoinInformationView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = coninInfoView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationConfiguration()
        view.backgroundColor = .white
        test()
        coninInfoView.collectionView.register(CoinInfoCollectionViewCell.self, forCellWithReuseIdentifier: "CoinInfoCollectionViewCell")
        coninInfoView.collectionView.register(NFTInfoCollectionViewCell.self, forCellWithReuseIdentifier: "NFTInfoCollectionViewCell")
    }
    
    
    func test() {
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<CollectionViewSectionModel> (configureCell: { dataSource, collectionView, indexPath, item in
            
            
            switch dataSource[indexPath] { //sectionType
            case .firstSection(let model):
                print(model)
                print(type(of: dataSource[indexPath]))
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoinInfoCollectionViewCell.id, for: indexPath) as? CoinInfoCollectionViewCell else { return UICollectionViewCell() }
                
                cell.numberLabel.text = "\(indexPath.row)"
                
                return cell
            case .secondSection(let data):
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NFTInfoCollectionViewCell.id, for: indexPath) as? NFTInfoCollectionViewCell else { return UICollectionViewCell() }
                
                return cell
                
                
            }
            
            
            
        }, configureSupplementaryView: { dataSource, collectionView, kind , indexPath in
            
            if indexPath.section == 0 {
                //                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PoseFeedEmptyView.identifier, for: indexPath) as! PoseFeedEmptyView
                
                // ...
                // 섹션 1번 서플먼트 뷰 헤더 정의
                // ...
                return UICollectionReusableView()
                //return header
            } else if indexPath.section == 1 {
                //                   let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PoseFeedHeader.identifier, for: indexPath) as! PoseFeedHeader
                //                   let title = dataSource.sectionModels[indexPath.section].header
                //                   header.configureHeader(with: title)
                
                // ...
                // 섹션 2번 서플먼트 뷰 헤더 정의
                // ...
                
                //                   return header
                return UICollectionReusableView()
            }
            else {
                return UICollectionReusableView()
            }
            
        })
        
        
        
        
        let test: [SectionItem] = [.firstSection(Test(items: Ment(word: "123"))),.firstSection(Test(items: Ment(word: "12"))),.firstSection(Test(items: Ment(word: "12"))),.firstSection(Test(items: Ment(word: "12"))),.firstSection(Test(items: Ment(word: "12"))),.firstSection(Test(items: Ment(word: "12"))),.firstSection(Test(items: Ment(word: "12"))),.firstSection(Test(items: Ment(word: "12"))),.firstSection(Test(items: Ment(word: "12"))),.firstSection(Test(items: Ment(word: "12"))),.firstSection(Test(items: Ment(word: "12"))),.firstSection(Test(items: Ment(word: "12"))),.firstSection(Test(items: Ment(word: "12")))
                                   
        ]
        
        let test2: [SectionItem] = [.secondSection(Test2(items: Ment2(word: "123"))),.secondSection(Test2(items: Ment2(word: "12"))),.secondSection(Test2(items: Ment2(word: "12"))),.secondSection(Test2(items: Ment2(word: "12"))),.secondSection(Test2(items: Ment2(word: "12"))),.secondSection(Test2(items: Ment2(word: "12"))),.secondSection(Test2(items: Ment2(word: "12")))
                                    
        ]
        
        
        let sections: Observable<[CollectionViewSectionModel]> = Observable.just([
            .coin(test),
            .ntf(test2)
        ])
        
        sections.bind(to: coninInfoView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    
    
    
    private func navigationConfiguration() {
        
        let view = NavigationTitleView()
        view.titleLabel.text = "가상자산 / 심볼 검색"
        navigationItem.titleView = view
    }
}
