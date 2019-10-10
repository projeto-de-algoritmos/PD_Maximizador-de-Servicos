//
//  ViewController.swift
//  Greedy
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 09/10/19.
//  Copyright © 2019 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//

import UIKit
import JTAppleCalendar

class ViewController: UIViewController {

    let cellID = "dateCell"

    @IBOutlet weak var calendarCollectionView: JTACMonthView!

    override func viewDidLoad() {
        super.viewDidLoad()

        calendarCollectionView.calendarDataSource = self
        calendarCollectionView.calendarDelegate = self
        calendarCollectionView.scrollingMode = .stopAtEachCalendarFrame

    }

    func configureCell(view: JTACDayCell?, cellState: CellState) {
        guard let cell = view as? DateCollectionViewCell else { return }
        cell.dateLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
    }

    func handleCellTextColor(cell: DateCollectionViewCell, cellState: CellState) {
       if cellState.dateBelongsTo == .thisMonth {
          cell.dateLabel.textColor = UIColor.white
       } else {
          cell.dateLabel.textColor = UIColor.gray
       }
    }

}

extension ViewController: JTACMonthViewDataSource {
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {

        let formatter = DateFormatter()
        formatter.dateFormat = "dd MM yyyy"
        guard let startDate = formatter.date(from: "01 01 2019") else { preconditionFailure() }
        let endDate = Date()
        return ConfigurationParameters(startDate: startDate, endDate: endDate, generateInDates: .forAllMonths, generateOutDates: .tillEndOfGrid)
    }
}

extension ViewController: JTACMonthViewDelegate {
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }

    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {

        guard let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: cellID, for: indexPath) as? DateCollectionViewCell else { return JTACDayCell() }

        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }



}
