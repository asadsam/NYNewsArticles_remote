//
//  NewsListWebserviceManager.swift
//  NYNewsArticles
//
//  Created by Asadullah Jamadar on 28/04/2023.
//

import Foundation

protocol NewsListWebservice {
    typealias CompletionHandlerWS = (Data?, Bool, Error?) -> Void

    func loadNewsArticles(completionHandler: @escaping CompletionHandlerWS)
}

// can be used while testing by providing some mock data
class FakeNewsListWebService: NewsListWebservice {
    func loadNewsArticles(completionHandler: @escaping CompletionHandlerWS) {
        
    }
}

class NewsListAPIWorker: NewsListWebservice {
    
    func loadNewsArticles(completionHandler: @escaping CompletionHandlerWS) {
        
        WebserviceRequestResponseManager.sharedInstance.executeGetRequest(url: String(format: baseURL, endPoint.people.rawValue)) {data, response, error, status in
            
            completionHandler(data,status,error)
        }
    }
}
