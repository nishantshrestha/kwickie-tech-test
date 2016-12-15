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
import JGProgressHUD

class KwickiesController: UITableViewController {

    var user: User?
    
    // Variables to keep track of "infinite" scrolling
    var currentOffset: Int = 0
    var responseLimit: Int = 15
    
    var kwickies: [Kwickie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the navigation title
        navigationItem.title = "Approved Kwickies"
        
        // Set up dynamic cell resizing
        tableView.estimatedRowHeight = 194.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // remove blank cells from tableview
        tableView.tableFooterView = UIView()
        
        if let user = user {
            // Get kwickie videos
            // TODO: Architecture decision: Fetch videos here; or prior to coming to this controller.
            
            // Create the params for the Kwickies fetch network request
            let params: Parameters = [
                "offset": currentOffset,
                "limit": responseLimit
            ]
            
            // Create progressHUD
            let progressHUD = JGProgressHUD()
            progressHUD.textLabel.text = "Fetching kwickies..."
            progressHUD.show(in: view)
            
            // Fetch approved Kwickies
            getApprovedKwickiesWithParameters(params: params, completionHandler: { [weak self] (kwickies) in
                
                // Dismiss progressHUD
                progressHUD.dismiss()
                                
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "kwickieCell", for: indexPath) as? KwickieCell, let kwickie = kwickies?[indexPath.row] {
            // Pass the relevant kwickie information to the cell
            cell.kwickie = kwickie
            // Return cell
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect tableview
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Get which Kwickie relating to the selected cell
        if let kwickie = kwickies?[indexPath.row] {
            // Go to the KwickieDetailsController
        }
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
