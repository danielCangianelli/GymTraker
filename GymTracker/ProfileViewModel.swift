//
//  ProfileViewModel.swift
//  GymTracker
//
//  Created by Daniel Negreiros Cangianelli on 06/05/25.
//


import Foundation
import SwiftUI

@MainActor
final class ProfileViewModel: ProfileViewModelProtocol {
    @AppStorage("peso")    var peso: Double = 0.0
    @AppStorage("altura")  var altura: Double = 0.0
    @AppStorage("objetivo")var objetivo: String = ""

    var imc: Double {
        altura > 0 ? peso / (altura * altura) : 0
    }
}
