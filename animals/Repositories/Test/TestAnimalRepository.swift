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
        
        var animals = [Animal]()
        let turtle = Animal(name: "turtle", picture: "")
        let pelican = Animal(name: "pelican", picture: "")
        let tiger = Animal(name: "tiger", picture: "")
        let lion = Animal(name: "lion", picture: "")
        
        animals.append(turtle)
        animals.append(pelican)
        animals.append(tiger)
        animals.append(lion)
        
        completion(success: animals, fail: nil)
    }
    
    func findAnimals(byName name: String?, sortAsc isAsc: Bool? = true, completion: (success: [Animal]?, fail: NSError?) -> Void) {
        
        var animals = [Animal]()
        let turtle = Animal(name: "turtle", picture: "")
        let pelican = Animal(name: "pelican", picture: "")
        let tiger = Animal(name: "tiger", picture: "")
        let lion = Animal(name: "lion", picture: "")
        
        animals.append(turtle)
        animals.append(pelican)
        animals.append(tiger)
        animals.append(lion)
        
        let sorted = animals.sort{ $0.name!.localizedCaseInsensitiveCompare($1.name!) == .OrderedAscending }
        if let name = name where !name.isEmpty {
            let filtered = sorted.filter { $0.name!.containsString(name) }
            completion(success: filtered, fail: nil)
            return
        }
        
        completion(success: sorted, fail: nil)
    }
}
