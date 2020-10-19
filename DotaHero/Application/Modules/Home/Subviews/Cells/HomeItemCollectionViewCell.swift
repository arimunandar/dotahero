//
//  HomeItemCollectionViewCell.swift
//  DotaHero
//
//  Created by Ari Munandar on 18/10/20.
//  Copyright © 2020 Ari Munandar. All rights reserved.
//

import SDWebImage
import UIKit

class HomeItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupShadow()
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

    func binding(data: Hero) {
        if let urlString = data.img {
            self.imageView.sd_setImage(with: URL(string: "https://api.opendota.com" + urlString))
        }

        self.nameLabel.text = data.localizedName
    }
}
