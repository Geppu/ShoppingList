//
//  DetailViewController.swift
//  ShoppingList
//
//  Created by Mark Burpee on 2021/04/22.
//

import UIKit

class DetailViewController: UIViewController {
    var item: Item!

    @IBOutlet weak var moreInfoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = item.name
        moreInfoLabel.text = "\(item.quantity)"

        // Do any additional setup after loading the view.
    }
    

}
