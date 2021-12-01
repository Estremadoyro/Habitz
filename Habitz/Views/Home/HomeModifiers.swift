//
//  HomeModifiers.swift
//  Habitz
//
//  Created by Leonardo  on 24/11/21.
//

import SwiftUI

struct NavigationTitleModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.largeTitle)
  }
}

extension View {
  func applyNavigationTitleModifier() -> some View {
    modifier(NavigationTitleModifier())
  }
}

