//
//  CustomInfoWindow.swift
//  GM-CustomInfoWindow-Button
//
//  Created by Marla Na on 22/03/2017.
//
//
import Foundation
import UIKit

class CustomInfoWindow: UIView {

    @IBOutlet weak var customWindowLabel: UILabel!
    
    @IBAction func press(_ sender: UIButton) {
        self.customWindowLabel.text = "You just pressed the button ! "
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func loadView() -> CustomInfoWindow{
        let customInfoWindow = Bundle.main.loadNibNamed("CustomInfoWindow", owner: self, options: nil)?[0] as! CustomInfoWindow
        return customInfoWindow
    }
}
