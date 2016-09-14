//
//  AnimalCell.swift
//  animals
//
//  Created by Sergio Orozco  on 9/13/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import UIKit

class AnimalCell: UITableViewCell {
    
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var animalNameLabel: UILabel!
    
    var animal: Animal? {
        didSet{
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI() {
        animalNameLabel.text = animal?.name
        //self.animalImageView.hnk_setImageFromURL(NSURL(string:(animal?.picture)!))
    }
}