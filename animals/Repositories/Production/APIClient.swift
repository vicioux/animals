//
//  APIClient.swift
//  animals
//
//  Created by Sergio Orozco  on 9/15/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation
import Alamofire

class APIClient: Manager {
    
    static let ApiBaseUrl = "http://private-12c93e-animals6.apiary-mock.com/"
    
    class func getUrl(urlPart:String) -> String {
        return ApiBaseUrl + urlPart;
    }
    
}

extension Request {
    public func responseResultObject(queue: dispatch_queue_t? = nil,
                                     options: NSJSONReadingOptions = .AllowFragments,
                                     completionHandler: (NSURLRequest, Response<AnyObject, NSError>) -> Void) -> Self {
        return response(queue: queue,
                        responseSerializer: Request.JSONResponseSerializer(options: options),
                        completionHandler: { (response) -> Void in
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                                
                                
                                dispatch_async(queue ?? dispatch_get_main_queue(), {
                                    completionHandler(response.request!, response)
                                })
                            })
        })
    }
}