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
                case .failureViewWithRetry:
                    failureViewWithRetry
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
                    Section(header: Text("Locations")) {
                        ForEach(viewModel.placeItemViewModels) { vm in
                            Text(vm.name)
                                .onTapGesture {
                                    viewModel.showLocation(vm)
                                }
                        }
                    }
                }
                
                if viewModel.userDefinedPlaceItemViewModels.isEmpty == false {
                    Section(header: Text("User defined locations")) {
                        ForEach(viewModel.userDefinedPlaceItemViewModels) { vm in
                            Text(vm.name)
                                .onTapGesture {
                                    viewModel.showLocation(vm)
                                }
                        }
                    }
                }
            }
            Button(
                action: { viewModel.showAddLocation() },
                label: { Text("Add location").padding() }
            )
        }
    }
    
    private var failureView: some View {
        Text(viewModel.errorMessage)
            .padding(24)
    }
    
    private var failureViewWithRetry: some View {
        VStack {
            Text(viewModel.errorMessage)
            Button(
                action: { Task { await viewModel.loadData() }},
                label: { Text("Try again").padding() }
            )
        }
        .padding(24)
    }
    
    private var loadingView: some View {
        Text("Loading...")
    }
}

#Preview {
    let viewModel = PlacesViewModel(service: MockLocationsGetService(), coordinator: MockMainCoordinator())
    return PlacesView(viewModel: viewModel)
}
