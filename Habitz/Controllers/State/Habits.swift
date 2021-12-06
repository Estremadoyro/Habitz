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

  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

  func getStartPauseIcon(habit: HabitModel) -> String {
    self.checkCurrentHabitIsActiveOne(currentHabit: habit) ? "pause.fill" : "play.fill"
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

  func loadActiveHabitTime() -> TimeInterval {
    if let activeHabit = self.getActiveHabit {
      let habitIndex = self.getCurrentActiveHabit(habit: activeHabit)
      if let iterationStart = activeHabit.iterationStart {
        var auxIterationStart: Date = iterationStart
        auxIterationStart.addTimeInterval(activeHabit.iterationDuration)
        let timeDifference = Date().timeIntervalSince(auxIterationStart)
        self.userHabits.habits[habitIndex].time += timeDifference
        print("New time loaded: \(self.userHabits.habits[habitIndex].time)")
        return timeDifference
      }
    }
    print("owo no active habit found when loaded")
    return 0
  }

  func startHabitTime(habit: HabitModel) -> TimeInterval {
    if self.checkCurrentHabitIsActiveOne(currentHabit: habit) {
      self.userHabits.habits[self.getCurrentActiveHabit(habit: habit)].time += 1
      self.userHabits.habits[self.getCurrentActiveHabit(habit: habit)].iterationDuration += 1
      print("owo Iteration elapsed")
      print("owo \(self.userHabits.habits[self.getCurrentActiveHabit(habit: habit)].iterationDuration)")
      return 1
    }
    return 0
  }

  func manageCurrentHabit(habit: HabitModel) -> Bool {
    if self.checkCurrentHabitIsActiveOne(currentHabit: habit) {
      self.toggleActiveHabit(habit: habit)
      return true
    } else if !self.isHabitActive {
      self.toggleActiveHabit(habit: habit)
      return true
    }
    return false
  }

  func toggleActiveHabit(habit: HabitModel) {
    if let currentHabit = self.userHabits.habits.firstIndex(where: { $0.id == habit.id }) {
      self.userHabits.habits[currentHabit].isActive.toggle()
      self.userHabits.habits[currentHabit].iterationStart = Date()
      self.userHabits.habits[currentHabit].iterationDuration = 0
      print("Updated habit: \(habit.id)")
      print("owo Iteration start @ \(self.userHabits.habits[currentHabit].iterationStart!)")
      print("owo Habit time when started: \(self.userHabits.habits[currentHabit].time)")
      print("name: \(self.userHabits.habits[currentHabit].name) | isActive: \(self.userHabits.habits[currentHabit].isActive)")
    }
  }

  func getCurrentActiveHabit(habit: HabitModel) -> Int {
    if let currentHabit = self.userHabits.habits.firstIndex(where: { $0.id == habit.id }) {
      return currentHabit
    }
    return 0
  }

  func checkCurrentHabitIsActiveOne(currentHabit: HabitModel) -> Bool {
    if let activeHabit = self.getActiveHabit {
      return currentHabit.id == activeHabit.id
    }
    return false
  }

  func deleteHabit(habit: HabitModel) {
    let habitIndex = self.getCurrentActiveHabit(habit: habit)
    if habitIndex != -1 {
      print("removed habit: \(self.userHabits.habits[habitIndex])")
      self.userHabits.habits.remove(at: habitIndex)
    }
  }

  init() {
//    UserDefaults.standard.removeObject(forKey: "UserHabits")
    if let savedHabits = UserDefaults.standard.data(forKey: "UserHabits") {
      if let decodedHabits = try? JSONDecoder().decode(UserHabitsModel.self, from: savedHabits) {
//        print("owo LOADED HABITS")
//        print(decodedHabits)
        self.userHabits = decodedHabits
        let timeLoaded = self.loadActiveHabitTime()
        print("owo Time loaded from active habit: \(timeLoaded)")
        return
      }
    }
    self.userHabits = UserHabitsModel(habits: [])
  }
}
