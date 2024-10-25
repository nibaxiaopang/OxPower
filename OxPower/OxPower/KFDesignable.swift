

import UIKit
import CoreLocation
import Foundation
// you can set cornerRadius,borderWidth., ect in side storeboard.
@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableTextView: UITextView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

@IBDesignable
class DesignableImageView: UIImageView {
}

@IBDesignable
class GradiantView : UIView{
    
    @IBInspectable var firstColor : UIColor = UIColor.white{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable var secondColor : UIColor = UIColor.white{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable var horizontalGradiant : Bool = false{
        didSet{
            updateView()
        }
    }
    
    
    override class var layerClass : AnyClass{
        get{
            return CAGradientLayer.self
        }
    }
    
    
    func updateView(){
        
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor.cgColor,secondColor.cgColor]
        
        if horizontalGradiant{
            layer.startPoint = CGPoint(x: 0.0, y: 0.5)
            layer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        else{
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint(x: 0, y: 1)
        }
        
    }
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

extension UITextField{
    
    func setLeftPadding(_ amount: CGFloat = 10) {

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.bounds.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }

    func setRightPadding(_ amount: CGFloat = 10) {

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.bounds.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

//MARK: - extention

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}


@IBDesignable
extension UITextField {

    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }

    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
}

extension UIViewController
{
    
    func setUpRightNavItem()
    {
        let image = UIImage(named: "ic_camera")
        let titleImageView = UIImageView(image: image)
        titleImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImageView
        
        let imageLeftBtn = UIImage(named: "ic_add")
        let LeftBtn = UIButton(type: .system)
        LeftBtn.setImage(imageLeftBtn?.withRenderingMode(.alwaysOriginal), for: .normal)
        LeftBtn.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: LeftBtn)
        
        let imageBtn = UIImage(named: "ic_add")
        let rightBtn = UIButton(type: .system)
        rightBtn.setImage(imageBtn?.withRenderingMode(.alwaysOriginal), for: .normal)
        rightBtn.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        
        let imageBtn1 = UIImage(named: "ic_add")
        let rightBtn1 = UIButton(type: .system)
        rightBtn1.setImage(imageBtn1?.withRenderingMode(.alwaysOriginal), for: .normal)
        rightBtn1.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: rightBtn), UIBarButtonItem(customView: rightBtn1)]
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false

    }
    
}


extension UITextField {

    func setUnderLine() {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width - 10, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

}

class AlignableUILabel: UILabel {

    override func drawText(in rect: CGRect) {

        var newRect = CGRect(x: rect.origin.x,y: rect.origin.y,width: rect.width, height: rect.height)
        let fittingSize = sizeThatFits(rect.size)

        if contentMode == UIView.ContentMode.top {
            newRect.size.height = min(newRect.size.height, fittingSize.height)
        } else if contentMode == UIView.ContentMode.bottom {
            newRect.origin.y = max(0, newRect.size.height - fittingSize.height)
        }

        super.drawText(in: newRect)
    }

}

extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

extension UIViewController{
    func setUpTextField(textField : UITextField){
        textField.tintColor = UIColor.init(named: "red")
        textField.textColor = UIColor.init(named: "Primary_Color")
//        textField.setTextColor(.black, for: .editing)
//        textField.setOutlineColor(.red, for: .normal)
//        textField.setOutlineColor(.red, for: .editing)
//        textField.setFloatingLabelColor(.gray, for: .editing)
//        textField.setFloatingLabelColor(.gray, for: .normal)
//        textField.setNormalLabelColor(.gray, for: .normal)
//        textField.setNormalLabelColor(.gray, for: .editing)
        textField.sizeToFit()
    }
}
