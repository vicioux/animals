//
//  Configurator.swift
//  animals
//
//  Created by Sergio Orozco  on 9/13/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

extension MainViewController: AnimalPresenterOutput { }

extension AnimalInteractor: MainViewControllerOutput { }

extension AnimalPresenter: AnimalInteractorOutput { }

class Configurator {
    
    // MARK: Object lifecycle
    static let sharedInstance = Configurator()
    
    // MARK: Configuration
    func configure(viewController: MainViewController) {
        
        let presenter = AnimalPresenter()
        presenter.output = viewController
        
        let interactor = AnimalInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
    }
}

