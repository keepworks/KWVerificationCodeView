//
//  KWVerificationCodeView.swift
//  Pods
//
//  Created by KeepWorks on 11/01/17.
//  Copyright © 2017 KeepWorks Technologies Pvt Ltd. All rights reserved.
//

import UIKit

public protocol KWVerificationCodeDelegate: class {
  func moveToNext(_ verificationCodeView: KWVerificationCodeView)
  func moveToPrevious(_ verificationCodeView: KWVerificationCodeView, oldCode: String)
}

@IBDesignable open class KWVerificationCodeView: UIView {
  
  // MARK: - Constants
  static let maxCharactersLength = 1
  
  // MARK: - IBInspectables
  @IBInspectable open var underlineColor: UIColor = UIColor.darkGray {
    didSet {
      underlineView.backgroundColor = self.underlineColor.withAlphaComponent(0.3)
    }
  }
  
  // MARK: - IBOutlets
  @IBOutlet public weak var numberTextField: UITextField!
  @IBOutlet public weak var underlineView: UIView!
  
  // MARK: - Variables
  weak public var delegate: KWVerificationCodeDelegate?
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    loadViewFromNib()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    loadViewFromNib()
    numberTextField.delegate = self
    NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: numberTextField)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: - Public Methods
  public func activate() {
    numberTextField.becomeFirstResponder()
    if numberTextField.text?.characters.count == 0 {
      numberTextField.text = " "
    }
  }
  
  public func deactivate() {
    numberTextField.resignFirstResponder()
  }
  
  public func reset() {
    numberTextField.text = " "
    updateUnderline()
  }
  
  // MARK: - FilePrivate Methods
  dynamic fileprivate func textFieldDidChange(_ notification: Foundation.Notification) {
    if numberTextField.text?.characters.count == 0 {
      numberTextField.text = " "
    }
  }
  
  fileprivate func updateUnderline() {
    underlineView.backgroundColor = numberTextField.text?.trim() != "" ? self.underlineColor : self.underlineColor.withAlphaComponent(0.3)
  }
}

// MARK: - UITextFieldDelegate
extension KWVerificationCodeView: UITextFieldDelegate {
  public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentString = numberTextField.text!
    let newString = currentString.replacingCharacters(in: textField.text!.range(from: range)!, with: string)
    
    if newString.characters.count > type(of: self).maxCharactersLength {
      delegate?.moveToNext(self)
      textField.text = string
    } else if newString.characters.count == 0 {
      delegate?.moveToPrevious(self, oldCode: textField.text!)
      numberTextField.text = " "
    }
    
    updateUnderline()
    
    return newString.characters.count <= type(of: self).maxCharactersLength
  }
}
