//
//  PassengerNoViewController.swift
//  RYDE
//
//  Created by iOSdev on 13/12/2022.
//

import UIKit

class PassengerNoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var passengers = ["Ahmed Ali","Mike Ali","Zahraa Qassim"]
    
    @IBOutlet weak var myPass: UITableView!
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        
            super.didReceiveMemoryWarning()
        
    }
//    func loadData() {
//         cell.append(passengers)
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passengers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPassengers", for: indexPath)
        let passenger = passengers[indexPath.row]
        cell.textLabel?.text = passenger
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, numberOfSectionInTableView section: Int) -> Int {
    return 1
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
