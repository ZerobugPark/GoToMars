//
//  String+Extension.swift
//  GoToMars
//
//  Created by youngkyun park on 3/7/25.
//

import Foundation


extension String {
    subscript(idx: Int) -> String? {
        guard(0..<count).contains(idx) else {
                return nil
        }
        let target = index(startIndex, offsetBy: idx)
        return String(self[target])
    }
}
