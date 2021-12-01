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
      if let encoded = try? JSONEncoder().encode(userHabits) {
        UserDefaults.standard.set(encoded, forKey: "UserHabits")
      }
    }
  }

  init() {
    // UserDefaults.standard.removeObject(forKey: "UserHabits")
    if let savedHabits = UserDefaults.standard.data(forKey: "UserHabits") {
      if let decodedHabits = try? JSONDecoder().decode(UserHabitsModel.self, from: savedHabits) {
        self.userHabits = decodedHabits
        print("Loaded habits: \(self.userHabits)")
        return
      }
    }
    self.userHabits = UserHabitsModel(habits: [])
  }
}
