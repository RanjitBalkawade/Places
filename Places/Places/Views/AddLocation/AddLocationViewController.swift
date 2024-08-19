//
//  AddLocationViewController.swift
//  Places
//
//  Created by Ranjeet Balkawade on 15/08/2024.
//

import SwiftUI

final class AddLocationViewController: UIHostingController<AddLocationView> {
    
    //MARK: - Initializer
    
    init(_ viewModel: AddLocationViewModel) {
        super.init(rootView: AddLocationView(viewModel: viewModel))
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

