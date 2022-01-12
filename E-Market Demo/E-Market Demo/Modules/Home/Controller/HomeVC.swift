//
//  HomeVC.swift
//  E-Market Demo
//
//  Created by MAC on 1/12/22.
//

import UIKit

class HomeVC: UIViewController {
    
    static let identifire = "HomeVC"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var openingTimeLabel: UILabel!
    @IBOutlet weak var closingTimeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    private var networkManager = NetworkManager()
    private var vm = HomeVM()
    
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

        initView()
        initData()
        setCartBadge()
    }
    
    func initView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: ProductsCVCell.identifire, bundle: nil), forCellWithReuseIdentifier: ProductsCVCell.identifire)
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
        
        self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        vm.getProductsInfo { success, products, error in
            
            DispatchQueue.main.async {
                self.view.activityStopAnimating()
                
                if success {
                    self.collectionView.reloadData()
                } else {
                    self.alert(message: self.vm.errorMessage, title: self.vm.errorTitle)
                }
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


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return vm.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCVCell.identifire, for: indexPath) as? ProductsCVCell {
            
            cell.loadData(products: vm.products[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 10) / 2
        let height = width
        
        return CGSize(width: width, height: height)
    }
}
