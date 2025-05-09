//
//  TodayWorkoutViewModelProtocol.swift
//  GymTracker
//
//  Created by Daniel Negreiros Cangianelli on 06/05/25.
//


import Combine

protocol TodayWorkoutViewModelProtocol: ObservableObject {
    var todayWorkout: Workout? { get }
    func loadTodayWorkout()
}
