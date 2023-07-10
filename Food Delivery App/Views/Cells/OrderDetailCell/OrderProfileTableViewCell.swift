

import UIKit

class OrderProfileTableViewCell: UITableViewCell {
    static let identifier = "OrderProfileTableViewCell"

    @IBOutlet weak var gmailLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
    
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setupData() {
        gmailLabel.text = UserDefaults.standard.string(forKey: "email")
        nameLabel.text = UserDefaults.standard.string(forKey: "personname")
        guard let imageData = UserDefaults.standard.data(forKey: "userimage") else {
            return
        }
        profileImage.image = UIImage(data: imageData)
    }
}
