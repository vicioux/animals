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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        animalImageView.hnk_cancelSetImage()
        animalImageView.image = nil
    }
    
    private func updateUI() {
        animalNameLabel.text = animal?.name
        animalDescriptionLabel.text = animal?.description
        let pictureUrl = NSURL(string:animal?.picture ?? "")!
        self.animalImageView.hnk_setImageFromURL(pictureUrl)
    }
}