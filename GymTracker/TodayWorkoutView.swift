import SwiftUI


struct TodayWorkoutView<VM>: View
where VM: TodayWorkoutViewModelProtocol & ObservableObject {
    @ObservedObject var viewModel: VM

    var body: some View {
        Group {
            if let workout = viewModel.todayWorkout {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Treino de Hoje: \(workout.title)")
                        .font(.title)
                    if workout.exercises.isEmpty {
                        Text("Nenhum exercício cadastrado.")
                            .foregroundColor(.secondary)
                    } else {
                        List(workout.exercises) { ex in
                            VStack(alignment: .leading) {
                                Text(ex.name).font(.headline)
                                Text(ex.details).font(.subheadline)
                                Text("Repetições: \(ex.repetitions)")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .padding()
            } else {
                Text("Nenhum treino para hoje")
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Treino de Hoje")
        .onAppear { viewModel.loadTodayWorkout() }
    }
}
