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
    }
    
    private var successView: some View {
        List {
            if let viewModels = viewModel.placeItemViewModels {
                Section(header: Text("Locations")) {
                    ForEach(viewModels) {
                        Text($0.name)
                    }
                }
            }
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
    let viewModel = PlacesViewModel(service: MockLocationsGetService())
    return PlacesView(viewModel: viewModel)
}
