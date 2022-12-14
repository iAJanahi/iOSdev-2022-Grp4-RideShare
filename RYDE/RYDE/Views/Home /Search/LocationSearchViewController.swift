//
//  LocationSearchViewController.swift
//  RYDE
//
//  Created by iOSdev on 05/12/2022.
//

import UIKit

protocol getSelectedLocation {
    func changeFromLocation(loc: String)
    func changeToLocation(loc: String)
}

class LocationSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
        
    // MARK: Search page outlets
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var locationsTableView: UITableView!
    
    // MARK: Search page variables
    var delegate: getSelectedLocation?
    var searching: Bool = false
    var fromOrTo = ""

    
    // MARK: Search page data
    let DataDemo =  [
        Section(type: "Known Places", location: ["- CurrentLocation -", "University of Bahrain", "Polytechnic", "Manama Souq", "Muharraq Souq", "City Centre"]),
        Section(type: "Cities/Towns", location: ["Muharraq", "Galali", "Madinat Isa", "Busaiteen", "AlHidd", "AlDair", "Samaheej", "Diyar AlMuharraq", "Zallaq", "Manama"])
    ]
    
    
    // Filtered data to show on search
    var filteredData = [Section]()
    var filteredLocations = [String]()
    var chosenLocation = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Table configuration
        locationsTableView.delegate = self
        locationsTableView.dataSource = self
        searchBar.delegate = self
        
        filteredData = DataDemo

    }

    

    // MARK: Search table section and rows setup
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DataDemo.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return DataDemo[section].type
    }
    
    
    // Setting up the table rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData[section].location.count
    }
    
    // Setting up the table's data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = locationsTableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        // Configure content
//        content.text = DataDemo[indexPath.section].location[indexPath.row]
        content.text = filteredData[indexPath.section].location[indexPath.row]
//        content.text = filteredLocations[indexPath.row]
        cell.contentConfiguration = content
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(filteredData[indexPath.section].location[indexPath.row])
        chosenLocation = filteredData[indexPath.section].location[indexPath.row]
        if fromOrTo == "from" {
            delegate?.changeFromLocation(loc: chosenLocation)
            self.dismiss(animated: true)
        }
        else if fromOrTo == "to" {
            delegate?.changeToLocation(loc: chosenLocation)
            self.dismiss(animated: true)
        }
        else {
            fatalError("Unknown segue source!")
        }
    }
    
    
    
    
    // MARK: Implementing search table
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchBar.showsCancelButton = true
        
        // If there is no text, filteredData is the same. If user enters text, filter changes based on text. For each item return true if it's included and false if not.
        if searchText.isEmpty {
            searching = false
            filteredData = DataDemo
        }
        else {
            for i in 0...DataDemo.count-1 {
                filteredData[i].location = DataDemo[i].location.filter({
                    (loc:String)  -> Bool in
                    //                    print(loc)
                    return loc.range(of: searchText, options: .caseInsensitive, range: nil) != nil
                })
            }
            
        }
        
        locationsTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

}
