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
    
    static let startFloor = 1
    static let maxFloor = 20
    static let minFloor = 5
    static let passengersOnFloor = 0...10
    
    static var houseFloors : Int = { return (maxFloor - minFloor).random + minFloor }()
    
    static func getPassengers () -> [Passenger] {
        var passengers = [Passenger]()
        for floor in startFloor...houseFloors {
            for passenger in passengersOnFloor.lowerBound..<passengersOnFloor.count.random {
                if passenger != 0 {
                    passengers.append(Passenger(currentFloor: floor, destinationFloor: floor.excludeCurrent(from: houseFloors)))
                }
            }
        }
        return passengers
    }
}

extension House: Calls {
    var calls: [(floor: Int, direction: Direction)] {
        var innerCalls = [(floor: Int, direction: Direction)]()
        for passenger in passengers.indices {
            innerCalls.append((floor: passengers[passenger].currentFloor, direction: passengers[passenger].direction))
        }
        return innerCalls
    }
}
