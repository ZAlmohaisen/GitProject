//
//  AvatarCell.swift
//  GitProject
//
//  Created by Ziyad almohisen on 07/04/2019.
//  Copyright © 2019 Ziyad almohisen. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    
    @IBOutlet weak var avatarimg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func setUpView() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
}
