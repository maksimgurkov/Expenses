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
        cell.titleLabel.text = expenses[indexPath.row].title
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
            let new = Expenses.init(title: expens)
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
