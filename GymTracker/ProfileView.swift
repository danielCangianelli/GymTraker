//
//  ProfileView.swift
//  GymTracker
//
//  Created by Daniel Negreiros Cangianelli on 06/05/25.
//


import SwiftUI

struct ProfileView<VM>: View where VM: ProfileViewModelProtocol & ObservableObject {
    @ObservedObject var viewModel: VM

    init(viewModel: VM) {
        self.viewModel = viewModel
    }

    var body: some View {
        Form {
            Section("Dados Pessoais") {
                TextField("Peso (kg)", value: $viewModel.peso, format: .number)
                    .keyboardType(.decimalPad)
                TextField("Altura (m)", value: $viewModel.altura, format: .number)
                    .keyboardType(.decimalPad)
            }
            Section("Objetivo") {
                TextField("Objetivo", text: $viewModel.objetivo)
            }
            Section("IMC") {
                Text(String(format: "%.2f", viewModel.imc))
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Meu Perfil")
    }
}
