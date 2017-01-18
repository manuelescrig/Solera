//
//  ShopViewControllerTests.swift
//  Solera
//
//  Created by Manuel on 1/18/17.
//  Copyright © 2017 Manuel Escrig. All rights reserved.
//

import XCTest
@testable import Solera

class ShopViewControllerTests: XCTestCase {
    
    var navigationController: UINavigationController!
    var viewController: ShopViewController!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        viewController = navigationController.topViewController as! ShopViewController
        
        UIApplication.shared.keyWindow!.rootViewController = viewController
        
        _ = navigationController.view
        _ = viewController.view
    
    }
    
    override func tearDown() {
        navigationController = nil
        viewController = nil
        super.tearDown()
    }
    
    
    func testView() {
        // Test and Load the View at the Same Time
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(viewController.view)
    
    }
    
    func testTableView() {
        XCTAssertNotNil(viewController.tableView)
    }
    
    func testNumberOfSections() {
        // Number of Sections should be equal to 1
        XCTAssertEqual(viewController.tableView.numberOfSections,1,"Wrong number of sections")
    }
    
    func testNumberOfItems() {
        // Number of Items should be equal to 4
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection:0),4,"Wrong number of items")
    }
    
    func testTableViewCellForRowAtIndexPath() {
        
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! ShopItemTableViewCell
        
        XCTAssertEqual(cell.titleLabel.text!, "Bag of Peas")
        XCTAssertEqual(cell.buyButton.titleLabel?.text, "Buy")
    }
    
}
