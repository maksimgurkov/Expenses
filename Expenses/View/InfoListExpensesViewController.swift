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
    @IBAction func newExpensesButton(_ sender: Any) {
        alert()
    }
    
    private func alert() {
        let alert = UIAlertController(
            title: "Новый расход",
            message: "Добавьте позицию расхода заполнив все поля",
            preferredStyle: .alert)
        let newExpenses = UIAlertAction(title: "Добавить", style: .default) { _ in
            guard let name = alert.textFields?.first?.text, !name.isEmpty else { return }
            guard let sum = alert.textFields?.last?.text, !sum.isEmpty else { return }
            self.expens.nameExpenses = name
            self.expens.sumExpenses += Int(sum) ?? 0
            self.view.reloadInputViews()
        }
        let cancelAction = UIAlertAction(title: "Назад", style: .destructive)
        
        alert.addAction(newExpenses)
        alert.addAction(cancelAction)
        alert.addTextField { textField in
            textField.placeholder = "Добавить имя расхода"
        }
        alert.addTextField { textField in
            textField.placeholder = "Введите сумму"
        }
    
        
        present(alert, animated: true)
    }
    

}

