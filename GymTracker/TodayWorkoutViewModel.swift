//
//  TodayWorkoutViewModel.swift
//  GymTracker
//
//  Created by Daniel Negreiros Cangianelli on 06/05/25.
//


import Foundation
import SwiftData


@MainActor
final class TodayWorkoutViewModel: TodayWorkoutViewModelProtocol {
    @Published private(set) var todayWorkout: Workout?
    private let service: WorkoutServiceProtocol

    init(service: WorkoutServiceProtocol) {
        self.service = service
        loadTodayWorkout()
    }

    func loadTodayWorkout() {
        todayWorkout = service.fetchTodayWorkout()
    }
}
