//
//  LikeTableRepository.swift
//  GoToMars
//
//  Created by youngkyun park on 3/11/25.
//

import Foundation
import RealmSwift


protocol LikeRepository {

    func getFileURL()
    func fetchAll() -> Results<LikeTable> //Load
    func createItem(id: String, status: Bool)
    func deleteItem(data: LikeTable)
    
}


final class LikeTableRepository: LikeRepository {
    
    private let realm = try! Realm()
    
    func getFileURL() {
        print(realm.configuration.fileURL)
    }
    
    func fetchAll() -> RealmSwift.Results<LikeTable> {
        let data = realm.objects(LikeTable.self)
        
        return data
    }
    
    func createItem(id: String, status: Bool) {
        
        do {
            try realm.write {
                
                let data = LikeTable(coinID: id, isLiked: status)
                
                realm.add(data)
                print("렘 저장 완료")
            }
            
            
        } catch {
          print("렘 저장 실패")
        }
    }
    
    func deleteItem(data: LikeTable) {
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            print("렘 데이터 삭제 실패")
        }
    }
    
    
}


