//
//  AddLocationView.swift
//  Places
//
//  Created by Ranjeet Balkawade on 15/08/2024.
//

import SwiftUI

struct AddLocationView: View {
    
    @ObservedObject var viewModel: AddLocationViewModel
    @AccessibilityFocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case text
    }
    
    @State var name = ""
    @State var latitude = ""
    @State var longitude = ""
    
    var body: some View {
        VStack(spacing: 24) {
            Text(viewModel.title)
                .font(.headline)
                .multilineTextAlignment(.center)
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
