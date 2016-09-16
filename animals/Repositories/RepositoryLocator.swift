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
    
    func animalRepository() -> IAnimalRepository {
        if (useTestRepo) {
            return TestAnimalRepository.sharedInstance
        } else {
            return AnimalRepository.sharedInstance
        }
    }
}
