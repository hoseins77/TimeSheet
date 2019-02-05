//
//  DayCell.swift
//  TimeSheet
//
//  Created by Hossein Safaie on 11/13/1397 AP.
//

import UIKit

class DayCell: UITableViewCell {

    @IBOutlet weak var viewDay: UIView! {
        didSet {
            viewDay.layer.cornerRadius = 27.5
            viewDay.layer.shadowColor = #colorLiteral(red: 0.4117647059, green: 0.1647058824, blue: 1, alpha: 1)
            viewDay.layer.shadowOffset = CGSize(width: 0, height: 6)
            viewDay.layer.shadowRadius = 15
            viewDay.layer.shadowOpacity = 0.7
        }
    }
    @IBOutlet weak var viewContainer: UIView! {
        didSet {
            viewContainer.layer.cornerRadius = 12
            
            viewContainer.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            viewContainer.layer.shadowOffset = CGSize(width: 0, height: 6)
            viewContainer.layer.shadowRadius = 20
            viewContainer.layer.shadowOpacity = 0.16
        }
    }
    
    @IBOutlet weak var lblCheckOut: UILabel!
    @IBOutlet weak var lblCheckIn: UILabel!
    @IBOutlet weak var lblWeekDay: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    
}
