//
//  WebserviceFactory.swift
//  NYNewsArticles
//
//  Created by Asadullah Jamadar on 28/04/2023.
//

import Foundation

class WebServiceFactory {
    
    func createNewsListAPIWorker() -> NewsListWebservice {
        
        let environment = ProcessInfo.processInfo.environment["ENV"]
        if environment == "TEST" {
            return FakeNewsListAPIWorker()
        } else {
            return NewsListAPIWorker()
        }
    }
}
