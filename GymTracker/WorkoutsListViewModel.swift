import Foundation
import SwiftData

@MainActor
final class WorkoutsListViewModel: WorkoutsListViewModelProtocol {
    @Published private(set) var workouts: [Workout] = []
    private let service: WorkoutServiceProtocol

    init(service: WorkoutServiceProtocol) {
        self.service = service
        loadWorkouts()
    }

    func loadWorkouts() {
        workouts = service.fetchAllWorkouts()
    }

    func addWorkout(title: String, weekday: Int) {
        let workout = Workout(title: title, weekday: weekday)
        service.saveWorkout(workout)
        loadWorkouts()
    }

    func deleteWorkout(at offsets: IndexSet) {
        offsets.map { workouts[$0] }.forEach(service.deleteWorkout)
        loadWorkouts()
    }
    
    func addExercise(_ exercise: Exercise, to workout: Workout) {
            service.addExercise(exercise, to: workout)
            loadWorkouts()
        }
}
