//
//  AnimalPresenter.swift
//  animals
//
//  Created by Sergio Orozco  on 9/13/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

// MARK: OUTPUT Protocol
protocol AnimalPresenterOutput {
    func setAnimals(currencies:[Animal])
    func showMessage(message: String)
}

// MARK: INPUT Protocol
protocol AnimalPresenterInput {
    func presentAnimals(animals: [Animal])
    func presentMessage(message: NSError)
}

class AnimalPresenter: AnimalPresenterInput {
    
    var output: AnimalPresenterOutput!
    
    func presentMessage(message: NSError) {
        let error = CustomError.ErrorFrom(message)
        self.output.showMessage(error.description)
    }
    
    func presentAnimals(animals: [Animal]) {
        self.output.setAnimals(animals)
    }
}
