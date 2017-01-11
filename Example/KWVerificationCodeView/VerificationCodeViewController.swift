//
//  VerificationCodeViewController.swift
//  KWVerificationCodeView
//
//  Created by Athul Sai on 01/10/2017.
//  Copyright (c) 2017 Keep Works. All rights reserved.
//

import UIKit
import KWVerificationCodeView

class VerificationCodeViewController: UIViewController {

  // MARK: - IBOutlets
  @IBOutlet weak var verificationCodeView1: KWVerificationCodeView!
  @IBOutlet weak var verificationCodeView2: KWVerificationCodeView!
  @IBOutlet weak var verificationCodeView3: KWVerificationCodeView!
  @IBOutlet weak var verificationCodeView4: KWVerificationCodeView!
  
  // MARK: - Variables
  var mobile: String!
  var selectedVerificationCodeViewIndex = 0
  
  lazy var verificationCodeViews: [KWVerificationCodeView] = {
    [unowned self] in
    
    return [self.verificationCodeView1, self.verificationCodeView2, self.verificationCodeView3, self.verificationCodeView4]
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupVerificationCodeViews()
  }
  
  // MARK: - IBAction
  @IBAction func submitButtonTapped(_ sender: UIButton) {
    if validateTextFields() {
      let alertController = UIAlertController(title: "Success", message: "Code is \(getVerificationCode())", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
      alertController.addAction(okAction)
      self.present(alertController, animated: true, completion: nil)
    }
  }
  
  // MARK: - FilePrivate Methods
  fileprivate func setupVerificationCodeViews() {
    for verificationCodeView in verificationCodeViews {
      verificationCodeView.delegate = self
    }
    
    verificationCodeViews.first?.activate()
  }
  
  fileprivate func validateTextFields() -> Bool {
    for verificationCodeView in verificationCodeViews {
      if Int(verificationCodeView.numberTextField.text!) == nil {
        return false
      }
    }
    
    return true
  }
  
  fileprivate func getVerificationCode() -> String {
    var verificationCode = ""
    for verificationCodeView in verificationCodeViews {
      verificationCode += verificationCodeView.numberTextField.text!
    }
    
    return verificationCode
  }

}

// MARK: - KWVerificationCodeDelegate
extension VerificationCodeViewController: KWVerificationCodeDelegate {
  func moveToNext(_ verificationCodeView: KWVerificationCodeView) {
    let validIndex = verificationCodeViews.index(of: verificationCodeView) == verificationCodeViews.count - 1 ? verificationCodeViews.index(of: verificationCodeView)! : verificationCodeViews.index(of: verificationCodeView)! + 1
    verificationCodeViews[validIndex].activate()
  }
  
  func moveToPrevious(_ verificationCodeView: KWVerificationCodeView, oldCode: String) {
    if verificationCodeViews.last == verificationCodeView && oldCode != " " {
      return
    }
    
    let validIndex = verificationCodeViews.index(of: verificationCodeView)! == 0 ? 0 : verificationCodeViews.index(of: verificationCodeView)! - 1
    verificationCodeViews[validIndex].activate()
    verificationCodeViews[validIndex].reset()
  }
}

