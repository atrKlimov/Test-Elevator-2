//
//  Cabin.swift
//  Test Elevator 2
//
//  Created by Artem Klimov on 27.06.2018.
//  Copyright © 2018 Artem Klimov. All rights reserved.
//

import Foundation


class Cabin {
    
    // Set maximum passengers in Cabin
    var maxPassengers = Constants.maxPassengersInCabin
    
    var passengers = [Passenger]()
    
    // Take off passengers from Cabin to House
    func takeOffPassengers (on floor: Int, to house: inout [Passenger], with direction: Direction) {
        for (index, passenger) in passengers.enumerated().reversed() {
            if passenger.destinationFloor == floor {
                passengers.remove(at: index)
                house.append(Passenger(currentFloor: floor, destinationFloor: floor.excludeCurrent(from: House.houseFloors)))
                        print(House.houseFloors)
            }
        }
    }
    
    // Take Passengers from House to Cabin
    func takePassengers(from floor: Int, in house: inout [Passenger], with direction: Direction) {
        for (index, passenger) in house.enumerated().reversed() {
            if passenger.currentFloor == floor, passengers.count != maxPassengers, passenger.direction == direction {
                passengers.append(house.remove(at: index))
            }
        }
    }
}

// Return calls from Cabin for ElevatorManager
extension Cabin: Calls {
    
    // return Calls from lift
    var calls: [(floor: Int, direction: Direction)] {
        var innerCalls = [(floor: Int, direction: Direction)]()
        for passenger in passengers.indices {
            innerCalls.append((floor: passengers[passenger].destinationFloor, direction: passengers[passenger].direction))
        }
        return innerCalls
    }
}
