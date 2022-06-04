//
//  MyCellTableViewCell.swift
//  Expenses
//
//  Created by Максим Гурков on 04.06.2022.
//

import UIKit

class MyCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewColor: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var countDaysLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewColor.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
