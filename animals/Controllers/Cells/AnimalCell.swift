//
//  AnimalCell.swift
//  animals
//
//  Created by Sergio Orozco  on 9/13/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import UIKit
import Haneke

class AnimalCell: UITableViewCell {
    
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var animalNameLabel: UILabel!
    @IBOutlet weak var animalDescriptionLabel: UILabel!
    
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
        animalDescriptionLabel.text = animal?.description
        self.animalImageView.hnk_setImageFromURL(NSURL(string:"http://www.universeofsymbolism.com/images/xlion-symbolism.jpg.pagespeed.ic.YPvRkLWxnO.jpg")!)
    }
}