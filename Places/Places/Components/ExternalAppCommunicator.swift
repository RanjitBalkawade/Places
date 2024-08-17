//
//  ExternalAppCommunicator.swift
//  Places
//
//  Created by Ranjeet Balkawade on 17/08/2024.
//

import Foundation
import UIKit

protocol ExternalAppCommunicatorProtocol {
    func openPlaces(app: ExternalApp, latitude: Double, longitude: Double, completionHandler: ((Bool) -> Void)?)
    func showInstallLink(app: ExternalApp)
}

enum ExternalApp {
    case wikipedia
    
    var name: String {
        switch self {
            case .wikipedia:
                return "Wikipedia"
        }
    }
    var urlScheme: String {
        switch self {
            case .wikipedia:
                return "wikipedia"
        }
    }
    
    var installLink: String {
        switch self {
            case .wikipedia:
                return "https://apps.apple.com/nl/app/wikipedia/id324715238?l=en-GB"
        }
    }
}

class ExternalAppCommunicator: ExternalAppCommunicatorProtocol {
    
    func openPlaces(app: ExternalApp, latitude: Double, longitude: Double, completionHandler: ((Bool) -> Void)?) {
        var urlComponents = URLComponents()
        urlComponents.scheme = app.urlScheme
        urlComponents.host = "places"
        
        let latQueryItem = URLQueryItem(name: "lat", value: String(latitude))
        let lonQueryItem = URLQueryItem(name: "lon", value: String(longitude))
        urlComponents.queryItems = [latQueryItem, lonQueryItem]
        
        guard let url = urlComponents.url else {
            return
        }
        
        UIApplication.shared.open(url, completionHandler: completionHandler)
    }
    
    func showInstallLink(app: ExternalApp) {
        guard let url = URL(string: app.installLink) else {
            return
        }
        return UIApplication.shared.open(url)
    }
    
}
