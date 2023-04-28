//
//  Constants.swift
//  NYNewsArticles
//
//  Created by Asadullah Jamadar on 28/04/2023.
//

import Foundation

let themeColor = "#48E4C2"
let baseURL = "https://api.nytimes.com/svc/%@/v2/mostviewed/all-sections/7.json?api-key=%@"
let apiKey = "31iiHrjxfbQ8I45ZN6vdocYDJ2bdkAOz"

enum apiEndpoint: String {
    case MostPopular = "mostpopular"
    case MovieReviewsAPI = "moviereviews" //not in use
}
