//
//  NewsListViewModel.swift
//  NYNewsArticles
//
//  Created by Asadullah Jamadar on 28/04/2023.
//

import Foundation


protocol NewsListUpdateProtocol:AnyObject
{
    func fetchNewsFinishedWithSuccess()
    func fetchNewsFailedWithError()

}

class NewsListViewModel: NSObject {
    
    // dependency injection
    var service: NewsListWebservice
    
    init(service: NewsListWebservice) {
        self.service = service
    }
    
    weak var delegate:NewsListUpdateProtocol?
    var newsResultsArray : NewsArticlesResponce?
    var newsError: MediaError?

    func fetchNewsArticles()
    {
        self.service.fetchNewsArticles(forPeriod: Constants.period.intermediate.rawValue) { [unowned self] data, status, error in
            
            if let error = error {
                newsError = error
                self.delegate?.fetchNewsFailedWithError()
            }
            
            if let data = data{
                self.newsResultsArray = convertDataToModel(data, type: NewsArticlesResponce.self)
            }
            self.delegate?.fetchNewsFinishedWithSuccess()
        }
    }
}
