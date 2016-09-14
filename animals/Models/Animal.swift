//
//  Animal.swift
//  animals
//
//  Created by Sergio Orozco  on 9/13/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

class Animal {
    var name : String?
    var picture : String?
    
    init() {}
    
    init(name: String, picture: String) {
        self.name = name
        self.picture = picture
    }
}
