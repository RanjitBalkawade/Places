//
//  AddLocationView.swift
//  Places
//
//  Created by Ranjeet Balkawade on 15/08/2024.
//

import SwiftUI

struct AddLocationView: View {
    
    @ObservedObject var viewModel: AddLocationViewModel
    @State var name = ""
    @State var latitude = ""
    @State var longitude = ""
    
    var body: some View {
        VStack(spacing: 24) {
            Text(viewModel.title)
                .font(.headline)
            Text(viewModel.message)
                .font(.subheadline)
            VStack(spacing: 8) {
                TextField(viewModel.namePlaceHolder, text: $name)
                TextField(viewModel.latitudePlaceHolder, text: $latitude)
                    .keyboardType(.decimalPad)
                TextField(viewModel.longitudePlaceHolder, text: $longitude)
                    .keyboardType(.decimalPad)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            if let error = viewModel.addLocationError {
                Text(error.description)
                    .font(.subheadline)
                    .foregroundStyle(.red)
            }
            Spacer()
            Button(viewModel.addButtonTitle) {
                viewModel.addLocation(
                    name: name,
                    latitude: latitude,
                    longitude: longitude
                )
            }
        }
        .padding(24)
    }
}

#Preview {
    AddLocationView(viewModel: AddLocationViewModel(coordinator: MockMainCoordinator(), completion: {_ in}))
}
