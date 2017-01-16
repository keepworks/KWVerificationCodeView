//
//  KWVerificationCodeView.swift
//  Pods
//
//  Created by KeepWorks on 11/01/17.
//  Copyright © 2017 KeepWorks Technologies Pvt Ltd. All rights reserved.
//

import UIKit

public protocol KWVerificationCodeViewDelegate: class {
  func didChangeVerificationCode()
}

@IBDesignable open class KWVerificationCodeView: UIView {
  
  // MARK: - Constants
  static let maxCharactersLength = 1
  
  // MARK: - IBInspectables
  @IBInspectable open var underlineColor: UIColor = UIColor.darkGray {
    didSet {
      for textFieldView in textFieldViews {
        textFieldView.underlineColor = self.underlineColor
      }
    }
  }
  @IBInspectable var underlineSelectedColor: UIColor = UIColor.blue {
    didSet {
      for textFieldView in textFieldViews {
        textFieldView.underlineSelectedColor = self.underlineSelectedColor
      }
    }
  }
  
  // MARK: - IBOutlets
  @IBOutlet weak private var textFieldView1: KWTextFieldView!
  @IBOutlet weak private var textFieldView2: KWTextFieldView!
  @IBOutlet weak private var textFieldView3: KWTextFieldView!
  @IBOutlet weak private var textFieldView4: KWTextFieldView!
  
  // MARK: - Variables
  lazy var textFieldViews: [KWTextFieldView] = {
    [unowned self] in
    
    return [self.textFieldView1, self.textFieldView2, self.textFieldView3, self.textFieldView4]
    }()
  
  weak public var delegate: KWVerificationCodeViewDelegate?
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    loadViewFromNib()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    loadViewFromNib()
    setupVerificationCodeViews()
  }
  
  // MARK: - Public Methods
  public func getVerificationCode() -> String {
    var verificationCode = ""
    for textFieldView in textFieldViews {
      verificationCode += textFieldView.numberTextField.text!
    }
    
    return verificationCode
  }
  
  public func hasValidCode() -> Bool {
    for textFieldView in textFieldViews {
      if Int(textFieldView.numberTextField.text!) == nil {
        return false
      }
    }
    
    return true
  }
  
  // MARK: - Private Methods
  private func setupVerificationCodeViews() {
    for textFieldView in textFieldViews {
      textFieldView.delegate = self
    }
    
    textFieldViews.first?.activate()
  }
}

// MARK: - KWTextFieldDelegate
extension KWVerificationCodeView: KWTextFieldDelegate {
  func moveToNext(_ textFieldView: KWTextFieldView) {
    let validIndex = textFieldViews.index(of: textFieldView) == textFieldViews.count - 1 ? textFieldViews.index(of: textFieldView)! : textFieldViews.index(of: textFieldView)! + 1
    textFieldViews[validIndex].activate()
  }
  
  func moveToPrevious(_ textFieldView: KWTextFieldView, oldCode: String) {
    if textFieldViews.last == textFieldView && oldCode != " " {
      return
    }
    
    let validIndex = textFieldViews.index(of: textFieldView)! == 0 ? 0 : textFieldViews.index(of: textFieldView)! - 1
    textFieldViews[validIndex].activate()
    textFieldViews[validIndex].reset()
  }
  
  func didEndEditing() {
    delegate?.didChangeVerificationCode()
  }
}
