//
//  GymTrackerApp.swift
//  GymTracker
//
//  Created by Daniel Negreiros Cangianelli on 05/05/25.
//

import SwiftUI
import SwiftData


@main
struct GymTrackerApp: App {
    // ModelContainer e ViewModels inicializados fora do ViewBuilder
    let container: ModelContainer
    let menuVM: MainMenuViewModel

    init() {
        do {
            container = try ModelContainer(for: Workout.self, Exercise.self)
        } catch {
            fatalError("Falha ao inicializar o container de dados: \(error)")
        }
        let context = container.mainContext
        let service = WorkoutService(context: context)
        menuVM = MainMenuViewModel(service: service)
    }

    var body: some Scene {
        WindowGroup {
            WelcomeView {
                MainMenuView(viewModel: menuVM)
            }
            .modelContainer(container)
        }
    }
}
