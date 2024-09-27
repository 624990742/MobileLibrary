//
//  MLCustomTimePickerControllerViewController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/21.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit
import SwiftPopup
import CalendarPicker

class MLCustomTimePickerControllerViewController: SwiftPopup,CalendarPickerDelegate {

    typealias DateSelectionCallback = (Date?) -> Void
    // 新增：定义一个闭包属性，用于接收选中日期的回调
    var onDateSelected: DateSelectionCallback?
    
    @IBOutlet weak var dickperView: UIView!
    
    @IBOutlet weak var closeBtn: UIButton!
    
    var selectDate: Date?
    var calendarPicker: CalendarPicker!

    override func viewDidLoad() {
        super.viewDidLoad()

         calendarPicker = CalendarPicker()
        calendarPicker.localeType = .zh
        calendarPicker.dateFormatType = .default
        calendarPicker.delegate = self
        
        
        
        let currentDate = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentDay = calendar.component(.day, from: currentDate)

        
        let startOfYearComponents = DateComponents(year: currentYear, month: currentMonth, day: currentDay)
        let startOfYear = calendar.date(from: startOfYearComponents)!

        let endOfYearComponents = DateComponents(year: currentYear, month: 12, day: 31)
        let endOfYear = calendar.date(from: endOfYearComponents)!
        
        
        calendarPicker.minimumDate = startOfYear
        calendarPicker.maximumDate = endOfYear
    
        self.dickperView.addSubview(calendarPicker)
        calendarPicker.frame = CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 300)


    }
    
    
    func calendarPickerSelectDate(_ dateCompontnt: DateComponent) {
        self.selectDate = dateCompontnt.date
        MLDeugLog(message: "\(dateCompontnt.yearString)-\(dateCompontnt.monthString)-\(dateCompontnt.dayString)(\(dateCompontnt.week?.valueShort(self.calendarPicker.localeType) ?? ""))")
    }

    @IBAction func closeBtnAction(_ sender: UIButton) {
       dismiss()
    }
    
    
    
    @IBAction func sureBtnAction(_ sender: UIButton) {
        
        
        if self.selectDate == nil {
            MLAlert.show(type: MLAlert.AlertType.warning, text: "请选择时间")
            return
        }
        
        let currentDate = Date()
        if self.selectDate == currentDate || currentDate > self.selectDate! {
            MLAlert.show(type: MLAlert.AlertType.warning, text: "只能选择当天之后的时间")
            return
        }
        

        // 调用回调闭包，传入选中的日期
         onDateSelected?(selectDate)
        dismiss()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
