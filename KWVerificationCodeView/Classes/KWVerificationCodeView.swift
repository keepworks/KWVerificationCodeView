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
  private let minDigits: UInt8 = 2
  private let maxDigits: UInt8 = 8
  private let textFieldViewLeadingSpace: CGFloat = 10
  private let textFieldViewVerticalSpace: CGFloat = 6

  // MARK: - IBInspectables
  @IBInspectable public var underlineColor: UIColor = UIColor.darkGray {
    didSet {
      for textFieldView in textFieldViews {
        textFieldView.underlineColor = underlineColor
      }
    }
  }

  @IBInspectable public var underlineSelectedColor: UIColor = UIColor.black {
    didSet {
      for textFieldView in textFieldViews {
        textFieldView.underlineSelectedColor = underlineSelectedColor
      }
    }
  }

  @IBInspectable public var textColor: UIColor = UIColor.darkText {
    didSet {
      for textFieldView in textFieldViews {
        textFieldView.numberTextField.textColor = textColor
      }
    }
  }

  @IBInspectable public var digits: UInt8 = 4 {
    didSet {
      updateNumberOfDigits()
    }
  }

  @IBInspectable public var textSize: CGFloat = 24.0 {
    didSet {
      for textFieldView in textFieldViews {
        textFieldView.numberTextField.font = UIFont.systemFont(ofSize: textSize)
      }
    }
  }

  @IBInspectable public var textFont: String = "" {
    didSet {
      if let font = UIFont(name: textFont.trim(), size: textSize) {
        textFieldFont = font
      } else {
        textFieldFont = UIFont.systemFont(ofSize: textSize)
      }

      for textFieldView in textFieldViews {
        textFieldView.numberTextField.font = textFieldFont
      }
    }
  }

  @IBInspectable public var textFieldBackgroundColor: UIColor = UIColor.clear {
    didSet {
      for textFieldView in textFieldViews {
        textFieldView.numberTextField.backgroundColor = textFieldBackgroundColor
      }
    }
  }

  @IBInspectable public var textFieldTintColor: UIColor = UIColor.blue {
    didSet {
      for textFieldView in textFieldViews {
        textFieldView.numberTextField.tintColor = textFieldTintColor
      }
    }
  }

  @IBInspectable public var darkKeyboard: Bool = false {
    didSet {
      keyboardAppearance = darkKeyboard ? .dark : .light
      for textFieldView in textFieldViews {
        textFieldView.numberTextField.keyboardAppearance = keyboardAppearance
      }
    }
  }

  // MARK: - IBOutlets
  @IBOutlet var view: UIView!

  // MARK: - Variables
  public var isTappable: Bool = false {
    didSet {
      view.isUserInteractionEnabled = isTappable
    }
  }

  fileprivate var textFieldViews = [KWTextFieldView]()
  private var keyboardAppearance = UIKeyboardAppearance.default
  private var textFieldFont = UIFont.systemFont(ofSize: 24.0)
  private var requiredDigits: UInt8 {
    switch digits {
    case minDigits...maxDigits:
      return digits

    case 0..<minDigits:
      return minDigits

    default:
      return maxDigits
    }
  }

  weak public var delegate: KWVerificationCodeViewDelegate?

  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)

    setup()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    setup()
  }

  // MARK: - Private Methods
  private func updateNumberOfDigits() {
    textFieldViews.forEach { $0.removeFromSuperview() }
    textFieldViews.removeAll()

    let textFieldViewWidth = (frame.size.width - (textFieldViewLeadingSpace * (CGFloat(requiredDigits) + 1))) / CGFloat(requiredDigits)
    let textFieldViewHeight: CGFloat = frame.size.height - (textFieldViewVerticalSpace * 2)
    var currentX = textFieldViewLeadingSpace
    for _ in 0..<requiredDigits {
      let textFieldView = KWTextFieldView(frame: CGRect(x: currentX, y: textFieldViewVerticalSpace, width: textFieldViewWidth, height: textFieldViewHeight))
      textFieldView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleWidth]
      addSubview(textFieldView)
      textFieldView.delegate = self
      textFieldViews.append(textFieldView)
      currentX += (textFieldViewWidth + textFieldViewLeadingSpace)
    }

    textFieldViews[0].numberTextField.text = " "
  }

  private func setup() {
    loadViewFromNib()
    setupVerificationCodeViews()
    updateNumberOfDigits()
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

    if textFieldView.code == " " {
      let validIndex = textFieldViews.index(of: textFieldView)! == 0 ? 0 : textFieldViews.index(of: textFieldView)! - 1
      textFieldViews[validIndex].activate()
      textFieldViews[validIndex].reset()
    }
  }

  func didChangeCharacters() {
    delegate?.didChangeVerificationCode()
  }
}
