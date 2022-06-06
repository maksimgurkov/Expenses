//
//  TestTableViewController.swift
//  Expenses
//
//  Created by Максим Гурков on 06.06.2022.
//

import UIKit

class TestTableViewController: UITableViewController {
    
    var expense: Entity!
    
    private var expenses: [EntityTwo] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = expense.title
        fetchData()
        setupNavigationBar()
        
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let expen = expenses[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = expen.descriptionExpense
        content.secondaryText = "Расход \(expen.sumExpense) руб."
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let expense = expenses[indexPath.row]
        
        if editingStyle == .delete {
            expenses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageManager.shared.deleteExpense(expense: expense)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func save(_ expensesName: String, sum: Int) {
        StorageManager.shared.saveExpense(descriptionExpense: expensesName, sumExpense: sum) { expense in
            self.expenses.append(expense)
            self.tableView.insertRows(
                at: [IndexPath(row: self.expenses.count - 1, section: 0)],
                with: .automatic)
        }
    }
    
    private func fetchData() {
        StorageManager.shared.fetchDataExpense { result in
            switch result {
            case .success(let expenses):
                self.expenses = expenses
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension TestTableViewController {
    
    private func setupNavigationBar() {
        title = "Мои расходы"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewExpenses))
    }
    
    @objc private func addNewExpenses() {
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
            self.save(name, sum: Int(sum) ?? 0)
            self.expense.sumExpenses += Int64(Int(sum) ?? 0)
                        
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
