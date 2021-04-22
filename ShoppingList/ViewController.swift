//
//  ViewController.swift
//  ShoppingList
//
//  Created by Mark Burpee on 2021/03/29.
//

import UIKit
//This class will inherit methods and properties from UIViewController and UITableViewDataSource parent classes.
class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var newItemTextfield: UITextField!
    @IBOutlet weak var myTableView: UITableView!

    //Create an empty array that will hold objects of type "Item"
    var items: [Item] = []
    
    //create a dictionary that will record the array in long-term memory even after the app is quit
    var persistance = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //identify this class as the data source for the table
        myTableView.dataSource = self
        
        //Fill empty array with items stored in UserDefaults dictionary. First create a place "myArray" to put the encoded data that is stored with the key "persistanceArray".
        if let myArray = UserDefaults.standard.data(forKey: "persistanceArray"){
            //Now decode the JSON data as an array of objects I created from my custom class called "Item"
            if let itemDecoded  = try?  JSONDecoder().decode([Item].self, from: myArray) as [Item] {
                //Finally, assign the the global array "items" to the value of the decoded array stored in UserDefaults.
               items = itemDecoded
            }
            else {
                print ("Decoding Failed")
            }
        }
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
        cell.detailTextLabel?.text = String(currentItem.quantity)
        
        return cell
        
    }

    @IBAction func onButtonPush(_ sender: UIBarButtonItem) {
    
    //use an "if statement" to check to see that there is text entered into the "enter new item" textfield then assign the value to a variable
        if let newItemName = newItemTextfield.text {
            var newItemQuantity = 1
            //Check to see if user entered a quantity. If not, default to 1
            if let quantityInTextfield = quantityTextField.text{
            newItemQuantity = Int(quantityInTextfield) ?? 1
            }
            //assign the text to the "name" "quantity" properties of the new item
            let newItem = Item(name: newItemName, quantity: newItemQuantity)
            //add the new item to the array "items"
            items.append(newItem)
            }
            newItemTextfield.text = ""
            quantityTextField.text = ""
            //encode and store data in the UserDefaults dictionary
            if let encoded = try? JSONEncoder().encode(items){
            persistance.setValue(encoded, forKey: "persistanceArray")
            } else {
            print ("Encoding Failed")
            }
            
            myTableView.reloadData()
        }

    //This "commit" built in method for UITableViewDataSource allows an item to be deleted from the table and removed from the array. It then saves the array into UserDefaults so the data will persist.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        self.items.remove(at: indexPath.row)
        self.myTableView.deleteRows(at: [indexPath], with: .automatic)
        //This part saves the array, now minus the deleted item, to UserDefaults
        if let encoded = try? JSONEncoder().encode(items){
        persistance.setValue(encoded, forKey: "persistanceArray")
        } else {
        print ("Encoding Failed")
        }
      }
    }
}

