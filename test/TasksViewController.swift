//
//  TasksViewController.swift
//  test
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 09/10/19.
//  Copyright © 2019 AppleInc. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {

    var currentDate = Date()
    let cellID = "cell"
    let segueID = "show"
    var tasks = [Task]()
    @IBOutlet weak var tasksTableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var employeesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tasksTableView.delegate = self
        tasksTableView.dataSource = self

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueID, let _viewController = segue.destination as? CreateTaskViewController {
            _viewController.currentDate = currentDate
        }
    }
    
    @IBAction func segmentedControlDidChangeValue(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            intervalScheduling()
            employeesLabel.isHidden = true
        } else {
            intervalPartitioning()
            employeesLabel.isHidden = false
        }
    }

    func intervalPartitioning() {
        
    }

    func intervalScheduling() {
        var tasksByEarliestFinishTime = tasks.sorted(by: { return $0.endDate < $1.endDate })
        for index in tasksByEarliestFinishTime.indices {
            tasksByEarliestFinishTime[index].selected = false
        }
        var selectedTasks = [Task]()
        for var task in tasksByEarliestFinishTime {

            if selectedTasks.isEmpty {
                task.selected = true
                selectedTasks.append(task)
                continue
            } else {
                var aux = true
                for t in selectedTasks {
                    guard task != t else { continue }
                    if (task.startDate >= t.startDate && task.startDate < t.endDate) {
                        aux = false
                    }
                }
                if aux {
                    task.selected = true
                    selectedTasks.append(task)
                }
            }
        }

        for task in tasksByEarliestFinishTime {
            if !selectedTasks.contains(task) {
                selectedTasks.append(task)
            }
        }

        tasks.removeAll()
        tasks = selectedTasks
        DispatchQueue.main.async { self.tasksTableView.reloadData() }
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
        dateFormatter.dateFormat = "hh:mm"
        cell.textLabel?.text = "Name: \(task.name) - Start: \(dateFormatter.string(from: task.startDate)) - End: \(dateFormatter.string(from: task.endDate))"
        cell.textLabel?.textColor = task.selected ? .green : .red

        return cell
    }
}
