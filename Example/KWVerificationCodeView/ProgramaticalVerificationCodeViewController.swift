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

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let verificationCodeView = KWVerificationCodeView(frame: CGRect(x: 0, y: 0, width: 240, height: 60))
    containerView.addSubview(verificationCodeView)
  }
  
  @IBAction func dismissButtonTapped(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}

