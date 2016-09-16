//
//  Animal.swift
//  animals
//
//  Created by Sergio Orozco  on 9/13/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation
import ObjectMapper

class Animal: Mappable {
    var name : String?
    var description : String?
    var picture : String?
    
    init() {}
    
    init(name: String, description: String, picture: String) {
        self.name = name
        self.description = description
        self.picture = picture
    }
    
    required convenience init?(_ map: Map) {
        self.init()
        mapping(map)
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        description <- map["description"]
        picture <- map["image"]
    }
    
}
