//
//  OrderItemTableViewCell.swift

import UIKit

class OrderItemTableViewCell: UITableViewCell {
    static let identifier = "OrderItemTableViewCell"
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var numberOfItems: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        mealImage.layer.masksToBounds = true
        mealImage.layer.cornerRadius = 20
    }
    
    //update cell with data
    func setUpWith(with item: OrderDetailItem) {
        mealName.text = item.dish.name
        numberOfItems.text = "Quantiy: \(item.noOfitems)"
        if let url = URL(string: item.dish.image) {
            mealImage.sd_setImage(with: url)
        }
    }
    
}
