//
//  CreateNewHabitView.swift
//  Habitz
//
//  Created by Leonardo  on 26/11/21.
//

import SwiftUI

/// # `Category selector selects more than 1 category`
struct CategoryOptionBtn: View {
  @ObservedObject var createNewHabitState: CreateNewHabitState
  var habit: HabitTypes
  var isThisActivitySelected: Bool {
    return self.createNewHabitState.selectedCategory == self.habit
  }

  var categoryColor: Color {
    CategoriesController.getColorFromCategory(category: self.habit)
  }

  var body: some View {
    ZStack {
      Rectangle()
        .fill(self.isThisActivitySelected ? self.categoryColor : Color.white)
        .animation(.default, value: self.isThisActivitySelected)
        .frame(width: 150, height: 200)
        .cornerRadius(25)
        .shadow(color: self.categoryColor, radius: 3)
      Text(self.habit.rawValue)
        .font(.title3.bold())
        .foregroundColor(self.isThisActivitySelected ? Color.white : self.categoryColor)
    }
    .padding(.vertical, 4)
    .onTapGesture {
      self.createNewHabitState.selectedCategory = self.habit
    }
  }
}

struct CategoryField: View {
  @ObservedObject var createNewHabitState: CreateNewHabitState
  var body: some View {
    VStack(alignment: .leading) {
      Text("Choose a category")
        .applySubTitleModifier()
        .padding(.leading)

      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 15) {
          ForEach(HabitTypes.allCases, id: \.self) { habit in
            CategoryOptionBtn(createNewHabitState: createNewHabitState, habit: habit)
          }
        }
        .padding(.horizontal)
      }
    }
  }
}

struct NameField: View {
  @ObservedObject var createNewHabitState: CreateNewHabitState
  var body: some View {
    VStack(alignment: .leading) {
      Text("Name")
        .applySubTitleModifier()
        .padding(.leading)
      ZStack {
        CustomContainer(height: 50)
          .padding(.horizontal)
        TextField("Playing the guitar", text: $createNewHabitState.habitName)
          .padding(.leading, 30)
      }
    }
  }
}

struct CancelBtn: View {
  var body: some View {
    Text("Cancel")
      .foregroundColor(Color.white)
      .font(.headline.bold())
      .frame(width: 80, height: 30)
      .background(Color.customRed)
      .clipShape(RoundedRectangle(cornerRadius: 25))
      .shadow(color: Color.customRed, radius: 3)
  }
}

struct CreateNewHabitView: View {
  @ObservedObject var createNewHabitState: CreateNewHabitState
  @ObservedObject var habits: Habits
  @State private var name: String = ""
  var body: some View {
    NavigationView {
      VStack {
        NameField(createNewHabitState: createNewHabitState)
          .padding(.bottom)
        CategoryField(createNewHabitState: createNewHabitState)
        Spacer()
        NewHabitButton(createNewHabitState: self.createNewHabitState, habits: self.habits)
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button(action: {
            self.createNewHabitState.isCreatingNewHabit = false
          }) {
            CancelBtn()
          }
        }
      }
    }
  }
}
