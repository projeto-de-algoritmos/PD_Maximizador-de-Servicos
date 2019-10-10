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

    override func viewDidLoad() {
        super.viewDidLoad()

        tasksTableView.delegate = self
        tasksTableView.dataSource = self

        tasks = TasksSingleton.shared.tasks.filter({ _ in
            var dateComponents = DateComponents()
            dateComponents.year = Calendar.current.component(.year, from: self.currentDate)
            dateComponents.month = Calendar.current.component(.month, from: self.currentDate)
            dateComponents.day = Calendar.current.component(.day, from: self.currentDate)

            return Calendar.current.component(.year, from: self.currentDate) == dateComponents.year && Calendar.current.component(.month, from: self.currentDate) == dateComponents.month && Calendar.current.component(.day, from: self.currentDate) == dateComponents.day
        })
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

    }
}

extension TasksViewController: UITableViewDelegate { }
extension TasksViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)

        cell.textLabel?.text = tasks[indexPath.row].name

        return cell
    }
}
