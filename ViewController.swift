//
//  ViewController.swift
//  Country&Capital
//
//  Created by Daniel Huang on 9/7/17.
//  Copyright © 2017 Daniel Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //an array of Country objects
    var fetchedCountries = [Country]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        parseData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //the function to manage the url request and parse the data from the url
    func parseData(){
        
        fetchedCountries = [] //an empty array initially
        let url = "https://restcountries.eu/rest/v1/all"
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "GET"  //use the default "GET" method
        
        let configuration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main )
        
        //Creates a task that retrieves the contents of the specified URL.
        let task = session.dataTask(with: request, completionHandler: { (data, response, error)in
            if error != nil{
                print("Error")
            } else {
                do {
                     let fetchedData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSArray
                    
                    //print(fetchedData) //for debugging purpose, print it to the console
                    for eachFetchedCountry in fetchedData{
                        
                        let eachCountry = eachFetchedCountry as! [String:Any]
                        
                        let country = eachCountry["name"] as! String
                        let capital = eachCountry["capital"] as! String
                        self.fetchedCountries.append(Country(country: country, capital: capital))
                    }
                    
                    print(self.fetchedCountries) //for debugging purpose
                }
                catch{
                    
                    print("Error2")
                }
                
            }
            
        })
        
        
        task.resume()
        
    }
}

