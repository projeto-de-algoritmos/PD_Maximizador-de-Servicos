//
//  TasksSingleton.swift
//  test
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 09/10/19.
//  Copyright © 2019 AppleInc. All rights reserved.
//

import Foundation

class TasksSingleton {

    private init() { }
    static let shared = TasksSingleton()

    var tasks = [Task]()
}
