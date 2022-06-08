//
//  MyListExpensesTableViewController.swift
//  Expenses
//
//  Created by Максим Гурков on 04.06.2022.
//

import UIKit

class MyListExpensesTableViewController: UITableViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var expenses: [Entity] = []
    private var filteredExpenses: [Entity] = []
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        forSearchController()
        setupNavigationBar()
        fetchData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
           return filteredExpenses.count
        }
        return expenses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyListExpensesCellTableViewCell
        var expense: Entity
        if isFiltering {
            expense = filteredExpenses[indexPath.row]
        } else {
            expense = expenses[indexPath.row]
        }
        cell.titleLabel.text = expense.title
        cell.sumLabel.text = "\(expense.sumExpenses) руб."
        cell.countDaysLabel.text = "Добавлено \(expense.countExpenses) расходов"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let expense = expenses[indexPath.row]
        
        if editingStyle == .delete {
            expenses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageManager.shared.delete(expenses: expense)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let infoVC = segue.destination as? TestTableViewController else { return }
        guard let index = tableView.indexPathForSelectedRow else { return }
        let expense: Entity
        if isFiltering {
            expense = filteredExpenses[index.row]
        } else {
            expense = expenses[index.row]
        }
        infoVC.expense = expense
    }
    
    private func save(_ expensesName: String, sum: Int) {
        StorageManager.shared.save(expensesName, sum: sum) { expenses in
            self.expenses.append(expenses)
            self.tableView.insertRows(
                at: [IndexPath(row: self.expenses.count - 1, section: 0)],
                with: .automatic
            )
        }
    }
    
    private func fetchData() {
        StorageManager.shared.fetchData { result in
            switch result {
            case .success(let expenses):
                self.expenses = expenses
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
            guard let expense = alert.textFields?.first?.text, !expense.isEmpty else { return }
            self.save(expense, sum: 0)
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

extension MyListExpensesTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func forSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Имя расхода"
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredExpenses = expenses.filter{ (expense: Entity) -> Bool in
            return expense.title?.lowercased().contains(searchText.lowercased()) ?? false
        }
        tableView.reloadData()
    }
    
    
}
