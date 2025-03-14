//
//  ViewController.swift
//  Practical 6
//
//  Created by MAD2 on 26/11/18.
//  Copyright © 2018 MAD2. All rights reserved.
//

import UIKit
import QRCode

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
        
        let qrcode = QRCode("Hello World")
        imageView.image = qrcode!.image
    }




}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
