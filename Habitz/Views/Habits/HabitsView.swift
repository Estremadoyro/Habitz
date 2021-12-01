//
//  HabitsView.swift
//  Habitz
//
//  Created by Leonardo  on 24/11/21.
//

import SwiftUI

struct HabitContent: View {
  @State var habitName: String
  @State var hours: Int
  @State var minutes: Int
  var body: some View {
    VStack(alignment: .leading) {
      Text(habitName)
        .foregroundColor(Color.white)
        .font(.largeTitle.bold())
      Text("Total time: \(self.hours) hrs., \(self.minutes) min.")
        .foregroundColor(Color.white)
        .font(.title3.bold())
    }
    .padding(.leading)
  }
}

struct HabitBackground: View {
  var category: HabitTypes
  var bgColor: Color {
    CategoriesController.getColorFromCategory(category: self.category)
  }

  var bgIcon: String {
    CategoriesController.getIconNameFromCategory(category: self.category)
  }

  var body: some View {
    ZStack(alignment: .topTrailing) {
      Rectangle()
        .fill(self.bgColor)
        .frame(width: 350, height: 150)
        .cornerRadius(25)
        .shadow(color: self.bgColor, radius: 3)
      Image(systemName: self.bgIcon)
        .foregroundColor(Color.white)
        .font(.title)
        .padding([.top, .trailing])
    }
  }
}

struct HabitsView: View {
  @ObservedObject var habits: Habits
  var sortedHabitsByTime: [HabitModel] {
    return HabitsController.sortHabitsByTime(habits: self.habits.userHabits.habits)
  }

  var body: some View {
    ZStack {
      CustomContainer(height: 400.0)
        .padding(.horizontal)
      VStack(alignment: .leading) {
        Text("Habits")
          .applySubTitleModifier()
        Text("Total time: \(habits.userHabits.totalTimeHours) hrs. \(habits.userHabits.totalTimeMinutes) min.")
          .foregroundColor(Color.gray)
          .font(.caption)
        ScrollView(.vertical, showsIndicators: false) {
          VStack {
            ForEach(self.sortedHabitsByTime) { habit in
              ZStack(alignment: .leading) {
                HabitBackground(category: habit.category.name)
                HabitContent(habitName: habit.name, hours: habit.timeHours, minutes: habit.timeMinutes)
              }
              .padding(.top, 3)
              .padding(.horizontal, 3)
            }
          }
        }
        .frame(height: 300)
        .cornerRadius(25)
      }
    }
  }
}
