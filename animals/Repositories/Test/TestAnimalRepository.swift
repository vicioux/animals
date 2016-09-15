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
    
    var animals = [Animal(name: "turtle", picture: ""),
                   Animal(name: "pelican", picture: ""),
                   Animal(name: "tiger", picture: ""),
                   Animal(name: "lion", picture: ""),
                   Animal(name: "buffalo", picture: ""),
                   Animal(name: "elephant", picture: ""),
                   Animal(name: "fish", picture: ""),
                   Animal(name: "eagle", picture: ""),
                   Animal(name: "dog", picture: ""),
                   Animal(name: "cat", picture: ""),
                   Animal(name: "alligator", picture: ""),
                   Animal(name: "crow", picture: ""),
                   Animal(name: "squirrel", picture: ""),
                   Animal(name: "bear", picture: ""),
                   Animal(name: "castor", picture: ""),
                   Animal(name: "frog", picture: "")
                  ]
    
    
    class var sharedDispatchInstance: TestAnimalRepository {
        
        struct Stactic {
            static var onceToken:dispatch_once_t = 0
            static var instance: TestAnimalRepository? = nil
        }
        
        dispatch_once(&Stactic.onceToken) {
            Stactic.instance = TestAnimalRepository()
        }
        
        return Stactic.instance!
    }
    
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
