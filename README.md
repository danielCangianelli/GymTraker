# GymTracker

Aplicativo iOS desenvolvido em **SwiftUI** e **SwiftData** (iOS 18+, Swift 6), para planejar e organizar treinos semanais.

## 📖 Descrição

GymTracker permite ao usuário cadastrar seus treinos para cada dia da semana, incluindo exercícios detalhados (nome, descrição, repetições, duração opcional e carga). Oferece fluxo de criação em duas etapas (metadados do treino + cadastro de exercícios), exibição de treino do dia e gestão de perfil (peso, altura, IMC e objetivo) usando `@AppStorage`.

## 🚀 Funcionalidades Principais

- **Tela de Boas‐Vindas**: fluxo sem login (v1).  
- **Menu Principal**: acesso a Meus Treinos, Treino de Hoje e Meu Perfil.  
- **Meus Treinos**:  
  - Listagem de treinos cadastrados.  
  - Fluxo de criação em duas etapas (obrigatoriedade de pelo menos um exercício).  
  - Edição e exclusão de treinos.  
- **Detalhe de Treino**:  
  - Listagem de exercícios associados.  
  - Adição e remoção de exercícios.  
- **Detalhe de Exercício**:  
  - Exibição de todos os campos: nome, descrição, repetições, duração e carga.  
- **Treino de Hoje**:  
  - Exibe automaticamente o treino cujo `weekday` seja o dia atual.  
- **Meu Perfil**:  
  - Cadastro de peso, altura e objetivo.  
  - Cálculo instantâneo de IMC.

## ⚙️ Arquitetura

Adota **MVVM** desacoplado, com:

- **Model**: entidades `Workout` e `Exercise` anotadas com `@Model` (SwiftData) e relacionamento 1→N.  
- **Service**: `WorkoutServiceProtocol` e `WorkoutService` para CRUD de treinos e exercícios.  
- **ViewModels**: protocolos e classes concretas para cada tela (`WorkoutsListViewModel`, `WorkoutDetailViewModel`, `TodayWorkoutViewModel`, `ProfileViewModel`).  
- **Views**: generics em SwiftUI (`WorkoutsListView<VM>`, `WorkoutDetailView<VM>`, etc.), suportando injeção de dependência por protocolo e permitindo testes.

## 💻 Requisitos

- Xcode 16.2 ou superior  
- iOS 18+ SDK  
- Swift 6

## 📂 Estrutura do Projeto

```text
GymTracker/
├─ App.swift                # Ponto de entrada e composition root
├─ Models/
│  ├─ Workout.swift
│  └─ Exercise.swift
├─ Services/
│  └─ WorkoutService.swift
├─ ViewModels/
│  ├─ WorkoutsListViewModel.swift
│  ├─ WorkoutDetailViewModel.swift
│  ├─ TodayWorkoutViewModel.swift
│  └─ ProfileViewModel.swift
├─ Views/
│  ├─ WelcomeView.swift
│  ├─ MainMenuView.swift
│  ├─ WorkoutsListView.swift
│  ├─ WorkoutDetailView.swift
│  ├─ WorkoutCreationFlow.swift
│  ├─ WorkoutNewExercisesView.swift
│  ├─ TodayWorkoutView.swift
│  └─ ProfileView.swift
└─ README.md
