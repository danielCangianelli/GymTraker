//
//  ProfileViewModelProtocol.swift
//  GymTracker
//
//  Created by Daniel Negreiros Cangianelli on 06/05/25.
//

import Foundation

protocol ProfileViewModelProtocol: ObservableObject {
    var peso: Double { get set }
    var altura: Double { get set }
    var objetivo: String { get set }
    var imc: Double { get }
}
