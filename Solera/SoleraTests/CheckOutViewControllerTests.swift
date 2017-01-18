//
//  CheckOutViewControllerTests.swift
//  Solera
//
//  Created by Manuel on 1/18/17.
//  Copyright © 2017 Manuel Escrig. All rights reserved.
//

import XCTest
@testable import Solera

class CheckOutViewControllerTests: XCTestCase {
    
    var navigationController: UINavigationController!
    var viewController: CheckOutViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        viewController  = storyboard.instantiateViewController(withIdentifier: "CheckOutViewController") as! CheckOutViewController
        
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
        // Test and Load the View at the Same Time!
        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(viewController.view)
    }
    
    func testTableView() {
        XCTAssertNotNil(viewController.tableView)
    }
    
    func testNumberOfSections() {
        // Number of Sections should be equal to 2
        XCTAssertEqual(viewController.tableView.numberOfSections,2,"Wrong number of sections")
    }
    
    func testNumberOfRowsInPriceSection() {
        // Number of Items should be equal to 1
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection:1),1,"Wrong number of items")
    }
    

    
}
