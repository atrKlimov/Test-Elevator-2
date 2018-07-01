//
//  ViewController.swift
//  Test Elevator 2
//
//  Created by Artem Klimov on 26.06.2018.
//  Copyright © 2018 Artem Klimov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var elevator = Elevator()
    
    @IBAction func run(_ sender: UIButton) {
        elevator.run()
    }
    
    override func viewDidLoad() {
        
    }
}

