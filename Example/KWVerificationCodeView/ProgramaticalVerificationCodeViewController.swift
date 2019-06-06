//
//  VerificationCodeViewController.swift
//  KWVerificationCodeView
//
//  Created by KeepWorks on 01/10/2017.
//  Copyright (c) 2017 KeepWorks Technologies Pvt Ltd. All rights reserved.
//

import UIKit
import KWVerificationCodeView

class ProgramaticalVerificationCodeViewController: UIViewController {

  // MARK: - IBOutlets
  @IBOutlet weak var containerView: UIView!

  // MARK: - Variables
  var verificationCodeView: KWVerificationCodeView?

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    verificationCodeView = KWVerificationCodeView(frame: CGRect(x: 0, y: 0, width: 240, height: 60))
    containerView.addSubview(verificationCodeView!)
  }

  @IBAction func submitButtonTapped(_ sender: Any) {
    if verificationCodeView!.hasValidCode() {
      let alertController = UIAlertController(title: "Success", message: "Code is \(verificationCodeView!.getVerificationCode())", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
      alertController.addAction(okAction)
      present(alertController, animated: true, completion: nil)
    }
  }

  @IBAction func dismissButtonTapped(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}
