//
//  WorkoutsListViewModelProtocol.swift
//  GymTracker
//
//  Created by Daniel Negreiros Cangianelli on 06/05/25.
//


import Combine
import Foundation

protocol WorkoutsListViewModelProtocol: ObservableObject {
    var workouts: [Workout] { get }
    func loadWorkouts()
    func addWorkout(title: String, weekday: Int)
    func deleteWorkout(at offsets: IndexSet)
    func addExercise(_ exercise: Exercise, to workout: Workout)  // ← adiciona aqui
}
