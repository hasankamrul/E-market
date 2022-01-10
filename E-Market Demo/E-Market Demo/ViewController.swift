//
//  ViewController.swift
//  E-Market Demo
//
//  Created by MAC on 1/3/22.
//

import UIKit

class ViewController: UIViewController {

    private var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        networkManager.getStoreInfo { data, error in
            print("data : ",data)
        }
        
        networkManager.getProducts { products, error in
            print("products : ",products?[0])
            print("error : ",error)
        }
        
        var products: [Product] = [Product]()
        products.append(Product(name: "Latte", price: 50, imageURL: "https://www.nespresso.com/ncp/res/uploads/recipes/nespresso-recipes-Latte-Art-Tulip.jpg"))
        
        networkManager.crateOrder(order: Order(products: products, deliveryAddress: "CDC O4 Office, Bangkapi, Bangkok, 10310")) { success, error in
            print("success : ",success)
        }
    }


}

