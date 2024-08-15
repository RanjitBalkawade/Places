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
                case .successView:
                    successView
                case .failureView:
                    failureView
                case .loading:
                    loadingView
            }
        }.task {
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
                        ForEach(viewModel.placeItemViewModels) {
                            Text($0.name)
                        }
                    }
                }
                
                if viewModel.userDefinedPlaceItemViewModels.isEmpty == false {
                    Section(header: Text("User defined locations")) {
                        ForEach(viewModel.userDefinedPlaceItemViewModels) {
                            Text($0.name)
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
        Text("Failed to load data")
    }
    
    private var loadingView: some View {
        Text("Loading...")
    }
}

#Preview {
    let viewModel = PlacesViewModel(service: MockLocationsGetService(), coordinator: MockMainCoordinator())
    return PlacesView(viewModel: viewModel)
}
