//
//  Activities.swift
//  Habitz
//
//  Created by Leonardo  on 28/11/21.
//

import Foundation

final class Habits: ObservableObject {
  /// # `[HabitModel]()` -> CREATES AN `EMPTY` ARRAY OF <HabitModel> TYPE
  @Published var userHabits = UserHabitsModel(habits: [HabitModel]()) {
    didSet {
      if let encoded = try? JSONEncoder().encode(self.userHabits) {
        UserDefaults.standard.set(encoded, forKey: "UserHabits")
        print("NEW HABITS AFTER UPDATE")
        print(self.userHabits)
      }
    }
  }

  var isHabitActive: Bool {
    return self.userHabits.activeHabit.isActive
  }

  var getActiveHabit: HabitModel? {
    if self.isHabitActive {
      return self.userHabits.activeHabit.habit
    }
    return nil
  }

  func toggleActiveHabit(habit: HabitModel) {
    if let currentHabit = self.userHabits.habits.firstIndex(where: { $0.id == habit.id }) {
      self.userHabits.habits[currentHabit].isActive.toggle()
      print("Updated habit: \(habit.id)")
      print("name: \(self.userHabits.habits[currentHabit].name) | isActive: \(self.userHabits.habits[currentHabit].isActive)")
    }
  }

  func checkCurrentHabitIsActiveOne(currentHabit: HabitModel) -> Bool {
    if let activeHabit = self.getActiveHabit {
      return currentHabit.id == activeHabit.id
    }
    return false
  }

  init() {
//    UserDefaults.standard.removeObject(forKey: "UserHabits")
    if let savedHabits = UserDefaults.standard.data(forKey: "UserHabits") {
      if let decodedHabits = try? JSONDecoder().decode(UserHabitsModel.self, from: savedHabits) {
        print("LOADED HABITS")
        print(decodedHabits)
        self.userHabits = decodedHabits
        return
      }
    }
    self.userHabits = UserHabitsModel(habits: [])
  }
}
