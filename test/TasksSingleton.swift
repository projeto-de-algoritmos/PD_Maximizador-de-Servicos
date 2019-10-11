//
//  TasksSingleton.swift
//  test
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 09/10/19.
//  Copyright © 2019 AppleInc. All rights reserved.
//

import Foundation

class TasksSingleton {

    private init() { createTasksForTest() }
    static let shared = TasksSingleton()

    var tasks = [Task]()

    private func createTasksForTest() {
        var dateComponents = DateComponents()
        dateComponents.year = 2019
        dateComponents.month = 1
        dateComponents.day = 1

        // task 1
        dateComponents.hour = 1
        let sd1 = Calendar.current.date(from: dateComponents)!
        dateComponents.hour = 2
        let ed1 = Calendar.current.date(from: dateComponents)!
        tasks.append(Task(name: "Task 1", startDate: sd1, endDate: ed1))

        // task 2
        dateComponents.hour = 1
        let sd2 = Calendar.current.date(from: dateComponents)!
        dateComponents.hour = 3
        let ed2 = Calendar.current.date(from: dateComponents)!
        tasks.append(Task(name: "Task 2", startDate: sd2, endDate: ed2))

        // task 3
        dateComponents.hour = 2
        let sd3 = Calendar.current.date(from: dateComponents)!
        dateComponents.hour = 4
        let ed3 = Calendar.current.date(from: dateComponents)!
        tasks.append(Task(name: "Task 3", startDate: sd3, endDate: ed3))

        // task 4
        dateComponents.hour = 3
        let sd4 = Calendar.current.date(from: dateComponents)!
        dateComponents.hour = 7
        let ed4 = Calendar.current.date(from: dateComponents)!
        tasks.append(Task(name: "Task 4", startDate: sd4, endDate: ed4))

        // task 5
        dateComponents.hour = 5
        let sd5 = Calendar.current.date(from: dateComponents)!
        dateComponents.hour = 7
        let ed5 = Calendar.current.date(from: dateComponents)!
        tasks.append(Task(name: "Task 5", startDate: sd5, endDate: ed5))

        // task 6
        dateComponents.day = 2
        dateComponents.hour = 6
        let sd6 = Calendar.current.date(from: dateComponents)!
        dateComponents.hour = 7
        let ed6 = Calendar.current.date(from: dateComponents)!
        tasks.append(Task(name: "Task 6", startDate: sd6, endDate: ed6))

    }
}
