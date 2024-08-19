//
//  AddLocationView.swift
//  Places
//
//  Created by Ranjeet Balkawade on 15/08/2024.
//

import SwiftUI

struct AddLocationView: View {
    
    enum Field: Hashable {
        case text
    }
    
    //MARK: - Internal properties
    
    @ObservedObject var viewModel: AddLocationViewModel
    
    //MARK: - Private properties
    
    @State private var name = ""
    @State private var latitude = ""
    @State private var longitude = ""
    @AccessibilityFocusState private var focusedField: Field?
    
    //MARK: - Internal Views
    
    var body: some View {
        VStack(spacing: 24) {
            Text(viewModel.title)
                .font(.headline)
                .multilineTextAlignment(.center)
            VStack(spacing: 8) {
                TextField(viewModel.namePlaceHolder, text: $name)
                    .keyboardType(.asciiCapable)
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
                    .accessibilityFocused($focusedField, equals: .text)
            }
            Spacer()
            Button(viewModel.addButtonTitle) {
                viewModel.addLocation(
                    name: name,
                    latitude: latitude,
                    longitude: longitude
                )
                focusedField = .text
            }
        }
        .padding(24)
    }
}

#Preview {
    AddLocationView(viewModel: AddLocationViewModel(coordinator: MockMainCoordinator(), completion: {_ in}))
}
