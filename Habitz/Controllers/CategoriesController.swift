//
//  CategoryColorPicker.swift
//  Habitz
//
//  Created by Leonardo  on 27/11/21.
//

import SwiftUI

final class CategoriesController {
  static func getColorFromCategory(category: HabitTypes) -> Color {
    switch category {
      case HabitTypes.sports:
        return Color.blue
      case HabitTypes.studies:
        return Color.green
      case HabitTypes.games:
        return Color.orange
      case HabitTypes.coding:
        return Color.pink
      case HabitTypes.cooking:
        return Color.yellow
    }
  }

  static func getIconNameFromCategory(category: HabitTypes) -> String {
    switch category {
      case HabitTypes.sports:
        return "sportscourt"
      case HabitTypes.studies:
        return "brain"
      case HabitTypes.games:
        return "gamecontroller"
      case HabitTypes.coding:
        return "chevron.left.forwardslash.chevron.right"
      case HabitTypes.cooking:
        return "book"
    }
  }

  static func getTimeByCategory(user: UserHabitsModel, category: HabitTypes) -> TimeInterval {
    /// # `Filters` user's habits `by category`
    let filteredByCategory = user.habits.filter { $0.category.name == category }
    /// # Reduces the filtered category and time
    /// # `totalTime`      -> Initial reducer value `(0)`
    /// # `filteredHabits` -> Habits filtered
    return filteredByCategory.reduce(0) { totalTime, filteredHabits in
      totalTime + filteredHabits.time
    }
  }

  static func sortCategoriesByTime(user: UserHabitsModel) -> [HabitTypes] {
    /// # Creates an array of tuples with `habits and their accumulative time`
    let categoriesWithTime: [(habit: HabitTypes, time: TimeInterval)] = HabitTypes.allCases.map { (habit: $0, time: CategoriesController.getTimeByCategory(user: user, category: $0)) }
    /// # Sorts categories `by time`
    let sortedCategories = categoriesWithTime.sorted(by: { $0.1 > $1.1 })
    /// # Returns `only the time` from the sorted categories/time tuple
    return sortedCategories.map { $0.habit }
  }
}
