//
//  WebserviceRequestResponseManager.swift
//  NYNewsArticles
//
//  Created by Asadullah Jamadar on 28/04/2023.
//

import Foundation

enum MediaError: Error {
    case invalidURL
    case missingData
    case decodingError
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "InvalidURL"
        case .missingData:
            return "MissingData"
        case .decodingError:
            return "DecodingError"
        case .unknown:
            return "UnknownError"
        }
    }
}

struct ErrorType: Identifiable {
    var id = UUID()
    var error: MediaError
}

protocol WebserviceRequestResponseProtocol {
    typealias CompletionHandler = (Data?, URLResponse?, MediaError?,Bool) -> Void
    
    func executePostRequest(url:String,bodyData:Data,completionHandler: @escaping CompletionHandler)}

class WebserviceRequestResponseManager: NSObject
{
    static let sharedInstance = WebserviceRequestResponseManager()
    private override init(){}
    
    public typealias CompletionHandler = (Data?, URLResponse?, Error?,Bool) -> Void
    
    
    public func executePostRequest(url:String,bodyData:Data,completionHandler: @escaping CompletionHandler)
    {
        guard let url = URL(string: url) else {
            print("Error: cannot create url")
            
            completionHandler(nil, nil, MediaError.invalidURL, false)
            return
        }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpBody = bodyData
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        
        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, response, error) in
            
            if(error != nil)
            {
                print( "Fail Error not null : \(error.debugDescription)")
                completionHandler(data, response, error, false)
            }
            else
            {
                if let httpResponse = response as? HTTPURLResponse
                {
                    var isSuccess = true
                    if(httpResponse.statusCode != 200)
                    {
                        isSuccess = false
                    }
                    completionHandler(data, response, error, isSuccess)
                }
            }
        })
        task.resume()
    }
    
    public func executeGetRequest(url:String,completionHandler: @escaping CompletionHandler)
    {
        guard let url = URL(string: url) else {
            print("Error: cannot create url")
            completionHandler(nil, nil, MediaError.invalidURL, false)
            return
        }
        var urlRequest = URLRequest(url: url)
        
        
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        
        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: { (data, response, error) in
            
            if(error != nil)
            {
                print( "Fail Error not null : \(error.debugDescription)")
                completionHandler(data, response, error, false)
            }
            else
            {
                if let httpResponse = response as? HTTPURLResponse
                {
                    var isSuccess = true
                    if(httpResponse.statusCode != 200)
                    {
                        isSuccess = false
                    }
                    completionHandler(data, response, error, isSuccess)
                    
                }
            }
            
        })
        task.resume()
    }
}
