//
//  Constants.swift
//  NYNewsArticles
//
//  Created by Asadullah Jamadar on 28/04/2023.
//

import Foundation

let themeColor = "#48E4C2"

struct Constants {
    
    struct Urls {
        
        static func mostPopularArticles(forDays period: Int) -> String {
            return "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/\(period).json?api-key=31iiHrjxfbQ8I45ZN6vdocYDJ2bdkAOz"
        }
    }
}

enum apiEndpoint: String {
    case MostPopular = "mostpopular"
    case MovieReviewsAPI = "moviereviews" //not in use
}
