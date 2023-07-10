

import UIKit
import SDWebImage

class RestaurantsTableViewCell: UITableViewCell {
    static let identifier = "RestaurantsTableViewCell"
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    
    //update cell with data
    func setup(with dish: Dishes) {
        restaurantImage.sd_setImage(with: URL(string: dish.image))
        restaurantName.text = dish.name
        mealName.text = dish.resturnatNames
        discountLabel.text = "₹\(dish.calories)"
    }
}
