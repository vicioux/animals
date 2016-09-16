//
//  ViewController.swift
//  animals
//
//  Created by Sergio Orozco  on 9/13/16.
//  Copyright © 2016 Sergio Orozco . All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll
import SkyFloatingLabelTextField


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

    // MARK: Vars
    var output: AnimalInteractor!
    var animals: [Animal]? {
        didSet {
            if animals?.count > 0 {
                emptyMessageLabel.hidden = true
            } else {
                emptyMessageLabel.hidden = false
            }
        }
    }
    
    private var pageCount: Int = 1
    private let initialPageCount = 1
    private var sortAsc : Bool = true
    
    private var searchedText: String {
        get {
            return searchTextField.text ?? ""
        }
    }
    
    private var currentFilter: Filter {
        get {
            return Filter(searchedText: self.searchedText, sortAsc: self.sortAsc, pageCount: self.pageCount)
        }
    }
    
    private struct Identifier
    {
        static let tableViewCell = "AnimalCell"
    }

    // MARK: Outlets
    @IBOutlet private weak var mainTableView: UITableView!
    
    @IBOutlet weak var searchTextField: SkyFloatingLabelTextField! {
        didSet {
            searchTextField.title = "Search"
            searchTextField.returnKeyType = .Done
            searchTextField.autocorrectionType = .No
            searchTextField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), forControlEvents: .EditingDidEndOnExit)
        }
    }
    
    @IBOutlet weak var emptyMessageLabel: UILabel!
    
    @IBOutlet private weak var sortButton: SortButton! {
        didSet {
            sortButton.respondsToActions = true
            sortButton.userInteractionEnabled = true
            sortButton.addTarget(self, action: #selector(sort(_:)), forControlEvents: .TouchUpInside)
        }
    }
    
    // MARK: LifeCycle
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
    
    // MARK: IBActions
    @IBAction func textFieldDidEndEditing(textField: UITextField) {
        let currentText = textField.text!
        var filter = currentFilter
        self.pageCount = pageCount > initialPageCount ? initialPageCount : pageCount
        filter.searchedText = currentText.trimLeadingAndTrailingWhiteSpacesAndNewLines()
        self.output.searchAnimals(filter)
    }
    
    @IBAction func sort(button: SortButton) {
        self.pageCount = pageCount > initialPageCount ? initialPageCount : pageCount
        self.sortAsc = button.isAsc
        self.output.searchAnimals(currentFilter)
    }
    
    
    // MARK: Controller Separate functions
    private func loadMoreAnimals() {
        pageCount += 1
        self.output.searchAnimals(currentFilter)
    }
    
    private func addMore(animals :[Animal]) {
        mainTableView.beginUpdates()
        
        animals.forEach { [weak self] in
            self?.animals?.append($0)
        }
        
        var index = 0
        var indexPaths: [NSIndexPath] = [NSIndexPath]()
        for _ in animals {
            indexPaths.append(NSIndexPath(forRow: index, inSection: 0))
            index += 1
        }
        
        mainTableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Bottom)
        mainTableView.endUpdates()
    }
    
    // MARK: Protocol functions
    func setAnimals(animals: [Animal]) {
        
        if pageCount <= initialPageCount {
            self.animals = animals
            mainTableView.reloadData()
            return
        }
        
        addMore(animals)
    }
    
    func showMessage(message: String) {
        AppNotification.show(nil, subtitle: message, type:NotificationType.Error.color)
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