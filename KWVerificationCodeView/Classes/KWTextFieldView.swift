//
//  KWTextFieldView.swift
//  Pods
//
//  Created by KeepWorks on 13/01/17.
//  Copyright © 2017 KeepWorks Technologies Pvt Ltd. All rights reserved.
//

import UIKit

protocol KWTextFieldDelegate: class {
  func moveToNext(_ textFieldView: KWTextFieldView)
  func moveToPrevious(_ textFieldView: KWTextFieldView, oldCode: String)
  func didChangeCharacters()
}

@IBDesignable class KWTextFieldView: UIView {

  // MARK: - Constants
  static let maxCharactersLength = 1

  // MARK: - IBInspectables
  @IBInspectable var underlineColor: UIColor = UIColor.darkGray {
    didSet {
      underlineView.backgroundColor = underlineColor
    }
  }

  @IBInspectable var underlineSelectedColor: UIColor = UIColor.black

  @IBInspectable var textColor: UIColor = UIColor.darkText {
    didSet {
      numberTextField.textColor = textColor
    }
  }

  @IBInspectable var textSize: CGFloat = 24.0 {
    didSet {
      numberTextField.font = UIFont.systemFont(ofSize: textSize)
    }
  }

  @IBInspectable var textFont: String = "" {
    didSet {
      if let font = UIFont(name: textFont, size: textSize) {
        numberTextField.font = font
      } else {
        numberTextField.font = UIFont.systemFont(ofSize: textSize)
      }
    }
  }

  @IBInspectable var textFieldBackgroundColor: UIColor = UIColor.clear {
    didSet {
      numberTextField.backgroundColor = textFieldBackgroundColor
    }
  }

  @IBInspectable var textFieldTintColor: UIColor = UIColor.blue {
    didSet {
      numberTextField.tintColor = textFieldTintColor
    }
  }

  @IBInspectable var darkKeyboard: Bool = false {
    didSet {
      keyboardAppearance = darkKeyboard ? .dark : .light
      numberTextField.keyboardAppearance = keyboardAppearance
    }
  }

  // MARK: - IBOutlets
  @IBOutlet weak var numberTextField: UITextField!
  @IBOutlet weak private var underlineView: UIView!

  // MARK: - Variables
  private var keyboardAppearance = UIKeyboardAppearance.default
  weak var delegate: KWTextFieldDelegate?

  var code: String? {
    return numberTextField.text
  }

  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)

    setup()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    setup()
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  // MARK: - Public Methods
  public func activate() {
    numberTextField.becomeFirstResponder()
    if numberTextField.text?.count == 0 {
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

  // MARK: - Private Methods
  private func setup() {
    loadViewFromNib()
    numberTextField.delegate = self
    numberTextField.autocorrectionType = UITextAutocorrectionType.no

    NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange(_:)), name: UITextField.textDidChangeNotification, object: numberTextField)
  }

  private func updateUnderline() {
    underlineView.backgroundColor = numberTextField.text?.trim() != "" ? underlineSelectedColor : underlineColor
  }

  @objc private func textFieldDidChange(_ notification: Foundation.Notification) {
    if numberTextField.text?.count == 0 {
      numberTextField.text = " "
    }
  }
}

// MARK: - UITextFieldDelegate
extension KWTextFieldView: UITextFieldDelegate {
  public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentString = numberTextField.text!
    let newString = currentString.replacingCharacters(in: textField.text!.range(from: range)!, with: string)

    if newString.count > type(of: self).maxCharactersLength {
      delegate?.moveToNext(self)
      textField.text = string
    } else if newString.count == 0 {
      delegate?.moveToPrevious(self, oldCode: textField.text!)
      numberTextField.text = " "
    }

    delegate?.didChangeCharacters()
    updateUnderline()

    return newString.count <= type(of: self).maxCharactersLength
  }
}
