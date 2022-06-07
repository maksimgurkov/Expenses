//
//  ExpenseListTableViewCell.swift
//  Expenses
//
//  Created by Максим Гурков on 07.06.2022.
//

import UIKit

class ExpenseListTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionExpenseLabel: UILabel!
    @IBOutlet weak var sumExpenseLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
