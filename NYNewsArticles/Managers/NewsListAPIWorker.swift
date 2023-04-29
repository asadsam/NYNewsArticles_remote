//
//  NewsListWebserviceManager.swift
//  NYNewsArticles
//
//  Created by Asadullah Jamadar on 28/04/2023.
//

import Foundation

protocol NewsListWebservice {
    typealias CompletionHandlerWS = (Data?, Bool, MediaError?) -> Void

    func fetchNewsArticles(forPeriod period: Int, completionHandler: @escaping CompletionHandlerWS)
}

// to be used for testing by providing some mock data
class FakeNewsListAPIWorker: NewsListWebservice {
    func fetchNewsArticles(forPeriod period: Int, completionHandler: @escaping CompletionHandlerWS) {
        
    }
}

class NewsListAPIWorker: NewsListWebservice {
    
    func fetchNewsArticles(forPeriod period: Int, completionHandler: @escaping CompletionHandlerWS) {
        
        WebserviceRequestResponseManager.sharedInstance.executeGetRequest(url: Constants.Urls.mostPopularArticles(forDays: period)) {data, response, error, status in
            
            completionHandler(data,status,error as? MediaError)
        }
    }
}
