//
//  UpdateHabitView.swift
//  Habitz
//
//  Created by Leonardo  on 5/12/21.
//

import SwiftUI

struct UpdateHabitBackground: View {
  @ObservedObject var habits: Habits
  @State var habit: HabitModel
  var category: HabitTypes {
    return self.habit.category.name
  }

  var bgColor: Color {
    CategoriesController.getColorFromCategory(category: self.category)
  }

  var bgIcon: String {
    CategoriesController.getIconNameFromCategory(category: self.category)
  }

  var body: some View {
    ZStack(alignment: .trailing) {
      Rectangle()
        .fill(self.bgColor)
        .frame(width: 350, height: 150)
        .cornerRadius(25)
        .shadow(color: self.bgColor, radius: 3)
      HabitIcon(bgIcon: self.bgIcon)
        .padding(.bottom)
    }
  }
}

struct UpdateHabitContent: View {
  @ObservedObject var habits: Habits
  @State var habit: HabitModel

  var currentHabit: Int {
    return self.habits.getCurrentActiveHabit(habit: self.habit)
  }

  var body: some View {
    VStack(alignment: .leading) {
      Text(self.habit.name)
        .foregroundColor(Color.white)
        .font(.largeTitle.bold())
      Text("\(self.habits.userHabits.habits[self.currentHabit].timeHours) hrs. \(self.habits.userHabits.habits[self.currentHabit].timeMinutes) min. \(self.habits.userHabits.habits[self.currentHabit].timeSeconds) sec.")
        .foregroundColor(Color.white)
        .font(.title3.bold())
    }
  }
}

struct UpdateHabitView: View {
  @ObservedObject var habits: Habits
  @State var habit: HabitModel
  @Binding var isUpdatingHabit: Bool
  var currentHabit: Int {
    return self.habits.getCurrentActiveHabit(habit: self.habit)
  }

  var body: some View {
    NavigationView {
      VStack {
        ZStack(alignment: .topLeading) {
          UpdateHabitBackground(habits: self.habits, habit: self.habit)
          UpdateHabitContent(habits: self.habits, habit: self.habit)
            .padding(.leading)
            .padding(.top, 40)
        }
        .padding(.top)
        Spacer()
        VStack(alignment: .center) {
          Button(action: {
            print("update")
          }, label: {
            Text("Update")
              .frame(width: 300, height: 60)
              .background(Color.green)
              .foregroundColor(Color.white)
              .font(.title2.bold())
              .cornerRadius(25)
              .shadow(color: Color.green, radius: 5)
          })
            .padding(.vertical)
          Button(action: {
            self.habits.deleteHabit(habit: self.habit)
            self.isUpdatingHabit = false
          }, label: {
            Text("Delete")
              .frame(width: 300, height: 60)
              .background(Color.darkNewHabitButton)
              .foregroundColor(Color.white)
              .font(.title2.bold())
              .cornerRadius(25)
              .shadow(color: Color.customRed, radius: 5)
          })
        }
        .padding(.bottom)
      }
      .navigationTitle(Text("Update habit"))
    }
  }
}
