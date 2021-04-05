//
//  ViewController.swift
//  ShoppingList
//
//  Created by Mark Burpee on 2021/03/29.
//

import UIKit
//This class will inherit methods and properties from UIViewController and UITableViewDataSource parent classes.
class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var newItemTextfield: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    
    //create an empty array that will hold objects of type "Item"
    var items: [Item] = []
    
    //create a dictionary that will record the array in long-term memory even after the app is quit
    var persistance = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //identify this class as the data source for the table
        myTableView.dataSource = self
       let item1 = Item(name: "Milk")
       let item2 = Item(name: "Eggs")
        
        //fill empty array with items stored in dictionary "persistance". If there is nothing in the dictionary, add milk and eggs.
        items = persistance.array(forKey: "persistanceArray") as? [Item] ?? [item1,item2]
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //The number of rows will be the same number of items in the array called "items"
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        //We want each items name to be displayed in the cell. The code will loop through this function for each item in the array "items". First get the index value for the item in the array using indexPath.row. Then make the text property of the cell the same as the "name" property of the item. Do this for each cell as it loops through array.
        let currentItem = items[indexPath.row]
        cell.textLabel?.text = currentItem.name
        
        return cell
        
    }

    @IBAction func onButtonPush(_ sender: UIBarButtonItem) {
    
    //use an "if statement" to check to see that there is text entered into the "enter new item" textfield then assign the value to a variable
        if let newItemName = newItemTextfield.text {
            //assign the text to the "name" property of the new item
            let newItem = Item(name: newItemName)
            //add the new item to the array "items"
            items.append(newItem)
            newItemTextfield.text = ""
            //Check to see if the data can be encoded in the UserDefaults dictionary
            if let encoded = try? JSONEncoder().encode(items){
            persistance.setValue(encoded, forKey: "persistanceArray")
            } else {
            print ("Encoding Failed")
            }
            
            myTableView.reloadData()
        }
}
}

