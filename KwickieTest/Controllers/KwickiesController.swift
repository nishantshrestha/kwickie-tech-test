//
//  KwickiesController.swift
//  KwickieTest
//
//  Created by Nishant Shrestha on 14/12/16.
//  Copyright © 2016 Nishant Shrestha. All rights reserved.
//

import UIKit

class KwickiesController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}


// MARK: Tableview datasource and delegate extension
extension KwickiesController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Hello world: \(indexPath.row)"
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
