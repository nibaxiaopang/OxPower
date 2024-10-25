//
//  AboutOxQRVC.swift
//  OxPower
//
//  Created by jin fu on 2024/10/25.
//

import UIKit

class OxPowerAboutOxQRViewController: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var imgQR: UIImageView!
    
    //MARK: - Variables
    
    var imageQR = UIImage()
    
    //MARK: - Viewlife Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.imgQR.image = self.imageQR
        
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
         if let error = error {
             // we got back an error!
             let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
             ac.addAction(UIAlertAction(title: "OK", style: .default))
             present(ac, animated: true)
         } else {
             let ac = UIAlertController(title: "Saved!", message: "About Ox QR saved in your photo library.", preferredStyle: .alert)
             ac.addAction(UIAlertAction(title: "OK", style: .default))
             present(ac, animated: true)
         }
     }
    
    //MARK: - Function
    
    //MARK: - TableView Delegate & DataSource
    
    //MARK: - Collectionview Delegate & DataSource
    
    //MARK: - IBActions
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Share(_ sender: Any) {
        let data = self.imgQR.image?.jpegData(compressionQuality: 1.0)
        let finalQR = UIImage.init(data: data!)
        let objectsToShare = [finalQR]
        let activityVController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVController.popoverPresentationController?.sourceView = self.view
        activityVController.popoverPresentationController?.sourceRect = CGRect(x: 100, y: 200, width: 300, height: 300)
        self.present(activityVController, animated: true, completion: nil)
    }
    
    @IBAction func Download(_ sender: Any) {
        let data = self.imgQR.image?.jpegData(compressionQuality: 1.0)
               let finalQR = UIImage.init(data: data!)
               UIImageWriteToSavedPhotosAlbum(finalQR!, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
}
