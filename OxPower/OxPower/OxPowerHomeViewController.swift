//
//  HomeVC.swift
//  OxPower
//
//  Created by OxPower on 2024/10/25.
//

import UIKit
import StoreKit

class OxPowerHomeViewController: UIViewController {

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
    
    @IBAction func About(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutOxVC") as! OxPowerAboutOxViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func Fact(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OxFactVC") as! OxPowerOxFactViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Calc(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CalcAllVC") as! OxPowerCalcAllViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Share(_ sender: Any) {
        let objectsToShare = ["OxPower"]
        let activityVController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVController.popoverPresentationController?.sourceView = self.view
        activityVController.popoverPresentationController?.sourceRect = CGRect(x: 100, y: 200, width: 300, height: 300)
        self.present(activityVController, animated: true, completion: nil)
    }
    
    @IBAction func Rayte(_ sender: Any) {
        if #available(iOS 18.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                AppStore.requestReview(in: windowScene)
            }
        } else {
            if let windowScene = UIApplication.shared.windows.first?.windowScene {
                if #available(iOS 14.0, *) {
                    SKStoreReviewController.requestReview(in: windowScene)
                } else {
                    SKStoreReviewController.requestReview()
                }
            }
        }
    }
}
