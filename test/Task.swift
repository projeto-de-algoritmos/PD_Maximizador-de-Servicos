//
//  Task.swift
//  test
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 09/10/19.
//  Copyright © 2019 AppleInc. All rights reserved.
//

import Foundation

struct Task: Equatable {
    var name: String
    let startDate: Date
    let endDate: Date
    var selected = false
    var workerName = ""

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.name == rhs.name && lhs.startDate == rhs.startDate && lhs.endDate == rhs.endDate
    }
}
