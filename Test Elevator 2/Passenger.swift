//
//  Passenger.swift
//  Test Elevator 2
//
//  Created by Artem Klimov on 26.06.2018.
//  Copyright © 2018 Artem Klimov. All rights reserved.
//

import Foundation

// Struct for passenger

struct Passenger {
    
    var currentFloor: Int
    
    var destinationFloor: Int
    
    var direction: Direction {
        return destinationFloor > currentFloor ? .up : .down
    }
}

extension Passenger: CustomStringConvertible {
    var description: String { return "\n Current Floor: \(currentFloor) / Destination Floor: \(destinationFloor) " }
}
