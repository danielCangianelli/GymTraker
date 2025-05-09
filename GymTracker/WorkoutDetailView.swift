//
//  WorkoutDetailView.swift
//  GymTracker
//
//  Created by Daniel Negreiros Cangianelli on 06/05/25.
//

import SwiftUI
import Foundation

struct WorkoutDetailView<VM>: View where VM: WorkoutDetailViewModelProtocol & ObservableObject {
    @ObservedObject var viewModel: VM
    @State private var showingAdd = false
    @State private var name = ""
    @State private var details = ""
    @State private var reps = 0
    @State private var duration = 0
    @State private var load = 0

    var body: some View {
        List {
            ForEach(viewModel.exercises) { ex in
                NavigationLink(ex.name) {
                    ExerciseDetailView(exercise: ex)
                }
            }
            .onDelete(perform: viewModel.deleteExercise)
        }
        .navigationTitle(viewModel.workout.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button { showingAdd = true } label: { Image(systemName: "plus") }
            }
        }
        .sheet(isPresented: $showingAdd) {
            NavigationView {
                Form {
                    TextField("Nome", text: $name)
                    TextField("Descrição", text: $details)
                    Stepper("Repetições: \(reps)", value: $reps)
                    TextField("Duração (min)", value: Binding($duration), format: .number)
                        .keyboardType(.decimalPad)
                    TextField("Carga (kg)", value: Binding($load), format: .number)
                        .keyboardType(.decimalPad)
                }
                .navigationTitle("Novo Exercício")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Salvar") {
                            viewModel.addExercise(name: name, details: details, repetitions: reps, duration: duration, load: load)
                            showingAdd = false; resetFields()
                        }
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") { showingAdd = false; resetFields() }
                    }
                }
            }
        }
    }

    private func resetFields() {
        name = ""; details = ""; reps = 0; duration = 0; load = 0
    }
}


struct ExerciseDetailView: View {
    let exercise: Exercise

    var body: some View {
        Form {
            Section("Nome") { Text(exercise.name) }
            Section("Descrição") { Text(exercise.details) }
            Section("Repetições") { Text("\(exercise.repetitions)") }
            Section("Duração (min)") { Text("\(exercise.duration, format: .number)") }
            Section("Carga (kg)") { Text("\(exercise.load, format: .number)") }
        }
        .navigationTitle(exercise.name)
    }
}


/*
 
 
 2. Ao cadastrar um treino nós temos a opção de selecionar o dia, sendo do dia 1 ao dia 7, gostaria que definissemos o dia da semana, indo de domingo a sábado.
 */
