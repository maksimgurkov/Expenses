//
//  MyListExpensesViewController.swift
//  Expenses
//
//  Created by Максим Гурков on 04.06.2022.
//

import UIKit

class InfoListExpensesViewController: UIViewController {
    
    var expens: Expenses!

    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var countDayLabel: UILabel!
    
    @IBOutlet weak var expensesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = expens.title
        
        sumLabel.text = "\(expens.sumExpenses) руб."
        countDayLabel.text = "Количество расходов \(expens.countExpenses)."
        
        expensesButton.layer.cornerRadius = 8
        
        
    }


}

