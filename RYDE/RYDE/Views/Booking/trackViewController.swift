//
//  trackViewController.swift
//  RYDE
//
//  Created by iOSdev on 08/12/2022.
//

import UIKit

class trackViewController: UIViewController {

    @IBOutlet var waitingCircle: UIImageView!
    
    @IBOutlet var circle: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //animate waiting circle
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [UIView.AnimationOptions.autoreverse, UIView.AnimationOptions.repeat], animations: {
            let bounceTransform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            //self.circle.transform = bounceTransform
            self.waitingCircle.transform = bounceTransform

            
        }, completion: {_ in

            let bounceTransform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            //self.circle.transform = bounceTransform
            self.waitingCircle.transform = bounceTransform

        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
