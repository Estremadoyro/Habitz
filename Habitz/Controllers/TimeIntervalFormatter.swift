//
//  TimeIntervalFormatter.swift
//  Habitz
//
//  Created by Leonardo  on 30/11/21.
//

import Foundation

final class TimeIntervalFormatter {
  static func formatter(time: TimeInterval, magnitude: TimeMagnitudes) -> Int {
    /// # `100 TimeInterval` equals `100 seconds`
    let ti = NSInteger(time)
    switch magnitude {
      case TimeMagnitudes.seconds:
        return ti % 60
      case TimeMagnitudes.minutes:
        return (ti / 60) % 60
      case TimeMagnitudes.hours:
        return (ti / 3600)
    }
  }
}
