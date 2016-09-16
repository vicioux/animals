//
//  AnimalRepository.swift
//  animals
//
//  Created by Sergio Orozco  on 9/13/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation
import ObjectMapper

class AnimalRepository: IAnimalRepository {
    
    static let sharedInstance = AnimalRepository()
    let limit = 8
    
    private func getOffset(page: Int) -> Int{
        
        if page > 0 {
            return limit * (page - 1)
        }
        
        return 0
    }
    
    func findAnimals(completion: (success: [Animal]?, fail: NSError?) -> Void) {
        findAnimals(byName: nil, sortAsc: nil, currentPage: 1) { (success, fail) in
            completion(success: success, fail: fail)
        }
    }
    
    func findAnimals(byName name: String?, sortAsc isAsc: Bool? = true, currentPage page: Int, completion: (success: [Animal]?, fail: NSError?) -> Void) {
        
        var params : [ String : AnyObject] = [
            "offset": getOffset(page),
            "limit": limit,
            "asc": isAsc ?? true,
        ]
        
        if let name = name where !name.isEmpty {
            params["search"] = name
        }
        
        APIClient.sharedInstance.request(.GET, APIClient.getUrl("animals"), parameters: params,
            encoding: .URLEncodedInURL).responseResultObject {
                (request, response) -> Void in
                switch response.result {
                    
                case let .Success(valueJSON):
                    let items = Mapper<Animal>().mapArray(valueJSON["animals"]!)
                    completion(success: items, fail: nil)
                    
                case .Failure(let alamoFireError):
                    completion(success: nil, fail: alamoFireError)
                }
        }
    }

}
