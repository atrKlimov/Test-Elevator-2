//
//  File.swift
//  Test Elevator 2
//
//  Created by Artem Klimov on 27.07.2018.
//  Copyright © 2018 Artem Klimov. All rights reserved.
//

import Foundation

protocol Calls: class {
    var calls: [(floor: Int, direction: Direction)] {get}
}
