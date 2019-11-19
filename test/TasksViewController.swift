//
//  TasksViewController.swift
//  test
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 09/10/19.
//  Copyright © 2019 AppleInc. All rights reserved.
//

import UIKit
import Foundation

class TasksViewController: UIViewController, DismissManager {

    var currentDate = Date()
    let cellID = "cell"
    let segueID = "show"
    var tasks = [Task]()
    @IBOutlet weak var tasksTableView: UITableView!
    @IBOutlet weak var amountLabel: UILabel!
    
    func vcDismissed() {
        updateTasks()
        tasksTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tasksTableView.delegate = self
        tasksTableView.dataSource = self

        updateTasks()
    }
    
    func updateTasks() {
        tasks = TasksSingleton.shared.tasks.filter({
            var dateComponents = DateComponents()
            dateComponents.year = Calendar.current.component(.year, from: $0.startDate)
            dateComponents.month = Calendar.current.component(.month, from: $0.startDate)
            dateComponents.day = Calendar.current.component(.day, from: $0.startDate)
            
            return Calendar.current.component(.year, from: self.currentDate) == dateComponents.year && Calendar.current.component(.month, from: self.currentDate) == dateComponents.month && Calendar.current.component(.day, from: self.currentDate) == dateComponents.day
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async { self.tasksTableView.reloadData() }
    }

    @IBAction func didTouchAddTask(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: segueID, sender: nil)
    }

    @IBAction func didTouchBestSolution(_ sender: UIButton) {
        amountLabel.text = "\(amountLabel.text ?? "Total amount:") \(weightedIntervalScheduling())"
    }

    func weightedIntervalScheduling() -> Double {
        var _tasks = tasks
        print(tasks.map({ $0.weight }))

        // Initialize V
        var v: [Double] = [0]
        for i in 1 ... _tasks.count { v.append(_tasks[i - 1].weight) }
        print("V: \(v)")

        // Initialize P
        var p: [Int] = [0]
        for i in 1 ... _tasks.count {
            let currentTask = _tasks[i - 1]
            if let task = _tasks.filter({ $0.endDate < currentTask.startDate }).sorted(by: { $0.endDate > $1.endDate }).first,
                let index = _tasks.firstIndex(of: task) {
                p.append(index + 1)
            } else {
                p.append(0)
            }
        }
        print("P: \(p)")

        // Initialize P
        var m: [Double] = [0]
        for i in 1 ... _tasks.count {
            m.append(max(v[i] + m[p[i]], m[i - 1]))
        }
        print("M: \(m)")

        // Get solution
        var solution: [Int] = []
        func findSolution(_ j: Int){
            if j == 0 {
                return
            } else if v[j] + m[p[j]] > m[j - 1] {
                solution.append(j - 1)
                findSolution(p[j])
            } else {
                findSolution(j - 1)
            }
        }
        findSolution(_tasks.count)
        print(solution)

        // Update UI with new solution
        for i in 0 ..< _tasks.count {
            _tasks[i].selected = solution.contains(i) ? true : false
        }
        tasks = _tasks
        DispatchQueue.main.async { self.tasksTableView.reloadData() }

        return m[_tasks.count]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID, let _viewController = segue.destination as? CreateTaskViewController {
            _viewController.currentDate = currentDate
            _viewController.dismissManager = self
        } else {
            tasksTableView.reloadData()
        }
    }
}
    
extension TasksViewController: UITableViewDelegate { }
extension TasksViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)

        let task = tasks[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        cell.textLabel?.numberOfLines = 5
        cell.textLabel?.text = "Name: \(task.name) - Start: \(dateFormatter.string(from: task.startDate)) - End: \(dateFormatter.string(from: task.endDate)) - Weight: \(task.weight)"
        cell.textLabel?.textColor = task.selected ? .green : .red

        return cell
    }
}
