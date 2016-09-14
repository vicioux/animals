//
//  IAnimalRepository.swift
//  animals
//
//  Created by Sergio Orozco  on 9/13/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

protocol IAnimalRepository {
    func findAnimals(completion: (success: [Animal]?, fail: NSError?) -> Void)
    func findAnimals(byName name: String?, completion: (success: [Animal]?, fail: NSError?) -> Void)
}