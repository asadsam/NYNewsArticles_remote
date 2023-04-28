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
}

class NewsListViewModel: NSObject {
    
    // dependency injection
    var service: NewsListWebservice
    
    init(service: NewsListWebservice) {
        self.service = service
    }
    
    weak var delegate:NewsListUpdateProtocol?
    var newsResultsArray : NewsArticlesResponce?

    func fetchNewsArticles()
    {
        self.service.fetchNewsArticles{ [unowned self] data, status, error in
            
            if let data = data{
                self.newsResultsArray = convertDataToModel(data, type: NewsArticlesResponce.self)
            }
            self.delegate?.fetchNewsFinishedWithSuccess()
        }
    }
}
