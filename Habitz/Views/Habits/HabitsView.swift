//
//  HabitsView.swift
//  Habitz
//
//  Created by Leonardo  on 24/11/21.
//

import SwiftUI

struct HabitContent: View {
  @ObservedObject var habits: Habits
  @State var habit: HabitModel

  var body: some View {
    VStack(alignment: .leading) {
      Text(self.habit.name)
        .foregroundColor(Color.white)
        .font(.largeTitle.bold())
      Text("\(self.habit.timeHours) hrs. \(self.habit.timeMinutes) min. \(self.habit.timeSeconds) sec.")
        .foregroundColor(Color.white)
        .font(.title3.bold())
        .onReceive(self.habits.timer) { _ in
          self.habit.time += self.habits.startHabitTime(habit: self.habit)
        }
    }
    .padding(.leading)
  }
}

struct HabitIcon: View {
  @State var bgIcon: String
  var body: some View {
    Image(systemName: self.bgIcon)
      .foregroundColor(Color.white)
      .font(.title)
      .padding([.top, .trailing])
  }
}

struct HabitStartBtn: View {
  @ObservedObject var habits: Habits
  @State var currentHabitActive: Bool = false
  @State var habit: HabitModel

  var body: some View {
    Image(systemName: self.habits.getStartPauseIcon(habit: self.habit))
      .foregroundColor(Color.white)
      .font(.title)
      .padding([.bottom, .trailing])
      .onTapGesture {
        if self.habits.manageCurrentHabit(habit: self.habit) {
          self.currentHabitActive.toggle()
        }
      }
  }
}

struct HabitBackground: View {
  @ObservedObject var habits: Habits
  @State var habit: HabitModel
  @State private var updatingHabit: Bool = false
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
    ZStack(alignment: .topTrailing) {
      Rectangle()
        .fill(self.bgColor)
        .frame(width: 350, height: 150)
        .cornerRadius(25)
        .shadow(color: self.bgColor, radius: 3)
        .onTapGesture {
          self.updatingHabit.toggle()
        }
        .sheet(isPresented: $updatingHabit) {
          UpdateHabitView(habits: self.habits, habit: self.habit, isUpdatingHabit: self.$updatingHabit)
        }
      VStack {
        HabitIcon(bgIcon: self.bgIcon)
        Spacer()
        HabitStartBtn(habits: self.habits, habit: self.habit)
      }
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
      CustomContainer(height: 520.0)
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
                HabitBackground(habits: self.habits, habit: habit)
                HabitContent(habits: self.habits, habit: habit)
              }
              .padding(.top, 3)
              .padding(.horizontal, 3)
            }
            .animation(.default)
          }
        }
        .frame(height: 420)
        .cornerRadius(25)
      }
    }
  }
}
