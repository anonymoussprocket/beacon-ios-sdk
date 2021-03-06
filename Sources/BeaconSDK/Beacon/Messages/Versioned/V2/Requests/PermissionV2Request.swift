//
//  PermissionV2Request.swift
//  BeaconSDK
//
//  Created by Julia Samol on 13.11.20.
//  Copyright © 2020 Papers AG. All rights reserved.
//

import Foundation

extension Beacon.Message.Versioned.V2 {
    
    struct PermissionRequest: V2MessageProtocol, Equatable, Codable {
        let type: `Type`
        let version: String
        let id: String
        let senderID: String
        let appMetadata: AppMetadata
        let network: Beacon.Network
        let scopes: [Beacon.Permission.Scope]
        
        init(
            version: String,
            id: String,
            senderID: String,
            appMetadata: AppMetadata,
            network: Beacon.Network,
            scopes: [Beacon.Permission.Scope]
        ) {
            type = .permissionRequest
            self.version = version
            self.id = id
            self.senderID = senderID
            self.appMetadata = appMetadata
            self.network = network
            self.scopes = scopes
        }
        
        // MARK: BeaconMessage Compatibility
        
        init(from beaconMessage: Beacon.Request.Permission, senderID: String) {
            self.init(
                version: beaconMessage.version,
                id: beaconMessage.id,
                senderID: senderID,
                appMetadata: AppMetadata(from: beaconMessage.appMetadata),
                network: beaconMessage.network,
                scopes: beaconMessage.scopes
            )
        }
        
        func toBeaconMessage(
            with origin: Beacon.Origin,
            using storageManager: StorageManager,
            completion: @escaping (Result<Beacon.Message, Error>) -> ()
        ) {
            let message = Beacon.Request.Permission(
                id: id,
                senderID: senderID,
                appMetadata: appMetadata.toAppMetadata(),
                network: network,
                scopes: scopes,
                origin: origin,
                version: version
            )
            
            completion(.success(.request(.permission(message))))
        }
        
        // MARK: Codable
        
        enum CodingKeys: String, CodingKey {
            case type
            case version
            case id
            case senderID = "senderId"
            case appMetadata
            case network
            case scopes
        }
    }
    
    // MARK: Types
    
    struct AppMetadata: Equatable, Codable {
        public let senderID: String
        public let name: String
        public let icon: String?
        
        init(from appMetadata: Beacon.AppMetadata) {
            self.senderID = appMetadata.senderID
            self.name = appMetadata.name
            self.icon = appMetadata.icon
        }
        
        func toAppMetadata() -> Beacon.AppMetadata {
            Beacon.AppMetadata(senderID: senderID, name: name, icon: icon)
        }
        
        enum CodingKeys: String, CodingKey {
            case senderID = "senderId"
            case name
            case icon
        }
    }
}
