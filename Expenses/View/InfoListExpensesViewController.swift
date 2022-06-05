//
//  MyListExpensesViewController.swift
//  Expenses
//
//  Created by Максим Гурков on 04.06.2022.
//

import UIKit

class InfoListExpensesViewController: UIViewController {

    @IBOutlet weak var expensesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expensesButton.layer.cornerRadius = 8
        
    }


}

