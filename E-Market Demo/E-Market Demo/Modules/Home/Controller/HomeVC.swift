//
//  HomeVC.swift
//  E-Market Demo
//
//  Created by MAC on 1/12/22.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var openingTimeLabel: UILabel!
    @IBOutlet weak var closingTimeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    private var networkManager = NetworkManager()
    private var totalCart = 0 {
        
        willSet {
            print("totalCart newValue : ",newValue)
        }
        
        didSet {
            print("totalCart oldValue: ",oldValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initData()
        setCartBadge()
    }
    
    func initData() {
        self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        networkManager.getStoreInfo { storeInfo, error in
            
            DispatchQueue.main.async {
                self.view.activityStopAnimating()
                
                if let error = error {
                    self.alert(message: error.description, title: "Error")
                }
                
                guard let storeInfo = storeInfo else {
                    return
                }
                
                self.storeNameLabel.text = "\(storeInfo.name ?? "No name provided")"
                self.openingTimeLabel.text = "Opening Time : \( storeInfo.openingTime ?? "no time provided")"
                self.closingTimeLabel.text = "Closing Time : \( storeInfo.closingTime ?? "no time provided")"
                self.ratingLabel.text = "Rating : \( storeInfo.rating ?? 0.0)"
            }
        }
    }
    
    func setCartBadge() {
        if let tabItems = tabBarController?.tabBar.items {
            // In this case we want to modify the badge number of the second tab
            let tabItem = tabItems[1]
//            tabItem.badgeValue = "10"
            tabItem.badgeValue = nil
        }
    }

}
