//
//  MyListExpensesTableViewController.swift
//  Expenses
//
//  Created by Максим Гурков on 04.06.2022.
//

import UIKit

class MyListExpensesTableViewController: UITableViewController {
    
    private var expenses: [Expenses] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyCellTableViewCell
        let expens = expenses[indexPath.row]
        cell.titleLabel.text = expens.title
        cell.sumLabel.text = "\(expens.sumExpenses) руб."
        cell.countDaysLabel.text = "Добавлено \(expens.countExpenses) расходов"
        return cell
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let infoVC = segue.destination as? InfoListExpensesViewController else { return }
        guard let index = tableView.indexPathForSelectedRow else { return }
        infoVC.expens = expenses[index.row]
    }
    

}

extension MyListExpensesTableViewController {
    
    private func setupNavigationBar() {
        title = "Мои расходы"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewExpenses))
    }
    
    @objc private func addNewExpenses() {
        newExpensesAlert()
    }
    
    private func newExpensesAlert() {
        let alert = UIAlertController(
            title: "Информация",
            message: "Добавьте позицию расходов",
            preferredStyle: .alert)
        
        let newExpenses = UIAlertAction(title: "Добавить", style: .default) { _ in
            guard let expens = alert.textFields?.first?.text, !expens.isEmpty else { return }
            
            let new = Expenses(title: expens)
            self.expenses.append(new)
            self.tableView.reloadData()
        }
        
        
        let cancelAction = UIAlertAction(title: "Назад", style: .destructive)
        alert.addAction(newExpenses)
        alert.addAction(cancelAction)
        alert.addTextField { textField in
            textField.placeholder = "Расход"
        }
        present(alert, animated: true)
    }
    
}
