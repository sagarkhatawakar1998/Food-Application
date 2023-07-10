

import UIKit
import SDWebImage

class HomeDetailViewController: UIViewController {
    var dishe: Dishes?
    @IBOutlet weak var dishImagewView: UIImageView!
    @IBOutlet weak var placeOrderButton: UIButton!
    @IBOutlet weak var foodDescriptionLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        let intvalue = Int(sender.value)
        if intvalue > 2, let dish = dishe {
            stepper.value = 2
            openAlert(title: "Alert", message: "\(dish.name) is out of stock", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        }
        else {
            valueLbl.text = intvalue.description
        }
    }

    @IBAction func didTapPlaceOrder(_ sender: Any) {
        if stepper.value == 0 {
            openAlert(title: "Alert", message: "Please add a item", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        }
        else {
            navigationController?.popViewController(animated: true)

        }
    }
    
}

// MARK: - Private function
extension HomeDetailViewController {
    // updte the data for UI
    private func updateData() {
        guard let dishe = dishe, let url = URL(string: dishe.image) else {
            return
        }
        
        dishImagewView.sd_setImage(with: url)
        foodDescriptionLbl.text = dishe.description
        placeOrderButton.layer.masksToBounds = true
        placeOrderButton.layer.cornerRadius = 8
        title = dishe.name
        stepper.autorepeat = true
        stepper.isContinuous = true
        valueLbl.text = Int(stepper.value).description
        stepper.maximumValue = 3
        stepper.minimumValue = 0
    }
}
