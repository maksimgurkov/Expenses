//
//  MyListExpensesCellTableViewCell.swift
//  Expenses
//
//  Created by Максим Гурков on 04.06.2022.
//

import UIKit

class MyListExpensesCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewColor: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var countDaysLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewShadow()
        setupColorView()
    }
    
    private func setupViewShadow() {
        viewColor.layer.shadowColor = UIColor.black.cgColor
        viewColor.layer.shadowOffset = CGSize(width: 0.7, height: 0.7)
        viewColor.layer.shadowOpacity = 2.0
        viewColor.layer.shadowRadius = 5
        viewColor.layer.masksToBounds = false
        
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
        gradientLayer.frame = viewColor.bounds
        gradientLayer.cornerRadius = 10
        gradientLayer.colors = [colorOne, colorThree, colorTwo]
        gradientLayer.startPoint = CGPoint(x: 0.6, y: 0.8)
        gradientLayer.endPoint = CGPoint(x: 0.1, y: 0.1)
        viewColor.layer.insertSublayer(gradientLayer, at: 0)
    }

}
