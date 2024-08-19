//
//  PlacesViewController.swift
//  Places
//
//  Created by Ranjeet Balkawade on 14/08/2024.
//

import UIKit
import SwiftUI

final class PlacesViewController: UIHostingController<PlacesView> {
    
    //MARK: - Initializer
    
    init(_ viewModel: PlacesViewModel) {
        super.init(rootView: PlacesView(viewModel: viewModel))
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
