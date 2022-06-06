//
//  TestTableViewController.swift
//  Expenses
//
//  Created by Максим Гурков on 06.06.2022.
//

import UIKit

class TestTableViewController: UITableViewController {
    
    var expens: Expenses!
    
    private var expenses: [Test] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = expens.title
        print(expenses.count)
        
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
        content.text = expen.descriptionExpenses
        content.secondaryText = "Расход \(expen.sumExpenses) руб."
        cell.contentConfiguration = content

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
            
            let expensesNew = Test(descriptionExpenses: name, sumExpenses: Int(sum) ?? 0 )
            self.expenses.append(expensesNew)
            self.tableView.reloadData()
            self.expens.sumExpenses += expensesNew.sumExpenses
            self.expens.countExpenses += self.expenses.count
            
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
