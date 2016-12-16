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
import DZNEmptyDataSet

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
        
        // Set up empty data set delegates
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
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
    
    
    @IBAction func signOutButtonPressed(_ sender: AnyObject) {
        // TODO: Clear accessToken from user defaults.
        
        // Take user back to SignInController
        navigationController?.popToRootViewController(animated: true)
    }

}

// MARK: Empty data set methods
extension KwickiesController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let title = "Looks like there are no Kwickies yet!"
        return NSAttributedString(string: title)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let description = "Don't panic though, they'll be here soon"
        return NSAttributedString(string: description)
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
            if let playerCtrl = KwickiePlayerController.storyboardInstance() {
                // Pass the selected kwickie to the controller
                playerCtrl.kwickie = kwickie
                // Push view controller to the stack
                navigationController?.pushViewController(playerCtrl, animated: true)
                // present(playerCtrl, animated: true, completion: nil)
            }
        }
    }
    
    
}

// TODO: Implement "load more" when a user scrolls to end of the tableview
// MARK: UIScrollView Delegate Methods
extension KwickiesController {
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // Get the current offset
        let currentOffset = scrollView.contentOffset.y
        // Get the max offset
        let maxOffset = scrollView.contentSize.height - scrollView.frame.size.height // contentSize.height stores the total height of the scrollView; scrollView.frame.size.height stores the 'designated' height of the scrollView in the view hierarchy
        
        let scrollThreshold = 2 * tableView.estimatedRowHeight
        
        if maxOffset - currentOffset <= scrollThreshold {
            print("load more Kwickies!!")
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
