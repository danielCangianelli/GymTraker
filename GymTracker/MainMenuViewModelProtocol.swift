//
//  MainMenuViewModelProtocol.swift
//  GymTracker
//
//  Created by Daniel Negreiros Cangianelli on 06/05/25.
//

import Foundation

protocol MainMenuViewModelProtocol: ObservableObject {
    var listVM: any WorkoutsListViewModelProtocol { get }
    var todayVM: any TodayWorkoutViewModelProtocol { get }
    var profileVM: any ProfileViewModelProtocol { get }
}
