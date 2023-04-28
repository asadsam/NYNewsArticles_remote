//
//  NewsListViewTests.swift
//  NYNewsArticlesTests
//
//  Created by Asadullah Jamadar on 29/04/2023.
//

import XCTest
@testable import NYNewsArticles

class NewsListViewTests: XCTestCase {

    var sut: NewsListViewModel!
    var newsListWebserviceSpy = NewsListWebserviceSpy()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        sut = NewsListViewModel(service: newsListWebserviceSpy)
    }

    // MARK: - Test doubles
    class NewsListWebserviceSpy: NewsListWebservice {
        var loadArticles = false
        
        func fetchNewsArticles(completionHandler: @escaping CompletionHandlerWS) {
            loadArticles = true
        }
    }
    
    // MARK: - Tests
    func testShouldLoadMediaTypesOnViewAppear() {

      // When
      sut.fetchNewsArticles()
      // Then
      XCTAssertTrue(
        newsListWebserviceSpy.loadArticles,
        "fetchArticles() should ask the webservicemanager to fetch the articles"
      )
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
