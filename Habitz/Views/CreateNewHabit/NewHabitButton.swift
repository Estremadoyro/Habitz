//
//  NewHabitButton.swift
//  Habitz
//
//  Created by Leonardo  on 26/11/21.
//

import SwiftUI

struct NewHabitButton: View {
  @ObservedObject var createNewHabitState: CreateNewHabitState
  @ObservedObject var habits: Habits
  var body: some View {
    Button(action: {
      if createNewHabitState.isCreatingNewHabit, createNewHabitState.habitName != "" {
        let habitCategory = HabitModel.Category(name: self.createNewHabitState.selectedCategory)
        let newHabit = HabitModel(name: self.createNewHabitState.habitName, category: habitCategory, isActive: false, time: 1400, dateStart: Date())
        self.habits.userHabits.habits.append(newHabit)
        self.createNewHabitState.isCreatingNewHabit = false
        print("New user habits: \(habits.userHabits.habits)")
      }

    }) {
      HStack {
        Text("Create")
        Image(systemName: "plus")
      }
      .frame(width: 300, height: 60)
      .background(Color.darkNewHabitButton)
      .foregroundColor(Color.white)
      .font(.title2.bold())
      .cornerRadius(25)
      .shadow(color: Color.customRed, radius: 5)
    }
  }
}
