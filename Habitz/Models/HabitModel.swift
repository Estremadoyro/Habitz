//
//  ActivityModel.swift
//  Habitz
//
//  Created by Leonardo  on 24/11/21.
//

import Foundation

struct HabitModel: Identifiable, Codable {
  struct Category: Codable {
    var name: HabitTypes
  }

  var id = UUID()
  var name: String
  var category: Category
  var isActive: Bool
  var time: TimeInterval

  var timeSeconds: Int {
    return TimeIntervalFormatter.formatter(time: self.time, magnitude: TimeMagnitudes.seconds)
  }

  var timeMinutes: Int {
    return TimeIntervalFormatter.formatter(time: self.time, magnitude: TimeMagnitudes.minutes)
  }

  var timeHours: Int {
    return TimeIntervalFormatter.formatter(time: self.time, magnitude: TimeMagnitudes.hours)
  }

  var dateStart: Date
}
