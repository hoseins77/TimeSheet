//
//  DialogController.swift
//  TimeSheet
//
//  Created by Hossein Safaie on 11/15/1397 AP.
//

import WatchKit

class DialogController: UIViewController {
    
    public static var isCheckIn = false
    
    @IBOutlet weak var containerView1: UIView!{
        didSet {
            containerView1.layer.cornerRadius = 12
            containerView1.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            containerView1.layer.shadowOffset = CGSize(width: 0, height: 6)
            containerView1.layer.shadowRadius = 20
            containerView1.layer.shadowOpacity = 0.16
            
        }
    }
    @IBOutlet weak var btnClose: UIButton! {
        didSet {
            btnClose.layer.cornerRadius = 21
            btnClose.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            btnClose.layer.shadowOffset = CGSize(width: 0, height: 6)
            btnClose.layer.shadowRadius = 20
            btnClose.layer.shadowOpacity = 0.16
        }
    }
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblMessage1: UILabel!
    @IBOutlet weak var lblMessage2: UILabel!

    override func viewDidLoad() {
        if DialogController.isCheckIn {
            setForCheckIn()
        } else {
            setForCheckOut()
        }
        
        self.view.alpha = 0
        containerView1.transform = .init(translationX: 0, y: -300)
        
        UIView.animate(withDuration: 0.7) {
            self.view.alpha = 1
            self.containerView1.transform = .identity
        }
    }
    
    @IBAction func closeClick(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func setForCheckIn() {
        imgIcon.image = UIImage(named: "voorood")
        lblMessage1.text = "ورود شما ثبت شد!"
        lblMessage2.text = "دیروز همش نشسته بودیا (;"
        self.view.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.8235294118, blue: 0.6470588235, alpha: 1)
    }
    
    func setForCheckOut() {
        imgIcon.image = UIImage(named: "khrooj")
        lblMessage1.text = "خروج شما ثبت شد!"
        lblMessage2.text = "فردا با انرژی بیشتر :)"
        self.view.backgroundColor = #colorLiteral(red: 1, green: 0.3764705882, blue: 0.7490196078, alpha: 1)
    }
    
    @IBAction func dismis(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
