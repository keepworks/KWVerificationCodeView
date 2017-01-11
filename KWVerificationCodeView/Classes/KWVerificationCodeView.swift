//
//  KWVerificationCodeView.swift
//  Pods
//
//  Created by Athul Sai on 11/01/17.
//  Copyright © 2017 KeepWorks. All rights reserved.
//

import UIKit

public protocol KWVerificationCodeDelegate: class {
  func moveToNext(_ verificationCodeView: KWVerificationCodeView)
  func moveToPrevious(_ verificationCodeView: KWVerificationCodeView, oldCode: String)
}

open class KWVerificationCodeView: UIView {
  
  // MARK: - Constants
  static let maxCharactersLength = 1
  
  // MARK: - IBOutlets
  @IBOutlet public var numberTextField: UITextField!
  @IBOutlet public var underlineView: UIView!
  
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
  open func activate() {
    numberTextField.becomeFirstResponder()
    if numberTextField.text?.characters.count == 0 {
      numberTextField.text = " "
    }
  }
  
  open func deactivate() {
    numberTextField.resignFirstResponder()
  }
  
  open func reset() {
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
    underlineView.backgroundColor = numberTextField.text?.trim() != "" ? UIColor.darkGray : UIColor.darkGray.withAlphaComponent(0.3)
  }
}

// MARK: - UITextFieldDelegate
extension KWVerificationCodeView: UITextFieldDelegate {
  public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentString: NSString = numberTextField.text! as NSString
    let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
    
    if newString.length > type(of: self).maxCharactersLength {
      delegate?.moveToNext(self)
      textField.text = string
    } else if newString.length == 0 {
      delegate?.moveToPrevious(self, oldCode: textField.text!)
      numberTextField.text = " "
    }
    
    updateUnderline()
    
    return newString.length <= type(of: self).maxCharactersLength
  }
}
