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
        var newsResultsArray : NewsArticlesResponce?

        func fetchNewsArticles(completionHandler: @escaping CompletionHandlerWS) {
            loadArticles = true
            
            guard let jsonData = readLocalJsonFile() else {
                return
            }
            
            do
            {
                let response = try JSONDecoder().decode(NewsArticlesResponce.self, from: jsonData)
                self.newsResultsArray = response
            }
            catch let error
            {
                print(error)
                return
            }

        }
        
        func readLocalJsonFile() -> Data? {
            do {
                guard let fileUrl = Bundle.main.url(forResource: "MostPopularArticles", withExtension: "json") else {
                    return nil
                }
                
                let data = try Data(contentsOf: fileUrl)
                return data
            } catch let error {
                print("error reading json file")
                return nil
            }
        }
    }
    
    
    
    // MARK: - Tests
    func testShouldFetchArticlesOnViewAppear() {

      // When
      sut.fetchNewsArticles()
      // Then
      XCTAssertTrue(
        newsListWebserviceSpy.loadArticles,
        "fetchArticles() should ask the webservicemanager to fetch the articles"
      )
        let expectation = self.expectation(description: "fetcharticles() is dispatched asynchronously hence we could wait for a while")
            DispatchQueue.main.async {
                expectation.fulfill()
            }
        self.waitForExpectations(timeout: 2, handler: nil)
        
        //XCTAssertEqual(newsListWebserviceSpy.newsResultsArray, sut.newsResultsArray)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
    }

}
