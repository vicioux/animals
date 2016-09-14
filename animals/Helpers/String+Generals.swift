//
//  String+Generals.swift
//  animals
//
//  Created by Sergio Orozco  on 9/14/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

extension String {
    
    /**
     - returns: The resulting string where ALL leading and trailing whitespaces and new line characters
     */
    func trimLeadingAndTrailingWhiteSpacesAndNewLines() -> String {
        return stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
    }
    
    var length: Int {
        return self.characters.count
    }
}