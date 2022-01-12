//
//  HomeVM.swift
//  E-Market Demo
//
//  Created by MAC on 1/13/22.
//

import Foundation
import UIKit

class HomeVM {
    var networkManager = NetworkManager()
    var products = [Product]()
    var errorTitle = "Error"
    var errorMessage = ""
    
    func getProductsInfo(completion: @escaping (_ success: Bool, _ products: [Product]?,_ error: String?)->()) {
        networkManager.getProducts { products, error in
            
            if let error = error {
                self.errorMessage = error.description
                completion(false, nil, self.errorMessage)
            }
            
            self.products.removeAll()
            
            if let products = products {
                self.products = products
                completion(true, products, nil)
            }
        }
        
    }
}
