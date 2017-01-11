//
//  StringExtension.swift
//  Pods
//
//  Created by Pavan Kotesh on 5/27/16.
//  Copyright © 2016 KeepWorks. All rights reserved.
//

import UIKit

extension String {
  func trim() -> String {
    return trimmingCharacters(in: CharacterSet.whitespaces)
  }
}
