//
//  Constants.swift
//  Test Elevator 2
//
//  Created by Artem Klimov on 26.06.2018.
//  Copyright © 2018 Artem Klimov. All rights reserved.
//

import Foundation

enum Direction {
    case up, down, none
    
    var index: Int {
        switch self {
        case .down: return -1
        case .up , .none: return 1
        }
    }
}

extension Int {
    
    var random: Int { return Int(arc4random_uniform(UInt32(self + 1)))}
    
    func excludeCurrent(from floor: Int) -> Int {
        let range = 1...floor
        let randomValue = numericCast(arc4random_uniform(numericCast(range.count - 1))) + range.lowerBound
        return randomValue >= self ? randomValue + 1 : randomValue
    }
}


