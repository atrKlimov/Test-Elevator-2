//
//  House.swift
//  Test Elevator 2
//
//  Created by Artem Klimov on 26.06.2018.
//  Copyright © 2018 Artem Klimov. All rights reserved.
//

import Foundation

class House {
    
    var passengers: [Passenger]
    var floors: Int
    
    init() {
        passengers = House.getPassengers()
        floors = House.houseFloors
    }
    
    // Static factory vars and method
    static let houseFloors : Int = { return (Constants.maxFloor - Constants.minFloor).random + Constants.minFloor }()
    
    static func getPassengers () -> [Passenger] {
        var passengers = [Passenger]()
        for floor in Constants.firstFloor...houseFloors {
            for passenger in Constants.passengersOnFloor.lowerBound..<Constants.passengersOnFloor.count.random {
                if passenger != 0 {
                    passengers.append(Passenger(currentFloor: floor, destinationFloor: floor.excludeCurrent(from: houseFloors)))
                }
            }
        }
        return passengers
    }
}

// Return calls from floor, that house send to ElevatorManager
extension House: Calls {
    
    var calls: [(floor: Int, direction: Direction)] {
        var innerCalls = [(floor: Int, direction: Direction)]()
        for passenger in passengers.indices {
            innerCalls.append((floor: passengers[passenger].currentFloor, direction: passengers[passenger].direction))
        }
        return innerCalls
    }
}


extension Int {
    // return random Int from range to self
    var random: Int { return Int(arc4random_uniform(UInt32(self + 1)))}
    
    // return random Int from 1 to floor: Int with self excluding
    func excludeCurrent(from floor: Int) -> Int {
        let range = 1...floor
        let randomValue = numericCast(arc4random_uniform(numericCast(range.count - 1))) + range.lowerBound
        return randomValue >= self ? randomValue + 1 : randomValue
    }
}
