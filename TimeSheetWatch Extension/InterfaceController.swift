//
//  InterfaceController.swift
//  TimeSheetWatch Extension
//
//  Created by Hossein Safaie on 11/15/1397 AP.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var group: WKInterfaceGroup!
    
    @IBOutlet weak var date: WKInterfaceDate!
    @IBOutlet weak var btnCheckIn: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        date.setCalendar(Calendar(identifier: .persian))
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
