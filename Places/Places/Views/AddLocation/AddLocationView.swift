//
//  AddLocationView.swift
//  Places
//
//  Created by Ranjeet Balkawade on 15/08/2024.
//

import SwiftUI

struct AddLocationView: View {
    
    var viewModel: AddLocationViewModel
    
    var body: some View {
        Text("Hello")
    }
}

#Preview {
    AddLocationView(viewModel: AddLocationViewModel(coordinator: MockMainCoordinator()))
}
