//
//  NaverAPI.swift
//  GoToMars
//
//  Created by youngkyun park on 3/13/25.
//

import Foundation


struct NaverNewsAPI: Decodable {
    let items: [Items]
}


struct Items: Decodable {

    let title: String
    let originallink: String
}
