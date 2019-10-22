//
//  CreateTaskViewController.swift
//  test
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 09/10/19.
//  Copyright © 2019 AppleInc. All rights reserved.
//

import UIKit

class CreateTaskViewController: UIViewController {

    var currentDate = Date()
    var dismissManager: DismissManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        startDateDatePicker.date = currentDate
        endDateDatePicker.date = currentDate
    }

    @IBOutlet var taskNameTxtField: UITextField!
    @IBOutlet var startDateDatePicker: UIDatePicker!
    @IBOutlet var endDateDatePicker: UIDatePicker!

    @IBAction func didTouchCreateTask(_ sender: UIButton) {

        let taskName = taskNameTxtField.text?.isEmpty ?? true ? "Vazio" : taskNameTxtField.text!
        let startDate = startDateDatePicker.date
        let endDate = endDateDatePicker.date

        let task = Task(name: taskName, startDate: startDate, endDate: endDate)

        TasksSingleton.shared.tasks.append(task)
        TasksSingleton.shared.tasks.forEach({ print($0) })

        dismiss(animated: true)
        self.dismissManager?.vcDismissed()
    }
}
