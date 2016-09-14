//
//  RepositoryLocator.swift
//  animals
//
//  Created by Sergio Orozco  on 9/13/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

class RepositoryLocator {
    
    static let sharedInstance = RepositoryLocator()
    let useTestRepo = true;
    
    class var sharedDispatchInstance: RepositoryLocator {
        
        struct Stactic {
            static var onceToken:dispatch_once_t = 0
            static var instance: RepositoryLocator? = nil
        }
        
        dispatch_once(&Stactic.onceToken) {
            Stactic.instance = RepositoryLocator()
        }
        
        return Stactic.instance!
    }
    
    func animalRepository() -> IAnimalRepository {
        if (useTestRepo) {
            return TestAnimalRepository.sharedInstance
        } else {
            return AnimalRepository.sharedInstance
        }
    }
}
