//
//  Elevator.swift
//  Test Elevator 2
//
//  Created by Artem Klimov on 26.06.2018.
//  Copyright © 2018 Artem Klimov. All rights reserved.
//

import Foundation

// Accumulate information with calls from Cabin and House
// Define next floor for Cabin
class ElevatorManager: Calls {

    var currentFloor = Constants.cabinStartFloor
    var cabin = Cabin()
    var house = House()
    var direction: Direction = .up {
        // if lift is empty it try to find future direction from calls from floor
        didSet {
            if direction == .none {
                direction = checkDirection()
            }
        }
    }
    
    var passengersInCabinCount: Int {
        return cabin.passengers.count
    }
    
    var calls: [(floor: Int, direction: Direction)] {
        return cabin.calls + house.calls
    }
    
    // Calculete calls from floor and return bigger count direction
    func checkDirection () -> Direction {
        print("Try find direction")
        let callsFromFloor = house.calls.filter({$0.floor == currentFloor})
        if callsFromFloor.filter({$0.direction == .up}).count > callsFromFloor.filter({$0.direction == .down}).count {
            return .up
        } else {
            return .down
        }
    }
    
    // Return next stop
    // default parameter will work in case then no passengers on first floor after House Initialization
    // direction.index helps find minimum floor in house
    func nextStop() -> Int {
        switch passengersInCabinCount {
        case cabin.maxPassengers:
            let callsInSameDirection = cabin.calls.filter({($0.floor * direction.index) > (currentFloor * direction.index) && $0.direction == direction})
            let nextFloor = callsInSameDirection.map({$0.floor * direction.index}).min()
            return nextFloor! * direction.index
        case 1..<cabin.maxPassengers:
            let callsInSameDirection = calls.filter({($0.floor * direction.index) > (currentFloor * direction.index) && $0.direction == direction})
            let nextFloor = callsInSameDirection.map({$0.floor * direction.index}).min()
            return nextFloor! * direction.index
        default:
            guard let nextFloor = house.calls.map({$0.floor}).min() else {
                print("Lift waiting for passengers")
                return currentFloor
            }
            return nextFloor
        }
    }
    
    func run () {
        print("Current Floor \(currentFloor)")
        cabin.takeOffPassengers(on: currentFloor, to: &house.passengers, with: direction)
        if passengersInCabinCount == 0 {
            direction = .none
        }
        cabin.takePassengers(from: currentFloor, in: &house.passengers, with: direction)
        currentFloor = nextStop()
        
        print(self)
    }
}

extension ElevatorManager: CustomStringConvertible {
    var description: String { return
        """
        Next floor: \(currentFloor)
        Direction: \(direction)
        Passenger in Cabin: \(cabin.passengers)
        Passenger in House: \(house.passengers)
        """
    }
}
