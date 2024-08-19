//
//  MockExternalAppCommunicator.swift
//  PlacesTests
//
//  Created by Ranjeet Balkawade on 17/08/2024.
//

import Foundation
@testable import Places

final class MockExternalAppCommunicator: ExternalAppCommunicatorProtocol {
    
    //MARK: - Internal properties
    
    var showInstallLinkCalled = false
    var passedApp: ExternalApp?
    
    var openPlacesCalled = false
    var passedLatitude: Double?
    var passedLongitude: Double?
    var passedCompletionHandler: ((Bool) -> Void)?
    
    //MARK: - Internal methods
    
    func showInstallLink(app: ExternalApp) {
        showInstallLinkCalled = true
        passedApp = app
    }
    
    func openPlaces(app: ExternalApp, latitude: Double, longitude: Double, completionHandler: ((Bool) -> Void)?) {
        openPlacesCalled = true
        passedApp = app
        passedLatitude = latitude
        passedLongitude = longitude
        passedCompletionHandler = completionHandler
    }
}
