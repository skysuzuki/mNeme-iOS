//
//  PreLoginViewController.swift
//  mNeme
//
//  Created by Dennis Rudolph on 2/20/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class PreLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignUpSegue" {
            if let loginVC = segue.destination as? LoginViewController {
                loginVC.signingUp = true
            }
        } else if segue.identifier == "SignInSegue" {
            if let loginVC = segue.destination as? LoginViewController {
                loginVC.signingUp = false
            }
        }
    }
}
