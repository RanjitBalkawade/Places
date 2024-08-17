//
//  PlacesView.swift
//  Places
//
//  Created by Ranjeet Balkawade on 14/08/2024.
//

import SwiftUI

struct PlacesView: View {
    @ObservedObject var viewModel: PlacesViewModel
    
    var body: some View {
        VStack {
            switch viewModel.viewState {
                case .loading:
                    loadingView
                case .successView:
                    successView
                case .failureView:
                    failureView
            }
        }
        .task {
            await viewModel.loadData()
        }
        .refreshable {
            await viewModel.loadData()
        }
    }
    
    private var successView: some View {
        VStack {
            List {
                if viewModel.placeItemViewModels.isEmpty == false {
                    Section(header: Text(viewModel.locationsTitle)) {
                        ForEach(viewModel.placeItemViewModels) { vm in
                            Button(
                                action: { viewModel.showLocation(vm)},
                                label: { Text(vm.name) }
                            )
                        }
                    }
                }
                
                if viewModel.userDefinedPlaceItemViewModels.isEmpty == false {
                    Section(header: Text(viewModel.userDefinedlocationsTitle)) {
                        ForEach(viewModel.userDefinedPlaceItemViewModels) { vm in
                            Button(
                                action: { viewModel.showLocation(vm)},
                                label: { Text(vm.name) }
                            )
                        }
                    }
                }
            }
            .tint(.black)
            Button(
                action: { viewModel.showAddLocation() },
                label: { Text(viewModel.addLocationsTitle).padding() }
            )
        }
    }
    
    private var failureView: some View {
        VStack {
            Text(viewModel.errorMessage)
            if viewModel.showRetryButton {
                Button(
                    action: { Task { await viewModel.loadData() }},
                    label: { Text(viewModel.retryTitle).padding() }
                )
            }
        }
        .padding(24)
    }
    
    private var loadingView: some View {
        Text(viewModel.loadingTitle)
    }
}

#Preview {
    let viewModel = PlacesViewModel(
        service: MockLocationsGetService(),
        coordinator: MockMainCoordinator()
    )
    return PlacesView(viewModel: viewModel)
}
