//
//  ViewController.swift
//  hwsproject7
//
//  Created by Enrique Florencio on 3/27/19.
//  Copyright © 2019 Enrique Florencio. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    //Make an array of petition objects
    var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initialize the url
        let urlString : String
        
        //Checks the tabBarItem tag
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }
        
        //Checks to see if the url is valid
        if let url = URL(string: urlString) {
            //Use the data object to return the content of a url
            if let data = try? Data(contentsOf: url) {
                //Parse the data
                parse(json: data)
                return
            }
        }
        
        showError()
    }
    
    //Function to show errors
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    
    //Function to parse the data given from the url using decodable
    func parse(json: Data) {
        //New instance of JSONDecoder which is dedicated to converting between json and codable objects
        let decoder = JSONDecoder()
        
        //decoder tries to convert json data into a Petitions objects. (try?) used to check if it worked
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            //if it worked then assign the results array to our petitions property and reload the tableview.
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    //Defines number of cells in the tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    //Defines what gets put in those cells inside the tableview
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    


}

