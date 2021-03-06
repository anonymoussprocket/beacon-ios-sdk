//
//  SignPayloadV2Response.swift
//  BeaconSDK
//
//  Created by Julia Samol on 13.11.20.
//  Copyright © 2020 Papers AG. All rights reserved.
//

import Foundation

extension Beacon.Message.Versioned.V2 {
    
    struct SignPayloadResponse: V2MessageProtocol, Equatable, Codable {
        let type: `Type`
        let version: String
        let id: String
        let senderID: String
        let signingType: Beacon.SigningType
        let signature: String
        
        init(version: String, id: String, senderID: String, signingType: Beacon.SigningType, signature: String) {
            type = .signPayloadResponse
            self.version = version
            self.id = id
            self.signingType = signingType
            self.senderID = senderID
            self.signature = signature
        }
        
        // MARK: BeaconMessage Compatibility
        
        init(from beaconMessage: Beacon.Response.SignPayload, senderID: String) {
            self.init(
                version: beaconMessage.version,
                id: beaconMessage.id,
                senderID: senderID,
                signingType: beaconMessage.signingType,
                signature: beaconMessage.signature
            )
        }
        
        func toBeaconMessage(
            with origin: Beacon.Origin,
            using storageManager: StorageManager,
            completion: @escaping (Result<Beacon.Message, Error>) -> ()
        ) {
            let message = Beacon.Response.SignPayload(
                id: id,
                signingType: signingType,
                signature: signature,
                version: version,
                requestOrigin: origin
            )
            
            completion(.success(.response(.signPayload(message))))
        }
        
        // MARK: Codable
        
        enum CodingKeys: String, CodingKey {
            case type
            case version
            case id
            case senderID = "senderId"
            case signingType
            case signature
        }
    }
}
