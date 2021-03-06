//
//  DisconnectV1Message.swift
//  BeaconSDK
//
//  Created by Julia Samol on 13.11.20.
//  Copyright © 2020 Papers AG. All rights reserved.
//

import Foundation

extension Beacon.Message.Versioned.V1 {
    
    struct Disconnect: V1MessageProtocol, Equatable, Codable {
        let type: `Type`
        let version: String
        let id: String
        let beaconID: String
        
        init(version: String, id: String, beaconID: String) {
            type = .disconnectMessage
            self.version = version
            self.id = id
            self.beaconID = beaconID
        }
        
        // MARK: BeaconMessage Compatibility
        
        init(from beaconMessage: Beacon.Message.Disconnect, senderID: String) {
            self.init(version: beaconMessage.version, id: beaconMessage.id, beaconID: beaconMessage.senderID)
        }
        
        func toBeaconMessage(
            with origin: Beacon.Origin,
            using storageManager: StorageManager,
            completion: @escaping (Result<Beacon.Message, Error>) -> ()
        ) {
            let message = Beacon.Message.Disconnect(id: id, senderID: beaconID, version: version, origin: origin)
            completion(.success(.disconnect(message)))
        }
        
        // MARK: Codable
        
        enum CodingKeys: String, CodingKey {
            case type
            case version
            case id
            case beaconID = "beaconId"
        }
    }
}
