//
//  LikeTable.swift
//  GoToMars
//
//  Created by youngkyun park on 3/11/25.
//

import Foundation
import RealmSwift


final class LikeTable: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var coinID: String
    @Persisted var isLiked: Bool
    
    
    convenience init(coinID: String, isLiked: Bool) {
        self.init()
        self.coinID = coinID
        self.isLiked = isLiked
    }
    
    
}
