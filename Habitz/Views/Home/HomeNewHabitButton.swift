//
//  NewHabitButtonView.swift
//  Habitz
//
//  Created by Leonardo  on 24/11/21.
//

import SwiftUI

struct HomeNewHabitButton: View {
  @StateObject var createNewHabitState = CreateNewHabitState()
  @ObservedObject var habits: Habits
  var body: some View {
    Button(action: {
      self.createNewHabitState.selectedCategory = HabitTypes.sports
      self.createNewHabitState.habitName = ""
      self.createNewHabitState.isCreatingNewHabit.toggle()
    }) {
      HStack {
        Text("New Habit")
        Image(systemName: "plus")
      }
      .font(.title2.bold())
      .foregroundColor(Color.white)
      .frame(width: 300, height: 60)
      .background(Color.darkNewHabitButton)
      .cornerRadius(25)
      .shadow(color: Color.darkNewHabitButton, radius: 5)
    }
    .fullScreenCover(isPresented: $createNewHabitState.isCreatingNewHabit) {
      CreateNewHabitView(createNewHabitState: createNewHabitState, habits: self.habits)
    }
  }
}
