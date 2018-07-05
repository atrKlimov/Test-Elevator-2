//
//  Direction.swift
//  Test Elevator 2
//
//  Created by Artem Klimov on 05.07.2018.
//  Copyright © 2018 Artem Klimov. All rights reserved.
//

import Foundation

// Define directions for ElevatorManager
enum Direction {
    
    case up, down, none
    
    //return associate property for direction then ElevatorManager find next stop
    var index: Int {
        switch self {
        case .down: return -1
        case .up , .none: return 1
        }
    }
}
