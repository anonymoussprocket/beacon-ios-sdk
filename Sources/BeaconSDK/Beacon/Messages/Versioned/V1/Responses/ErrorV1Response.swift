//
//  ErrorV1Response.swift
//  BeaconSDK
//
//  Created by Julia Samol on 13.11.20.
//  Copyright © 2020 Papers AG. All rights reserved.
//

import Foundation

extension Beacon.Message.Versioned.V1 {
    
    struct ErrorResponse: V1MessageProtocol, Equatable, Codable {
        let type: `Type`
        let version: String
        let id: String
        let beaconID: String
        let errorType: Beacon.ErrorType
        
        init(version: String, id: String, beaconID: String, errorType: Beacon.ErrorType) {
            type = .errorResponse
            self.version = version
            self.id = id
            self.beaconID = beaconID
            self.errorType = errorType
        }
        
        // MARK: BeaconMessage Compatibility
        
        init(from beaconMessage: Beacon.Response.Error, senderID: String) {
            self.init(version: beaconMessage.version, id: beaconMessage.id, beaconID: senderID, errorType: beaconMessage.errorType)
        }
        
        func toBeaconMessage(
            with origin: Beacon.Origin,
            using storageManager: StorageManager,
            completion: @escaping (Result<Beacon.Message, Error>) -> ()
        ) {
            let message = Beacon.Response.Error(id: id, errorType: errorType, version: version, requestOrigin: origin)
            completion(.success(.response(.error(message))))
        }
        
        // MARK: Codable
        
        enum CodingKeys: String, CodingKey {
            case type
            case version
            case id
            case beaconID = "beaconId"
            case errorType
        }
    }
}
