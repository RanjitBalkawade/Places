//
//  PlacesView.swift
//  Places
//
//  Created by Ranjeet Balkawade on 14/08/2024.
//

import SwiftUI

struct PlacesView: View {
    @StateObject var viewModel: PlacesViewModel
    
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
        }
    }
    
    private var successView: some View {
        Text("Success")
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
