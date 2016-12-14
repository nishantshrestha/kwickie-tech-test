//
//  KwickiesController.swift
//  KwickieTest
//
//  Created by Nishant Shrestha on 14/12/16.
//  Copyright © 2016 Nishant Shrestha. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON

class KwickiesController: UITableViewController {

    var user: User?
    
    // Variables to keep track of "infinite" scrolling
    var currentOffset: Int = 372 // Using high offset value because "limit" does not seem to work in the API.
    var responseLimit: Int = 5
    
    var kwickies: [Kwickie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the navigation title
        navigationItem.title = "Approved Kwickies"
        
        if let user = user {
            // Get kwickie videos
            // TODO: Architecture decision: Fetch videos here; or prior to coming to this controller.
            
            // Create the params for the Kwickies fetch network request
            let params: Parameters = [
                "offset": currentOffset,
                "limit": responseLimit
            ]
            
            getApprovedKwickiesWithParameters(params: params, completionHandler: { [weak self] (kwickies) in
                print("here are the \(kwickies?.count) kwickies")
                
                // Set the kwickies variable based on the response
                self?.kwickies = kwickies
                
                // Reload the table view
                self?.tableView.reloadData()
            })
        }
    }
    
    func getApprovedKwickiesWithParameters(params: Parameters, completionHandler: @escaping ([Kwickie]?) -> Void) {
        // Make network request to fetch the approved Kwickies.
        Alamofire.request(KwickiesRouter.Approved.description, method: .get, parameters: params, encoding: URLEncoding.default)
        .validate()
        .responseArray(completionHandler: { [weak self] (response: DataResponse<[Kwickie]>) in
            switch response.result {
                case .success:
                    let kwickies = response.result.value
                    
                    // Call completion handler
                    completionHandler(kwickies)
                
                case .failure(let error):
                    print("Whoops! \(error.localizedDescription)")
                
                    // Call completion handler
                    completionHandler(nil)
                }
            
        })

    }

}


// MARK: Tableview datasource and delegate extension
extension KwickiesController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kwickies?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Kwickie for index: \(indexPath.row)"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        return cell
    }
}

// MARK: Storyboard based instantiation extension
// From Stan Ostrovskiy's Medium Post - https://medium.com/ios-os-x-development/xcode-a-better-way-to-deal-with-storyboards-8b6a8b504c06#.pa7bkv7cw
extension KwickiesController {
    static func storyboardInstance() -> KwickiesController? {
        let className = String(describing: self)
        
        let storyboard = UIStoryboard(name: className, bundle: nil)
        
        return storyboard.instantiateInitialViewController() as? KwickiesController
        
    }
}
