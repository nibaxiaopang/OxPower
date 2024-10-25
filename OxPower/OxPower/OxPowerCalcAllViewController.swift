//
//  CalcAllVC.swift
//  OxPower
//
//  Created by jin fu on 2024/10/25.
//

import UIKit

class OxPowerCalcAllViewController: UIViewController {

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

    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Age(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AgeVC") as! OxPowerAgeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func Weight(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WeightVC") as! OxPowerWeightViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func Feed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FeedVC") as! OxPowerFeedViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func Pullibng(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PullingVC") as! OxPowerPullingViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func Milk(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MilkVC") as! OxPowerMilkVewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
