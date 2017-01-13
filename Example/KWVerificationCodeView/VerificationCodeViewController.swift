//
//  VerificationCodeViewController.swift
//  KWVerificationCodeView
//
//  Created by KeepWorks on 01/10/2017.
//  Copyright (c) 2017 KeepWorks Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import KWVerificationCodeView

class VerificationCodeViewController: UIViewController {

  // MARK: - IBOutlets
  @IBOutlet weak var verificationCodeView: KWVerificationCodeView!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - IBAction
  @IBAction func submitButtonTapped(_ sender: UIButton) {
    if verificationCodeView.hasValidCode() {
      let alertController = UIAlertController(title: "Success", message: "Code is \(verificationCodeView.getVerificationCode())", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
      alertController.addAction(okAction)
      self.present(alertController, animated: true, completion: nil)
    }
  }
}
