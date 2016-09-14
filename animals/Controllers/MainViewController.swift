//
//  ViewController.swift
//  animals
//
//  Created by Sergio Orozco  on 9/13/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import UIKit


/* INPUT */
protocol MainViewControllerInput {
    func setAnimals(animals:[Animal])
    func showMessage(message: String)
}

/* OUTPUT */
protocol MainViewControllerOutput {
    func loadAnimals()
    func searchAnimals(name: String?)
}

class MainViewController: UIViewController, MainViewControllerInput {

    var output: AnimalInteractor!
    var animals: [Animal]?

    @IBOutlet weak var mainTableView: UITableView!
    
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: .EditingChanged)
        }
    }
    
    private struct Identifier
    {
        static let tableViewCell = "AnimalCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Configurator.sharedInstance.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.output.loadAnimals()
        
        let tableNib = UINib(nibName: Identifier.tableViewCell, bundle: nil)
        self.mainTableView.registerNib(tableNib, forCellReuseIdentifier: Identifier.tableViewCell)
    }
    
    func setAnimals(animals: [Animal]) {
        self.animals = animals
        mainTableView.reloadData()
    }
    
    func showMessage(message: String) {
        //when this dont find something
    }
    
    func textFieldDidChange(textField: UITextField) {
        let currentText = textField.text!
        self.output.searchAnimals(currentText)
    }

}

/* UITextFieldDelegate */
extension MainViewController: UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = searchTextField.text!
        let newLength = currentText.length + string.length - range.length
        
        return newLength <= 40
    }
}

/* UITableViewDataSource  UITableViewDelegate */
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let animals = animals else {
            return 0
        }
        
        return animals.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: AnimalCell = tableView.dequeueReusableCellWithIdentifier(Identifier.tableViewCell) as! AnimalCell
        cell.animal = self.animals![indexPath.row]
        return cell
    }
    
}