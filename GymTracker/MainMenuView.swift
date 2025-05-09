import SwiftUI

struct MainMenuView<VM>: View where VM: MainMenuViewModelProtocol & ObservableObject {
    @ObservedObject var viewModel: VM

    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Meus Treinos") {
                    WorkoutsListView(viewModel: viewModel.listVM as! WorkoutsListViewModel)
                }
                NavigationLink("Treino de Hoje") {
                    TodayWorkoutView(viewModel: viewModel.todayVM as! TodayWorkoutViewModel)
                }
                NavigationLink("Meu Perfil") {
                    ProfileView(viewModel: viewModel.profileVM as! ProfileViewModel)
                }
            }
            .navigationTitle("Menu")
        }
    }
}
