//
//  ViewController.swift
//  TimeSheet
//
//  Created by Hossein Safaie on 11/9/1397 AP.
//

import UIKit
import CoreData
import UserNotifications

class MainController: UIViewController {

    @IBOutlet weak var checkInButton: UIButton! {
        didSet {
            checkInButton.layer.cornerRadius = checkInButton.frame.height / 2
            checkInButton.layer.shadowColor = #colorLiteral(red: 0.2470588235, green: 0.8235294118, blue: 0.6470588235, alpha: 1)
            checkInButton.layer.shadowOffset = CGSize(width: 0, height: 6)
            checkInButton.layer.shadowRadius = 20
            checkInButton.layer.shadowOpacity = 0.7
        }
    }
    @IBOutlet weak var checkOutButton: UIButton! {
        didSet {
            checkOutButton.layer.cornerRadius = checkOutButton.frame.height / 2
            checkOutButton.layer.shadowColor = #colorLiteral(red: 1, green: 0.3764705882, blue: 0.7490196078, alpha: 1)
            checkOutButton.layer.shadowOffset = CGSize(width: 0, height: 6)
            checkOutButton.layer.shadowRadius = 20
            checkOutButton.layer.shadowOpacity = 0.7
        }
    }
    
    @IBOutlet weak var tblView: UITableView!
    
    var weekDayNames = ["شنبه", "یکشنبه", "دوشنبه", "سه شنبه", "چهارشنبه", "پنجشنبه", "جمعه"]
    var monthNames = ["فروردین", "اردیبهشت", "خرداد", "تیر", "مرداد", "شهریور", "مهر", "آبان", "آذر", "دی", "بهمن", "اسفند"]
    
    var dayObjects = [DayObject]()
    
    let center = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateObjects()
        center.requestAuthorization(options: [.alert, .sound])
        { (granted, error) in
            self.addMorningNotification()
            self.addEveningNotification()
        }
    }

    @IBAction func checkInClicked(_ sender: Any) {
        saveTime(isCheckIn: true)
        generateObjects()
    }
    
    @IBAction func checkOutClicked(_ sender: Any) {
        saveTime(isCheckIn: false)
        generateObjects()
    }
    
    func addMorningNotification() {
        let content = UNMutableNotificationContent()
        content.title = "TimeSheet"
        content.body = "یادت نره ساعت ورودتو ثبت کنی"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "TimeSheetNotifications"
        
        var date = DateComponents()
        date.hour = 8
        date.minute = 30
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let identifier = "timeSheetMorningNotify"
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: trigger)
        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                // Something went wrong
            }
        })
    }
    
    func addEveningNotification() {
        let content = UNMutableNotificationContent()
        content.title = "TimeSheet"
        content.body = "نمیخوای ساعت خروجتو ثبت کنی؟"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "TimeSheetNotifications"
        
        var date = DateComponents()
        date.hour = 17
        date.minute = 15
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let identifier = "timeSheetEveningNotify"
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: trigger)
        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                // Something went wrong
            }
        })
    }

    
    func saveTime(isCheckIn: Bool) {
        
        let date = Date()
        let formatter = DateFormatter()
        let calender = Calendar(identifier: .persian)
        var dateString = ""
        var timeString = ""
        
        formatter.calendar = calender
        formatter.dateFormat = "yyyy/MM/dd"
        dateString = formatter.string(from: date)
        formatter.dateFormat = "HH:mm"
        timeString = formatter.string(from: date)
        
        if doesExists(date: dateString, isCheckIn: isCheckIn) {
            //show message
            print("Dublicate")
            return
        }
        
        if doesExists(date: dateString, isCheckIn: false) {
            //show message
            print("already exited")
            return
        }
        
        let day = Day(context: PersistenceService.context)
        day.date = dateString
        day.time = timeString
        day.weekDay = weekDayNames[calender.component(.weekday, from: date)]
        day.isCheckIn = isCheckIn
        PersistenceService.saveContext()
        
        DialogController.isCheckIn = isCheckIn
        self.performSegue(withIdentifier: "mainToDialog", sender: nil)
    }
    
    func doesExists(date: String, isCheckIn: Bool) -> Bool {
        let fetchReq: NSFetchRequest<Day> = Day.fetchRequest()
        
        do {
            let lastDay = try PersistenceService.context.fetch(fetchReq).filter({ $0.date == date && $0.isCheckIn == isCheckIn})
            
            print(lastDay)
            
            return lastDay.count > 0
            
        } catch {
            
        }
        
        return false
    }
    
    func generateObjects() {
        
        dayObjects = [DayObject]()
        
        let fetchReq: NSFetchRequest<Day> = Day.fetchRequest()
        
        do {
            let days = try PersistenceService.context.fetch(fetchReq)
            var i = 0
            while i < days.count {
                var dayObject = DayObject()
                dayObject.date = days[i].date
                dayObject.weekDay = days[i].weekDay
                if days[i].isCheckIn {
                    dayObject.checkIn = days[i].time
                    if (i + 1) != days.count{
                        if days[i].date == days[i + 1].date{
                            dayObject.checkOut = days[i + 1].time
                            i += 2
                            dayObjects.append(dayObject)
                            continue
                        }
                    }
                    i += 1
                    dayObject.checkOut = "--:--"
                } else {
                    dayObject.checkIn = "--:--"
                    dayObject.checkOut = days[i].time
                    i += 1
                }
                dayObjects.append(dayObject)
            }
            dayObjects.reverse()
            tblView.reloadData()
            
        } catch {
            
        }
    }
    
}

extension MainController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayObjects.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cell") as! DayCell
        
        cell.lblCheckIn.text = dayObjects[indexPath.row].checkIn
        cell.lblCheckOut.text = dayObjects[indexPath.row].checkOut
        cell.lblWeekDay.text = dayObjects[indexPath.row].weekDay
        
        var separatedDate = dayObjects[indexPath.row].date?.components(separatedBy: "/")
        
        cell.lblDate.text = "\(Int(separatedDate![2])!) \(monthNames[Int(separatedDate![1])! - 1])"
        
        return cell
    }
    
}

