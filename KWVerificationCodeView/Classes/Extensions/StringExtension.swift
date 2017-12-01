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

  func range(from nsRange: NSRange) -> Range<String.Index>? {
    guard
      let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
      let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
      let from = String.Index(from16, within: self),
      let to = String.Index(to16, within: self)
      else { return nil }
    return from ..< to
  }
}
