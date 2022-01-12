//
//  ProductsCVCell.swift
//  E-Market Demo
//
//  Created by MAC on 1/13/22.
//

import UIKit
import Kingfisher

class ProductsCVCell: UICollectionViewCell {
    
    static let identifire = "ProductsCVCell"

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private var vm = HomeVM()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadData(products: Product) {

//        productImage.image = UIImage(named: products.imageURL)
        let url = URL(string: products.imageURL ?? "")
        productImage.kf.setImage(with: url)
        nameLabel.text = "  \(products.name ?? "")"
        priceLabel.text = "  \(products.price ?? 0.0)"
    }

}
