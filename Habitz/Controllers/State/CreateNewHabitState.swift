//
//  ApplicationState.swift
//  Habitz
//
//  Created by Leonardo  on 27/11/21.
//

import Foundation

final class CreateNewHabitState: ObservableObject {
  @Published var selectedCategory = HabitTypes.sports
  @Published var isCreatingNewHabit: Bool = false
  @Published var habitName: String = ""
}
