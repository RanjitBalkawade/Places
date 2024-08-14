//
//  PlacesViewController.swift
//  Places
//
//  Created by Ranjeet Balkawade on 14/08/2024.
//

import UIKit
import SwiftUI

class PlacesViewController: UIHostingController<PlacesView> {
    
    init() {
        super.init(rootView: PlacesView())
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
