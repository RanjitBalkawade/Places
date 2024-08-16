//
//  DataError.swift
//  Places
//
//  Created by Ranjeet Balkawade on 16/08/2024.
//

import Foundation

enum DataError: Error {
    case server
    case client
    case rediret
    case information
    case decoding
    case internetConnectivity
    case timeout
    case invalidURLRequest
    case general
    case unknown
}
