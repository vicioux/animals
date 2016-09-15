//
//  Array+Generals.swift
//  animals
//
//  Created by Sergio Orozco  on 9/14/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import Foundation

extension Array {
    
    func split() -> (left: [Element], right: [Element]) {
        let ct = self.count
        let half = ct / 2
        let leftSplit = self[0 ..< half]
        let rightSplit = self[half ..< ct]
        return (left: Array(leftSplit), right: Array(rightSplit))
    }
    
}