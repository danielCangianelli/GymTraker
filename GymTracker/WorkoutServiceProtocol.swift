//
//  WorkoutServiceProtocol.swift
//  GymTracker
//
//  Created by Daniel Negreiros Cangianelli on 06/05/25.
//


import Foundation

protocol WorkoutServiceProtocol {
    func fetchAllWorkouts() -> [Workout]
    func saveWorkout(_ workout: Workout)
    func deleteWorkout(_ workout: Workout)
    func fetchTodayWorkout() -> Workout?
    func addExercise(_ exercise: Exercise, to workout: Workout)
    func deleteExercise(_ exercise: Exercise)
}
