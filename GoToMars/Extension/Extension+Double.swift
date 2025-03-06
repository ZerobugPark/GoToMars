//
//  Extension+Double.swift
//  GoToMars
//
//  Created by youngkyun park on 3/7/25.
//

import Foundation


extension Double {
    
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded(.toNearestOrEven) / divisor
    }
    
}

