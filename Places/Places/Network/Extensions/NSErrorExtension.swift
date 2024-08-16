//
//  NSErrorExtension.swift
//  Places
//
//  Created by Ranjeet Balkawade on 16/08/2024.
//

import Foundation

extension NSError {
    func converToDataError() -> DataError {
        switch code {
            case NSURLErrorNotConnectedToInternet, NSURLErrorCannotConnectToHost, NSURLErrorNetworkConnectionLost, NSURLErrorDNSLookupFailed:
                return DataError.internetConnectivity
            case NSURLErrorTimedOut:
                return DataError.timeout
            default:
                return DataError.general
        }
    }
}
