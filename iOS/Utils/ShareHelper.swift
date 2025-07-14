import UIKit
import SwiftUI

struct ShareHelper {
    static func share(text: String, from controller: UIViewController) {
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        controller.present(activityVC, animated: true, completion: nil)
    }
} 