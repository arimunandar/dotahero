//
//  RoleCollectionViewCell.swift
//  DotaHero
//
//  Created by Ari Munandar on 19/10/20.
//  Copyright © 2020 Ari Munandar. All rights reserved.
//

import UIKit

class RoleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var roleNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
        self.setupShadow()
    }
    
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? #colorLiteral(red: 0, green: 0.2539151311, blue: 0.7878607512, alpha: 1) : #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
        }
    }

    private func setupShadow() {
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true

        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.shadowColor = #colorLiteral(red: 0.4876040816, green: 0.4777780771, blue: 0.5054114461, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.layer.shadowRadius = 8.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }
    
    func binding(roleName: String) {
        roleNameLabel.text = roleName
    }
}
