//
//  OrderStatusTableViewCell.swift
//  Food Delivery App
//
//  Created by IND040101154 on 07/07/23.
//

import UIKit

class OrderStatusTableViewCell: UITableViewCell {
    static let identifier = "OrderStatusTableViewCell"

    @IBOutlet weak var orderDescriptionLabel: UILabel!
    @IBOutlet weak var orderStatusLabel: UILabel!
    @IBOutlet weak var orderStatusimageview: UIImageView!
    @IBOutlet weak var imageBackgroundView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
