//
//  ActivityTypes.swift
//  Habitz
//
//  Created by Leonardo  on 24/11/21.
//

import Foundation

enum HabitTypes: String, CaseIterable, Codable {
  case sports = "Sports"
  case studies = "Studies"
  case games = "Games"
  case coding = "Coding"
  case cooking = "Cooking"
}

enum TimeMagnitudes {
  case seconds
  case minutes
  case hours
}
