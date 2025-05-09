//
//  WorkoutDetailViewModelProtocol.swift
//  GymTracker
//
//  Created by Daniel Negreiros Cangianelli on 06/05/25.
//

import Foundation

protocol WorkoutDetailViewModelProtocol: ObservableObject {
    var workout: Workout { get }
    var exercises: [Exercise] { get }
    func addExercise(name: String, details: String, repetitions: Int, duration: Int, load: Int)
    func deleteExercise(at offsets: IndexSet)
}
