//
//  ActivitiesModel.swift
//  Habitz
//
//  Created by Leonardo  on 28/11/21.
//

import Foundation

struct UserHabitsModel: Codable {
  var habits: [HabitModel]
  var totalTime: TimeInterval {
    var auxTime: TimeInterval = 0
    for habit in habits {
      auxTime += habit.time
    }
    return auxTime
  }

  var totalTimeSeconds: Int {
    return TimeIntervalFormatter.formatter(time: totalTime, magnitude: TimeMagnitudes.seconds)
  }

  var totalTimeMinutes: Int {
    return TimeIntervalFormatter.formatter(time: totalTime, magnitude: TimeMagnitudes.minutes)
  }

  var totalTimeHours: Int {
    return TimeIntervalFormatter.formatter(time: totalTime, magnitude: TimeMagnitudes.hours)
  }
}
