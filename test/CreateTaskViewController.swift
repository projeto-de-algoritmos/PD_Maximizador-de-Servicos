//
//  CreateTaskViewController.swift
//  test
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 09/10/19.
//  Copyright © 2019 AppleInc. All rights reserved.
//

import UIKit

class CreateTaskViewController: UIViewController {

    // MARK: - Properties
    var currentDate = Date()
    var dismissManager: DismissManager?

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        taskNameTxtField.delegate = self
        taskWeightTxtField.delegate = self
        startDateDatePicker.date = currentDate
        endDateDatePicker.date = currentDate
    }

    // MARK: - Outlets
    @IBOutlet var taskNameTxtField: UITextField!
    @IBOutlet var startDateDatePicker: UIDatePicker!
    @IBOutlet var endDateDatePicker: UIDatePicker!
    @IBOutlet weak var taskWeightTxtField: UITextField!

    // MARK: - Actions
    @IBAction func didTouchCreateTask(_ sender: UIButton) {

        let taskName = taskNameTxtField.text?.isEmpty ?? true ? "Empty" : taskNameTxtField.text!
        let startDate = startDateDatePicker.date
        let endDate = endDateDatePicker.date
        let taskWeight: Double = taskWeightTxtField.text?.isEmpty ?? true ? 20.0 : Double(taskWeightTxtField.text!)!

        let task = Task(name: taskName, startDate: startDate, endDate: endDate, weight: taskWeight)

        TasksSingleton.shared.tasks.append(task)
        TasksSingleton.shared.tasks.forEach({ print($0) })

        dismiss(animated: true)
        self.dismissManager?.vcDismissed()
    }
}

extension CreateTaskViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
