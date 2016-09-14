//
//  AnimalInteractor.swift
//  animals
//
//  Created by Sergio Orozco  on 9/13/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

/* OUTPUT */
protocol AnimalInteractorOutput {
    func presentAnimals(animals: [Animal])
    func presentMessage(message: NSError)
}

/* INPUT */
protocol AnimalInteractorInput {
    func loadAnimals()
}


class AnimalInteractor : AnimalInteractorInput {
    var output: AnimalInteractorOutput!
    var repositoryLocator = RepositoryLocator().animalRepository()
    
    func loadAnimals() {
        repositoryLocator.findAnimals { (success, fail) in
            
            guard let success = success else {
                self.output.presentMessage(fail!)
                return
            }
        
            self.output.presentAnimals(success)
        }
    }
    
    func searchAnimals(name: String?) {
        repositoryLocator.findAnimals(byName: name, sortAsc: nil) { (success, fail) in
            guard let success = success else {
                self.output.presentMessage(fail!)
                return
            }
            
            self.output.presentAnimals(success)
        }
    }
}