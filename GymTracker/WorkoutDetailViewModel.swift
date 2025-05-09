//
//  WorkoutDetailViewModel.swift
//  GymTracker
//
//  Created by Daniel Negreiros Cangianelli on 06/05/25.
//

import SwiftUI
import SwiftData

@MainActor
final class WorkoutDetailViewModel: WorkoutDetailViewModelProtocol {
    @Published private(set) var workout: Workout
    @Published private(set) var exercises: [Exercise] = []
    private let service: WorkoutServiceProtocol

    init(workout: Workout, service: WorkoutServiceProtocol) {
        self.workout = workout
        self.service = service
        loadExercises()
    }

    func loadExercises() {
        exercises = workout.exercises
    }

    func addExercise(name: String, details: String, repetitions: Int, duration: Int, load: Int) {
        let ex = Exercise(name: name, details: details, repetitions: repetitions, duration: duration, load: load)
        service.addExercise(ex, to: workout)
        loadExercises()
    }

    func deleteExercise(at offsets: IndexSet) {
        for index in offsets {
            let ex = exercises[index]
            service.deleteExercise(ex)
        }
        loadExercises()
    }
}
