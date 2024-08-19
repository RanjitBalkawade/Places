//
//  HTTPURLResponseExtension.swift
//  Places
//
//  Created by Ranjeet Balkawade on 16/08/2024.
//

import Foundation

extension HTTPURLResponse {
    
    //MARK: - Internal properties
    
    var hasInformationStatusCode: Bool {
        return 100...199 ~= self.statusCode
    }
    
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= self.statusCode
    }
    
    var hasRedirectStatusCode: Bool {
        return 300...399 ~= self.statusCode
    }
    
    var hasClientErrorStatusCode: Bool {
        return 400...499 ~= self.statusCode
    }
    
    var hasServerErrorStatusCode: Bool {
        return 500...599 ~= self.statusCode
    }
    
    func convertToDataError() -> DataError {
        if hasServerErrorStatusCode {
            return DataError.server
        } else if hasClientErrorStatusCode {
            return DataError.client
        } else if hasRedirectStatusCode {
            return DataError.rediret
        } else if hasInformationStatusCode {
            return DataError.information
        } else {
            return DataError.unknown
        }
    }
}
