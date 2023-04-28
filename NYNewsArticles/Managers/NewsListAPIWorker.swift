//
//  NewsListWebserviceManager.swift
//  NYNewsArticles
//
//  Created by Asadullah Jamadar on 28/04/2023.
//

import Foundation

protocol NewsListWebservice {
    typealias CompletionHandlerWS = (Data?, Bool, Error?) -> Void

    func fetchNewsArticles(completionHandler: @escaping CompletionHandlerWS)
}

// can be used while testing by providing some mock data
class FakeNewsListAPIWorker: NewsListWebservice {
    func fetchNewsArticles(completionHandler: @escaping CompletionHandlerWS) {
        
    }
}

class NewsListAPIWorker: NewsListWebservice {
    
    func fetchNewsArticles(completionHandler: @escaping CompletionHandlerWS) {
        
        WebserviceRequestResponseManager.sharedInstance.executeGetRequest(url: String(format: baseURL, apiEndpoint.MostPopular.rawValue, apiKey)) {data, response, error, status in
            
            completionHandler(data,status,error)
        }
    }
}
