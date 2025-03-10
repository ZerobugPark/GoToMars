//
//  CoinInformationView.swift
//  GoToMars
//
//  Created by youngkyun park on 3/7/25.
//

import UIKit
import SnapKit


final class CoinInformationView: BaseView {

    
    private let lineView = UIView()
    let searchBar = UISearchBar()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: creatCompositionalLayout())

    
    override func configureHierarchy() {
        
        addSubview(lineView)
        addSubview(searchBar)
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
            
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-10)
        }
        
        
    
        
    }
    
    override func configureView() {
        
        self.backgroundColor = .white
        lineView.backgroundColor = .projectGray
        

       let placeholder = "검색어를 입력하세요"
    
        searchBar.backgroundImage = UIImage() // 배경제거 , searchBarStyle을 minial로 사용하면 배경이 제거되지만, 텍스트필드 색상 변경이 안됨
        
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.projectGray.cgColor])
        
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.searchTextField.layer.cornerRadius = 20
        searchBar.searchTextField.layer.borderColor = UIColor.projectGray.cgColor
        searchBar.searchTextField.font = .systemFont(ofSize: 14)
        
        searchBar.searchTextField.clipsToBounds = true
        
        searchBar.searchTextField.backgroundColor = .white
        

        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false


    }
    
    private func creatCompositionalLayout() -> UICollectionViewLayout {
        
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/7))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                
                let innerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
                
                let innerGroup = NSCollectionLayoutGroup.vertical(layoutSize: innerSize, subitems: [item])
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [innerGroup])
                
                let section = NSCollectionLayoutSection(group: group)
                
                // 헤더 추가
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: .absolute(40))
                let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
                section.boundarySupplementaryItems = [headerItem]
            
                return section
                
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 5), heightDimension: .fractionalHeight(1.0))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.35))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .continuous//.groupPagingCentered
                
                // 헤더 추가
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: .absolute(40))
                let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
                section.boundarySupplementaryItems = [headerItem]
                
                return section
            }
            
        }
        return layout
       
    
        
    }
    
    deinit {
        print("CoinInformationView Deinit")
    }
    
    
    
}
