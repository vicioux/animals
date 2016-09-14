//
//  AnimalRepository.swift
//  animals
//
//  Created by Sergio Orozco  on 9/13/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

class AnimalRepository: IAnimalRepository {
    
    static let sharedInstance = AnimalRepository()
    
    class var sharedDispatchInstance: AnimalRepository {
        
        struct Stactic {
            static var onceToken:dispatch_once_t = 0
            static var instance: AnimalRepository? = nil
        }
        
        dispatch_once(&Stactic.onceToken) {
            Stactic.instance = AnimalRepository()
        }
        
        return Stactic.instance!
    }
    
    func findAnimals(completion: (success: [Animal]?, fail: NSError?) -> Void) {
        
    }
    
    func findAnimals(byName name: String?, sortAsc isAsc: Bool? = true, completion: (success: [Animal]?, fail: NSError?) -> Void) {
        
    }
}
