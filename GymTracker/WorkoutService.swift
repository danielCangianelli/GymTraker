import Foundation
import SwiftData

final class WorkoutService: WorkoutServiceProtocol {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchAllWorkouts() -> [Workout] {
        (try? context.fetch(FetchDescriptor<Workout>())) ?? []
    }

    func saveWorkout(_ workout: Workout) {
        context.insert(workout)
        do {
            try context.save()
        } catch {
            print("Erro ao salvar treino: \(error)")
        }
    }

    func deleteWorkout(_ workout: Workout) {
        context.delete(workout)
        do {
            try context.save()
        } catch {
            print("Erro ao deletar treino: \(error)")
        }
    }

    func fetchTodayWorkout() -> Workout? {
        let weekday = Calendar.current.component(.weekday, from: Date())
        let descriptor = FetchDescriptor<Workout>(
            predicate: #Predicate { $0.weekday == weekday }
        )
        return (try? context.fetch(descriptor))?.first
    }
    
    func addExercise(_ exercise: Exercise, to workout: Workout) {
        workout.exercises.append(exercise)
        context.insert(exercise)
        try? context.save()
    }

    func deleteExercise(_ exercise: Exercise) {
        context.delete(exercise)
        try? context.save()
    }
}
