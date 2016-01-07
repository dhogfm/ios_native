//
//  GFMSideMenuViewController.swift
//  GoFundMeNative
//
//  Created by Daniel Ho on 1/7/16.
//  Copyright © 2016 Daniel Ho. All rights reserved.
//

import UIKit

class GFMSideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let menuCellIdentifier = "SideMenuCell"

    @IBOutlet weak var tableView: UITableView!
    var viewModel: GFMSideMenuViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel!.numberOfSections()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.numberOfRowsInSection(section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(menuCellIdentifier, forIndexPath: indexPath) 
        cell.textLabel?.text = viewModel!.titleForIndexPath(indexPath)
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        viewModel!.handleSelectRowAtIndexPath(indexPath)
    }

}
