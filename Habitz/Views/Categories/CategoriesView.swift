//
//  CategoriesView.swift
//  Habitz
//
//  Created by Leonardo  on 24/11/21.
//

import SwiftUI

struct CategoryContainer: View {
  var category: HabitTypes
  var categoryColor: Color {
    return CategoriesController.getColorFromCategory(category: self.category)
  }

  var body: some View {
    Rectangle()
      .fill(self.categoryColor)
      .frame(width: 150, height: 100)
      .cornerRadius(25)
      .shadow(color: self.categoryColor, radius: 2)
  }
}

struct CategoryContent: View {
  @ObservedObject var habits: Habits
  @State var category: HabitTypes
  var timeByCategory: TimeInterval {
    return CategoriesController.getTimeByCategory(user: self.habits.userHabits, category: self.category)
  }

  var hours: Int {
    return TimeIntervalFormatter.formatter(time: self.timeByCategory, magnitude: TimeMagnitudes.hours)
  }

  var minutes: Int {
    return TimeIntervalFormatter.formatter(time: self.timeByCategory, magnitude: TimeMagnitudes.minutes)
  }

  var body: some View {
    VStack {
      Text(category.rawValue)
        .foregroundColor(Color.white)
        .font(.title.bold())
      VStack(alignment: .leading) {
        Text("\(self.hours)").bold() + Text(" hours")
        Text("\(self.minutes)").bold() + Text(" minutes")
      }
      .foregroundColor(Color.white)
    }
  }
}

struct CategoriesView: View {
  @ObservedObject var habits: Habits
  var sortedcategoriesbytime: [HabitTypes] {
    return CategoriesController.sortCategoriesByTime(user: self.habits.userHabits)
  }

  var body: some View {
    ZStack {
      CustomContainer(height: 180.0)
        .padding(.horizontal)
      VStack(alignment: .leading) {
        Text("Categories")
          .applySubTitleModifier()
          .padding(.leading)
        ScrollView(.horizontal, showsIndicators: false) {
          HStack {
            ForEach(self.sortedcategoriesbytime, id: \.self) { category in
              ZStack {
                CategoryContainer(category: category)
                CategoryContent(habits: self.habits, category: category)
              }
              .padding(.vertical, 3)
            }
            .animation(.default)
          }
          .padding(.horizontal)
        }
        .frame(width: 380)
      }
    }
  }
}
