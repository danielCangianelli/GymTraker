import SwiftUI
import Foundation

struct WorkoutsListView<VM>: View
where VM: WorkoutsListViewModelProtocol & ObservableObject
{
    @ObservedObject var viewModel: VM
    @State private var showingCreationFlow = false

    init(viewModel: VM) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            ForEach(viewModel.workouts) { workout in
                NavigationLink(workout.title) {
                    // abre detalhes do treino
                }
            }
            .onDelete(perform: viewModel.deleteWorkout)
        }
        .navigationTitle("Meus Treinos")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingCreationFlow = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingCreationFlow) {
            WorkoutCreationFlow(viewModel: viewModel)
        }
    }
}

struct WorkoutCreationFlow<VM>: View
where VM: WorkoutsListViewModelProtocol & ObservableObject {
    @ObservedObject var viewModel: VM
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var weekday = 1
    @State private var exercises: [Exercise] = []
    @State private var showingAlertNoExercise = false

    init(viewModel: VM) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Detalhes do Treino") {
                    TextField("Título", text: $title)
                    Picker("Dia da semana", selection: $weekday) {
                        ForEach(1...7, id: \.self) { d in Text("Dia \(d)").tag(d) }
                    }
                }
            }
            .navigationTitle("Novo Treino")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    NavigationLink("Próximo") {
                        WorkoutNewExercisesView(
                            viewModel: viewModel,
                            workoutTitle: title,
                            weekday: weekday,
                            exercises: $exercises
                        ) { finalExercises in
                            guard !finalExercises.isEmpty else {
                                showingAlertNoExercise = true
                                return
                            }
                            viewModel.addWorkout(title: title, weekday: weekday)
                            if let newWorkout = viewModel.workouts.last {
                                finalExercises.forEach { viewModel.addExercise($0, to: newWorkout) }
                            }
                            viewModel.loadWorkouts()
                            dismiss()
                        }
                    }
                    .disabled(title.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }
            .alert("Adicione ao menos um exercício", isPresented: $showingAlertNoExercise) {
                Button("OK", role: .cancel) {}
            }
        }
    }
}

// MARK: - Workout New Exercises View
struct WorkoutNewExercisesView<VM>: View
where VM: WorkoutsListViewModelProtocol & ObservableObject {
    @ObservedObject var viewModel: VM
    @Environment(\.dismiss) private var dismiss

    let workoutTitle: String
    let weekday: Int
    @Binding var exercises: [Exercise]
    let onComplete: ([Exercise]) -> Void

    @State private var name = ""
    @State private var details = ""
    @State private var reps = 0
    @State private var duration = 0
    @State private var load = 0
    @State private var showingAlertNoExercise = false

    init(
        viewModel: VM,
        workoutTitle: String,
        weekday: Int,
        exercises: Binding<[Exercise]>,
        onComplete: @escaping ([Exercise]) -> Void
    ) {
        self.viewModel = viewModel
        self.workoutTitle = workoutTitle
        self.weekday = weekday
        self._exercises = exercises
        self.onComplete = onComplete
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Exercícios Cadastrados") {
                    if exercises.isEmpty {
                        Text("Nenhum exercício adicionado ainda.")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(exercises) { ex in
                            Text(ex.name)
                        }
                        .onDelete { offsets in
                            exercises.remove(atOffsets: offsets)
                        }
                    }
                }

                Section("Adicionar Novo Exercício") {
                    VStack(spacing: 12) {
                        TextField("Nome", text: $name)
                        TextField("Descrição", text: $details)
                        Stepper("Repetições: \(reps)", value: $reps)
                        TextField(
                            "Duração (min)",
                            value: Binding(get: { duration ?? 0 }, set: { duration = $0 }),
                            format: .number
                        )
                        .keyboardType(.decimalPad)
                        TextField(
                            "Carga (kg)",
                            value: Binding(get: { load ?? 0 }, set: { load = $0 }),
                            format: .number
                        )
                        .keyboardType(.decimalPad)

                        Button(action: {
                            let ex = Exercise(
                                name: name,
                                details: details,
                                repetitions: reps,
                                duration: duration,
                                load: load
                            )
                            exercises.append(ex)
                            resetFields()
                        }) {
                            Text("Adicionar Exercício")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(name.isEmpty)
                    }
                }
            }
            .navigationTitle("Exercícios de \(workoutTitle)")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Concluir") {
                        if exercises.isEmpty {
                            showingAlertNoExercise = true
                        } else {
                            onComplete(exercises)
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
            .alert(
                "É necessário cadastrar ao menos um exercício",
                isPresented: $showingAlertNoExercise
            ) {
                Button("OK", role: .cancel) {}
            }
        }
    }

    private func resetFields() {
        name = ""
        details = ""
        reps = 0
        duration = 0
        load = 0
    }
}
