//
//  HabitActivePulseAnimationView.swift
//  Habitz
//
//  Created by Leonardo  on 4/12/21.
//

import SwiftUI

struct HabitActivePulseAnimationView: View {
  @State private var animationAmount = 1.0
  var body: some View {
    Button("Tap Me") {
      animationAmount += 1
    }
    .padding(50)
    .background(Color.red)
    .foregroundColor(.white)
    .clipShape(Circle())
    .overlay(
      Circle()
        .stroke(.red)
        .scaleEffect(self.animationAmount)
        .opacity(2 - self.animationAmount)
        .animation(
          .easeInOut(duration: 1)
            .repeatForever(autoreverses: false),
          value: animationAmount
        )
    )
    .onAppear {
      animationAmount = 2
    }
  }
}

struct HabitActivePulseAnimationView_Previews: PreviewProvider {
  static var previews: some View {
    HabitActivePulseAnimationView()
  }
}
