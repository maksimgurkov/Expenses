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
    
    @IBOutlet weak var viewCellColor: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewShadow()
        setupColorView()
    }

    private func setupViewShadow() {
        viewCellColor.layer.shadowColor = UIColor.black.cgColor
        viewCellColor.layer.shadowOffset = CGSize(width: 0.7, height: 0.7)
        viewCellColor.layer.shadowOpacity = 2.0
        viewCellColor.layer.shadowRadius = 5
        viewCellColor.layer.masksToBounds = false
    }
    
    private func setupColorView() {
        let colorOne = UIColor(red: 255 / 255,
                               green: 255 / 255,
                               blue: 200 / 255,
                               alpha: 1).cgColor
        let colorTwo = UIColor(red: 150 / 255,
                               green: 255 / 255,
                               blue: 200 / 255,
                               alpha: 1).cgColor
        let colorThree = UIColor(red: 200 / 255,
                                 green: 255 / 255,
                                 blue: 255 / 255,
                                 alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = viewCellColor.bounds
        gradientLayer.cornerRadius = 10
        gradientLayer.colors = [colorOne, colorThree, colorTwo]
        gradientLayer.startPoint = CGPoint(x: 0.6, y: 0.8)
        gradientLayer.endPoint = CGPoint(x: 0.1, y: 0.1)
        viewCellColor.layer.insertSublayer(gradientLayer, at: 0)
    }

}
