//
//  GlobalModifiers.swift
//  Habitz
//
//  Created by Leonardo  on 24/11/21.
//

import SwiftUI

extension View {
  func applySubTitleModifier() -> some View {
    modifier(SubTitleModifier())
  }
}

struct SubTitleModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .foregroundColor(Color.black)
      .font(.title.bold())
  }
}
