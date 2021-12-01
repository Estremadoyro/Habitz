//
//  HabitsController.swift
//  Habitz
//
//  Created by Leonardo  on 1/12/21.
//

import Foundation

final class HabitsController {
  static func sortHabitsByTime(habits: [HabitModel]) -> [HabitModel] {
    return habits.sorted(by: { $0.time > $1.time })
  }
}
