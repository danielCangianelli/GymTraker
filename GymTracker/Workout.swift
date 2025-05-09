//
//  Workout.swift
//  GymTracker
//
//  Created by Daniel Negreiros Cangianelli on 05/05/25.
//


// Models.swift
import Foundation
import SwiftData

@Model
class Workout: Identifiable {
    var id: UUID = UUID()
    var title: String = ""
    var weekday: Int = 1      // 1...7
    @Relationship(deleteRule: .cascade)
    var exercises: [Exercise] = []

    init(title: String, weekday: Int) {
        self.title = title
        self.weekday = weekday
    }
}

