//
//  ChatVC.swift
//  GitProject
//
//  Created by Ziyad almohisen on 01/04/2019.
//  Copyright © 2019 Ziyad almohisen. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    //Oulets
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
       
    }
    

   

}
