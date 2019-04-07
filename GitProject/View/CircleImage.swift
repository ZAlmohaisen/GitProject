//
//  CircleImage.swift
//  GitProject
//
//  Created by Ziyad almohisen on 07/04/2019.
//  Copyright © 2019 Ziyad almohisen. All rights reserved.
//

import UIKit


@IBDesignable
class CircleImage: UIImageView {

    override func awakeFromNib() {
        setupView()
    }

    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
}
