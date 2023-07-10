

import UIKit

enum AssetsColor: String {
    case generalScreenBackgroundColor
    case buttonBackgroundColor
    case otherLabelColour
    case titleLabelColour
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
}

let foodlyPurple = UIColor.appColor(.buttonBackgroundColor)
let backgroundColor = UIColor.appColor(.generalScreenBackgroundColor)
let labelColor = UIColor.appColor(.otherLabelColour)
let titleTextColor = UIColor.appColor(.titleLabelColour)
