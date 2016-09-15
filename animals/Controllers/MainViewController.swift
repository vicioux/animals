//
//  ViewController.swift
//  animals
//
//  Created by Sergio Orozco  on 9/13/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll


// MARK: INPUT Protocol
protocol MainViewControllerInput {
    func setAnimals(animals:[Animal])
    func showMessage(message: String)
}

// MARK: OUTPUT Protocol
protocol MainViewControllerOutput {
    func loadAnimals()
    func searchAnimals(filter: Filter)
}

struct Filter {
    var searchedText: String
    var sortAsc: Bool
    var pageCount: Int
}

class MainViewController: UIViewController, MainViewControllerInput {

    var output: AnimalInteractor!
    var animals: [Animal]?
    
    var pageCount: Int = 1
    var sortAsc : Bool = true
    var searchedText: String {
        get {
            return searchTextField.text ?? ""
        }
    }
    var currentFilter: Filter {
        get {
            return Filter(searchedText: self.searchedText, sortAsc: self.sortAsc, pageCount: self.pageCount)
        }
    }

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
        output.loadAnimals()
        
        //Register Cells
        let tableNib = UINib(nibName: Identifier.tableViewCell, bundle: nil)
        mainTableView.registerNib(tableNib, forCellReuseIdentifier: Identifier.tableViewCell)
        
        //Configure Infinite Scroll
        self.mainTableView.infiniteScrollIndicatorView = CustomInfiniteIndicator(frame: CGRectMake(0, 0, 34, 34))
        self.mainTableView.infiniteScrollIndicatorMargin = -6
        self.mainTableView.addInfiniteScrollWithHandler { (tableView) in
            
            self.loadMoreAnimals()
            tableView.finishInfiniteScroll()
        }

    }
    
    func textFieldDidChange(textField: UITextField) {
        let currentText = textField.text!
        var filter = currentFilter
        filter.searchedText = currentText.trimLeadingAndTrailingWhiteSpacesAndNewLines()
        self.output.searchAnimals(filter)
    }
    
    func loadMoreAnimals() {
        pageCount += 1
        self.output.searchAnimals(currentFilter)
    }
    
    // MARK: Protocol functions
    func setAnimals(animals: [Animal]) {
        self.animals = animals
        mainTableView.reloadData()
    }
    
    func showMessage(message: String) {
        //when this dont find something
    }

}

// MARK: UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = searchTextField.text!
        let newLength = currentText.length + string.length - range.length
        
        return newLength <= 40
    }
}

// MARK: UITableViewDataSource  UITableViewDelegate
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