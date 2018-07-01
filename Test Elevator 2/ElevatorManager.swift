//
//  Elevator.swift
//  Test Elevator 2
//
//  Created by Artem Klimov on 26.06.2018.
//  Copyright © 2018 Artem Klimov. All rights reserved.
//

import Foundation

class Elevator: Calls {
    
    var currentFloor = 1
    
    var cabin = Cabin()
    var house = House()
    
    var direction: Direction = .up {
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
    
    func run () {
        print("Current Floor \(currentFloor)")

        cabin.takeOffPassengers(on: currentFloor, to: &house.passengers, with: direction)
        if passengersInCabinCount == 0 {
            direction = .none
        }
        cabin.takePassengers(from: currentFloor, in: &house.passengers, with: direction)
        currentFloor = nextStop()
    }
    
    func checkDirection () -> Direction {
        let callsFromFloor = house.calls.filter({$0.floor == currentFloor})
        if callsFromFloor.filter({$0.direction == .up}).count > callsFromFloor.filter({$0.direction == .down}).count {
            return .up
        } else {
            return .down
        }
    }
    
    func nextStop() -> Int {
        switch passengersInCabinCount {
        case cabin.maxPassengers:
            let callsInSameDirection = cabin.calls.filter({$0.floor * direction.index > currentFloor * direction.index && $0.direction == direction})
            let nextFloor = callsInSameDirection.map({$0.floor * direction.index}).min()
            return nextFloor! * direction.index
        case 1..<cabin.maxPassengers:
            let callsInSameDirection = calls.filter({$0.floor * direction.index > currentFloor * direction.index && $0.direction == direction})
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
}

extension Elevator: CustomStringConvertible {
    var description: String { return
        """
        current floor \(currentFloor)
        next floor \(nextStop())
        
        """
    }
    
    
}
