//
//  Exercise.swift
//  GymTracker
//
//  Created by Daniel Negreiros Cangianelli on 06/05/25.
//

import Foundation
import SwiftData


@Model
class Exercise: Identifiable {
    var id = UUID()
    var name: String = ""
    var details: String = ""
    var repetitions: Int = 0
    var duration: Int = 0
    var load: Int = 0

    init(name: String = "", details: String = "", repetitions: Int = 0, duration: Int = 0, load: Int = 0) {
        self.name = name
        self.details = details
        self.repetitions = repetitions
        self.duration = duration
        self.load = load
    }
}
