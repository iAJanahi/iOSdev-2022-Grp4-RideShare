//
//  SplashViewController.swift
//  RYDE
//
//  Created by iOSdev on 14/12/2022.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.performSegue(withIdentifier: "Launch", sender: nil)
        }
    }
    

   

}
