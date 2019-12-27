//
//  DateViewController.swift
//  CarFluent
//
//  Created by mac on 11/13/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import FSCalendar

class DateViewController: UIViewController {

    @IBOutlet weak var lblToDate: UILabel!
    
    @IBOutlet weak var lblFormDate: UILabel!
    
    @IBOutlet weak var calendar: FSCalendar!
    
    enum toggleButtonActive {
        case toDate
        case fromDate
    }
    
    var activeButton: toggleButtonActive = .toDate {
        didSet {
            self.toggleButton()
        }
    }
    
    var calendarDate = Calendar.current
    var components: DateComponents?
    var year: Int?
    var month: Int?
    var dateSelected: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        fetchData()
    }
    
    @IBAction func btnBackMonth(_ sender: Any) {
        calendarGoToForwardOrBack(type: "back")
    }
    
    @IBAction func btnForwardMonth(_ sender: Any) {
        calendarGoToForwardOrBack(type: "forward")
    }
    
    @IBAction func btnToDate(_ sender: Any) {
        self.activeButton = .toDate
    }
    
    @IBAction func btnFromDate(_ sender: Any) {
        self.activeButton = .fromDate
    }
    
    @IBAction func btnOkey(_ sender: Any) {
        
        guard let date = dateSelected else {
            showAlertError(message: "Pleace Enter The Reservation Date")
            return
        }
        
        guard date.toDate(customFormat: "dd MMM.yyyy") > "".toDate(customFormat: "dd MMM.yyyy") else {
            showAlertError(message: "date is error")
            return
        }
        
        if let parent = self.parent as? AppointmentViewController {
            switch self.activeButton {
            case .toDate:
                lblToDate.text = "\(date)"
                parent.dateTo = lblToDate.text
                self.activeButton = .fromDate
                break
            case .fromDate:
                lblFormDate.text = "\(date)"
                parent.dateFrom = lblFormDate.text
                break
            }
        }
    }
    
}

extension DateViewController {
    
    func setupView() {
        self.activeButton = .toDate
        calendar.setNeedsLayout()
        calendar.layoutIfNeeded()
        components = calendarDate.dateComponents([.year, .month], from: calendar.currentPage)
        year =  components?.year
        month = components?.month
    }
    
    func localized() {
        
    }
    
    func setupData() {
        
    }
    
    func fetchData() {
        
    }
    
}

extension DateViewController {
    func toggleButton() {
        switch self.activeButton {
        case .toDate:
            lblToDate.backgroundColor = "#FFB02B".color_
            lblToDate.textColor = .hexColor(hex: "#FFFFFF")
            lblFormDate.backgroundColor = "#D2D2D2".color_
            lblFormDate.textColor = .hexColor(hex: "#979797")
            break
        case .fromDate:
            lblToDate.backgroundColor = "#D2D2D2".color_
            lblToDate.textColor = .hexColor(hex: "#979797")
            lblFormDate.backgroundColor = "#FFB02B".color_
            lblFormDate.textColor = .hexColor(hex: "#FFFFFF")
            break
        }
    }
}

extension DateViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        components = calendarDate.dateComponents([.year, .month], from: calendar.currentPage)
        year =  components?.year
        month = components?.month
    }
    
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        dateSelected = date.toString(customFormat: "dd MMM.yyyy")
   }
}

extension DateViewController {
    func calendarGoToForwardOrBack(type: String) {
        if var yearM = year, var monthM = month {
            if type == "forward" {
                if (month ?? 1) >= 12 {
                    month = 1
                    year = (year ?? 2010) + 1
                } else {
                    month = (month ?? 1) + 1
                    
                }
            } else if type == "back" {
                if (month ?? 1) <= 1 {
                    month = 12
                    year = (year ?? 2010) - 1
                } else {
                    month = (month ?? 1) - 1
                }
            }
            
            yearM = year ?? 2010
            monthM = month ?? 1
            let date = "\(yearM)-\(monthM)".toDate(customFormat: "yyyy-MM")
            calendar.setCurrentPage(date, animated: true)
        }
    }
}

extension DateViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "\u{f073}")
    }
}
