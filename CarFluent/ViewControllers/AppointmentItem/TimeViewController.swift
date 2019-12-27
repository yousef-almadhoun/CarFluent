//
//  TimeViewController.swift
//  CarFluent
//
//  Created by mac on 11/13/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import HGCircularSlider

class TimeViewController: UIViewController {
    
    @IBOutlet weak var lblToTime: UILabel!
    
    @IBOutlet weak var lblFormTime: UILabel!
    
    @IBOutlet weak var lblToDate: UILabel!
    
    @IBOutlet weak var lblFromDate: UILabel!
    
    @IBOutlet weak var slider: RangeCircularSlider!
    
    @IBOutlet weak var lblTime: UILabel!
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter
    }()
    
    var timeSelected: String?
    
    enum toggleButtonActive {
        case toTime
        case fromTime
    }
    
    var activeButton: toggleButtonActive = .toTime {
        didSet {
            self.toggleButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        fetchData()
    }
    
    @IBAction func btnToTime(_ sender: Any) {
        self.activeButton = .toTime
    }
    
    @IBAction func btnFromTime(_ sender: Any) {
        self.activeButton = .fromTime
    }
    
    @IBAction func btnSelectTime(_ sender: AnyObject) {
        adjustValue(value: &slider.startPointValue)
        slider.endPointValue = slider.startPointValue
        let time = TimeInterval(slider.startPointValue)
        let timeDate = Date(timeIntervalSinceReferenceDate: time)
        lblTime.text = dateFormatter.string(from: timeDate)
        timeSelected = dateFormatter.string(from: timeDate)
    }

    @IBAction func btnOkey(_ sender: Any) {
        guard let time = timeSelected else {
            showAlertError(message: "Pleace Enter The Reservation Time")
            return
        }
        if let parent = self.parent as? AppointmentViewController {
            switch self.activeButton {
            case .toTime:
                lblToTime.text = time
                parent.timeTo = lblToTime.text
                self.activeButton = .fromTime
                break
            case .fromTime:
                lblFormTime.text = time
                parent.timeFrom = lblFormTime.text
                break
            }
        }
    }
}

extension TimeViewController {
    
    func setupView() {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "AppointmentViewController") as! AppointmentViewController
        lblToDate.text = vc.dateTo
        lblFromDate.text = vc.dateFrom
        self.activeButton = .toTime
        // setup O'clock
        let dayInSeconds = 24 * 60 * 60
        slider.maximumValue = CGFloat(dayInSeconds)
        btnSelectTime(slider)
    }
    
    func localized() {
        
    }
    
    func setupData() {
        
    }
    
    func fetchData() {
        
    }
    
}

extension TimeViewController {
    func toggleButton() {
        switch self.activeButton {
        case .toTime:
            lblToTime.backgroundColor = "#FFB02B".color_
            lblToTime.textColor = .hexColor(hex: "#FFFFFF")
            lblFormTime.backgroundColor = "#D2D2D2".color_
            lblFormTime.textColor = .hexColor(hex: "#979797")
            break
        case .fromTime:
            lblToTime.backgroundColor = "#D2D2D2".color_
            lblToTime.textColor = .hexColor(hex: "#979797")
            lblFormTime.backgroundColor = "#FFB02B".color_
            lblFormTime.textColor = .hexColor(hex: "#FFFFFF")
            break
        }
    }
}

extension TimeViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "\u{f017}")
    }
}

extension TimeViewController {
    func adjustValue(value: inout CGFloat) {
        let minutes = value / 60
        let adjustedMinutes =  ceil(minutes / 5.0) * 5
        value = adjustedMinutes * 60
    }
}
