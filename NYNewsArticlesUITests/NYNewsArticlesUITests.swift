//
//  NYNewsArticlesUITests.swift
//  NYNewsArticlesUITests
//
//  Created by Asadullah Jamadar on 28/04/2023.
//

import XCTest

class Load_articles_and_click_on_any_item_should_display_details: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        self.app = XCUIApplication()
        self.app.launch()
    }
    
    func test_should_display_details() {
        
        let goLabel = self.app.staticTexts["Source"]
        XCTAssertFalse(goLabel.exists)

        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: goLabel, handler: nil)

        self.app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()

        waitForExpectations(timeout: 2, handler: nil)
        XCTAssert(goLabel.exists)
    }
}
