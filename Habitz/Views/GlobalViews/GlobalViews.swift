//
//  GlobalViews.swift
//  Habitz
//
//  Created by Leonardo  on 27/11/21.
//

import SwiftUI

struct CustomContainer: View {
  var height: Double
  var body: some View {
    RoundedRectangle(cornerRadius: 25)
      .fill(Color.white)
      .frame(height: self.height)
      .shadow(color: Color.black.opacity(0.2), radius: 10)
      .shadow(color: Color.white.opacity(0.7), radius: 10)
  }
}
