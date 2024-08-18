//
//  AddLocationViewModel.swift
//  Places
//
//  Created by Ranjeet Balkawade on 15/08/2024.
//

import Foundation

class AddLocationViewModel: ObservableObject {
    
    var title: String {
        "Please add details below to add new location."
    }
    
    var namePlaceHolder: String {
        "Name"
    }
    
    var latitudePlaceHolder: String {
        "Latitude"
    }
    
    var longitudePlaceHolder: String {
        "Longitude"
    }
    
    var addButtonTitle: String {
        "Add"
    }
    
    @Published private(set) var addLocationError: AddLocationError?
    var completion: ((Location) -> Void)
    
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    private let coordinator: MainCoordinatorProtocol
    
    init(coordinator: MainCoordinatorProtocol, completion: @escaping ((Location) -> Void)) {
        self.coordinator = coordinator
        self.completion = completion
    }

    func addLocation(name: String, latitude: String, longitude: String) {
        guard name.isEmpty == false else {
            addLocationError = .NameNotAdded
            return
        }
        
        guard latitude.isEmpty == false else {
            addLocationError = .LatitudeNotAdded
            return
        }
        
        guard longitude.isEmpty == false else {
            addLocationError = .LongitudeNotAdded
            return
        }
        
        guard let latNumber = numberFormatter.number(from: latitude) else {
            addLocationError = .wrongLatitude
            return
        }
        
        guard let longNumber = numberFormatter.number(from: longitude) else {
            addLocationError = .wrongLongitude
            return
        }
        addLocationError = nil
        
        completion(Location(name: name, lat: Double(truncating: latNumber), long: Double(truncating: longNumber)))
        coordinator.dismiss()
    }
}

extension AddLocationError {
    var description: String {
        switch self {
            case .NameNotAdded:
                return "Please enter name"
            case .LatitudeNotAdded:
                return "Please enter latitude"
            case .wrongLatitude:
                return "Please enter valid latitude"
            case .LongitudeNotAdded:
                return "Please enter longitude"
            case .wrongLongitude:
                return "Please enter valid longitude"
        }
    }
}

enum AddLocationError: Error {
    case NameNotAdded
    case LatitudeNotAdded
    case wrongLatitude
    case LongitudeNotAdded
    case wrongLongitude
}

