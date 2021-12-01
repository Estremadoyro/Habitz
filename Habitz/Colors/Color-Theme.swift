//
//  Color-Theme.swift
//  Habitz
//
//  Created by Leonardo  on 24/11/21.
//

import Foundation
import SwiftUI

func generateRGBA(_ red: Int, _ green: Int, _ blue: Int, opacity: Double) -> Color {
  return Color(red: Double(red) / 255, green: Double(green) / 255, blue: Double(blue) / 255, opacity: opacity)
}

extension Color {
  static var customRed: Color {
    return generateRGBA(181, 23, 158, opacity: 1)
  }

  static var darkBackground: Color {
    return generateRGBA(58, 12, 163, opacity: 1)
  }

  static var darkNewHabitButton: Color {
    return generateRGBA(247, 37, 133, opacity: 1)
  }

  static var darkContentBackground: Color {
    return generateRGBA(181, 23, 158, opacity: 1)
  }

  static var darkPurple: Color {
    return Color(red: 58 / 255, green: 12 / 255, blue: 163 / 255)
  }

  static var lightPurple: Color {
    return Color.purple
  }

  static var offWhite: Color {
    Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
  }
}
