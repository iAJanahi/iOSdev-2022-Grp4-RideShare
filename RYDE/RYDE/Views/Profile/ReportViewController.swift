//
//  ReportViewController.swift
//  RYDE
//
//  Created by iOSdev on 13/12/2022.
//

import UIKit


class ReportViewController: UIViewController {
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var reportField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func reportButton(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Missing field data", message: "Please enter your contact information" ,  preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        guard let phone1 = phoneField.text, !phone1.isEmpty, let email1 = emailField.text, !email1.isEmpty, let report = reportField.text, !report.isEmpty else {
            
            print("Missing Field data")
            self.present(alert, animated: true)
            
            return
        }
        
        self.dismiss(animated: true)
        
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
