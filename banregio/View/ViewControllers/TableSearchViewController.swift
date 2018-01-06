//
//  TableSearchViewController.swift
//  Banregio
//
//  Created by Benjamin on 02/01/18.
//  Copyright © 2018 rodolfo. All rights reserved.
//

import UIKit

class TableSearchViewController: UIViewController {

    @IBOutlet weak var countryTable: UITableView!
    
    var list: [String]?
    var latitude: [Float]?
    var longitude: [Float]?
    
    var searchArray = [String]() {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name.init("searchResultsUpdated"), object: searchArray)
        }
    }
    
    var countrySearchController: UISearchController = ({
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let alternateController = storyBoard.instantiateViewController(withIdentifier: "aTV") as! AlternateTableViewController
        let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = false
        controller.dimsBackgroundDuringPresentation = false
        controller.searchBar.searchBarStyle = .minimal
        controller.searchBar.sizeToFit()
        return controller
    })()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryTable.tableHeaderView = countrySearchController.searchBar
        countrySearchController.searchResultsUpdater = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension TableSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch countrySearchController.isActive {
        case true:
            return searchArray.count
        case false:
            return (list?.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryTable.dequeueReusableCell(withIdentifier: "Cell") as! SearchTableViewCell
        cell.textLabel?.text = ""
        cell.textLabel?.attributedText = NSAttributedString(string: "")
        
        switch countrySearchController.isActive {
        case true:
            cell.configureCell(with: countrySearchController.searchBar.text!, cellText: searchArray[indexPath.row])
            return cell
        case false:
            cell.textLabel?.text! = list![indexPath.row]
            return cell
        }
    }
}

extension TableSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let busqueda = storyboard.instantiateViewController(withIdentifier: "MapaViewController") as! MapaViewController
        busqueda.status = true
        busqueda.latitudeObject = latitude![indexPath.row]
        busqueda.longitudeObject = longitude![indexPath.row]
        busqueda.nameObject = list![indexPath.row]
        self.show(busqueda, sender: self)
        
    }
}

extension TableSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text?.utf8.count == 0 {
            searchArray = list!
            countryTable.reloadData()
        } else {
            searchArray.removeAll(keepingCapacity: false)
            
            let range = searchController.searchBar.text!.startIndex ..< searchController.searchBar.text!.endIndex
            var searchString = String()
            
            searchController.searchBar.text?.enumerateSubstrings(in: range, options: .byComposedCharacterSequences, { (substring, substringRange, enclosingRange, success) in
                searchString.append(substring!)
                searchString.append("*")
            })
            
            let searchPredicate = NSPredicate(format: "SELF LIKE[cd] %@", searchString)
            let array = (list! as NSArray).filtered(using: searchPredicate)
            searchArray = array as! [String]
            countryTable.reloadData()
        }
    }
}

