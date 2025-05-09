//
//  MainMenuViewModel.swift
//  GymTracker
//
//  Created by Daniel Negreiros Cangianelli on 06/05/25.
//

import Foundation

@MainActor
final class MainMenuViewModel: MainMenuViewModelProtocol {
    let listVM: any WorkoutsListViewModelProtocol
    let todayVM: any TodayWorkoutViewModelProtocol
    let profileVM: any ProfileViewModelProtocol

    init(service: WorkoutServiceProtocol) {
        let list = WorkoutsListViewModel(service: service)
        let today = TodayWorkoutViewModel(service: service)
        let profile = ProfileViewModel()
        self.listVM = list
        self.todayVM = today
        self.profileVM = profile
    }
}
