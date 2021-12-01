//
//  ContentView.swift
//  Habitz
//
//  Created by Leonardo  on 24/11/21.
//

import SwiftUI

struct HomeView: View {
  @StateObject var habits = Habits()
  var body: some View {
    ZStack {
      Color.white
      VStack {
        CategoriesView(habits: self.habits)
          .padding(.bottom)
        HabitsView(habits: self.habits)
        Spacer()
        HomeNewHabitButton(habits: self.habits)
      }
    }
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
