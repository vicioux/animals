//
//  TestAnimalRepository.swift
//  animals
//
//  Created by Sergio Orozco  on 9/13/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

class TestAnimalRepository: IAnimalRepository {
    
    static let sharedInstance = TestAnimalRepository()
    
    var animals = [ Animal(name: "turtle", description: "turtle", picture: ""),
                    Animal(name: "pelican", description: "pelican", picture: ""),
                    Animal(name: "tiger", description: "tiger", picture: ""),
                    Animal(name: "lion", description: "lion", picture: ""),
                    Animal(name: "buffalo", description: "buffalo", picture: ""),
                    Animal(name: "elephant", description: "elephant", picture: ""),
                    Animal(name: "fish", description: "fish", picture: ""),
                    Animal(name: "eagle", description: "eagle", picture: ""),
                    Animal(name: "dog", description: "dog", picture: ""),
                    Animal(name: "cat", description: "cat", picture: ""),
                    Animal(name: "alligator", description: "alligator", picture: ""),
                    Animal(name: "crow", description: "crow", picture: ""),
                    Animal(name: "squirrel", description: "squirrel", picture: ""),
                    Animal(name: "bear", description: "bear", picture: ""),
                    Animal(name: "castor", description: "castor", picture: ""),
                    Animal(name: "frog", description: "frog", picture: "")
                  ]
    
    func findAnimals(completion: (success: [Animal]?, fail: NSError?) -> Void) {
        
        findAnimals(byName: nil, sortAsc: nil, currentPage: 1) { (success, fail) in
            completion(success: success, fail: fail)
        }
    }
    
    func findAnimals(byName name: String?, sortAsc isAsc: Bool? = true, currentPage page: Int, completion: (success: [Animal]?, fail: NSError?) -> Void) {
        
        let data = findSortedAnimals(byName: name, sortAsc: isAsc ?? true, page: page)
        completion(success: data, fail: nil)
        
    }

    private func findSortedAnimals(byName name: String?, sortAsc isAsc: Bool = true, page: Int) -> [Animal] {
        
        let orderCriteria = isAsc ? NSComparisonResult.OrderedAscending : NSComparisonResult.OrderedDescending
        var filtered = false
        var animals = self.animals
        if let name = name where !name.isEmpty {
            animals = self.animals.filter { $0.name!.containsString(name) }
            filtered = true
        }
        
        let sorted = animals.sort{ $0.name!.localizedCaseInsensitiveCompare($1.name!) == orderCriteria }

        if filtered {
            return sorted
        }
        
        let splitData = sorted.split()

        if  page == 1 {
            return splitData.left
        } else if page == 2 {
            return splitData.right
        }
        
        let emptyArray: [Animal] = []
        return emptyArray
    }
}
