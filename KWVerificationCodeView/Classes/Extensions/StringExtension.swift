//
//  StringExtension.swift
//  Pods
//
//  Created by KeepWorks on 5/27/16.
//  Copyright © 2017 KeepWorks Technologies Pvt Ltd. All rights reserved.
//

import UIKit

extension String {
  func trim() -> String {
    return trimmingCharacters(in: CharacterSet.whitespaces)
  }
}
