//
//  IntroVC.swift
//  OxPower
//
//  Created by jin fu on 2024/10/25.
//

import UIKit

class OxPowerIntroViewController: UIViewController {

    //MARK: - IBOutlet
    
    //MARK: - Variables
    
    //MARK: - Viewlife Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    //MARK: - Function
    
    //MARK: - TableView Delegate & DataSource
    
    //MARK: - Collectionview Delegate & DataSource
    
    //MARK: - IBActions
    @IBAction func Start(_ sender: Any) {
        getAppScene()?.setupHome()
    }
    
}
