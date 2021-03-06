//
//  V1Message.swift
//  BeaconSDK
//
//  Created by Julia Samol on 13.11.20.
//  Copyright © 2020 Papers AG. All rights reserved.
//

import Foundation

extension Beacon.Message.Versioned {
    
    enum V1: Equatable, Codable {
        case permissionRequest(PermissionRequest)
        case operationRequest(OperationRequest)
        case signPayloadRequest(SignPayloadRequest)
        case broadcastRequest(BroadcastRequest)
        case permissionResponse(PermissionResponse)
        case operationResponse(OperationResponse)
        case signPayloadResponse(SignPayloadResponse)
        case broadcastResponse(BroadcastResponse)
        case errorResponse(ErrorResponse)
        case disconnectMessage(Disconnect)
        
        // MARK: BeaconMessage Compatibility
        
        init(from beaconMessage: Beacon.Message, senderID: String) throws {
            switch beaconMessage {
            case let .request(request):
                switch request {
                case let .permission(content):
                    self = .permissionRequest(PermissionRequest(from: content, senderID: senderID))
                case let .operation(content):
                    self = .operationRequest(OperationRequest(from: content, senderID: senderID))
                case let .signPayload(content):
                    self = .signPayloadRequest(SignPayloadRequest(from: content, senderID: senderID))
                case let .broadcast(content):
                    self = .broadcastRequest(BroadcastRequest(from: content, senderID: senderID))
                }
            case let .response(response):
                switch response {
                case let .permission(content):
                    self = .permissionResponse(PermissionResponse(from: content, senderID: senderID))
                case let .operation(content):
                    self = .operationResponse(OperationResponse(from: content, senderID: senderID))
                case let .signPayload(content):
                    self = .signPayloadResponse(SignPayloadResponse(from: content, senderID: senderID))
                case let .broadcast(content):
                    self = .broadcastResponse(BroadcastResponse(from: content, senderID: senderID))
                case let .acknowledge(content):
                    throw Beacon.Error.messageNotSupportedInVersion(message: beaconMessage, version: content.version)
                case let .error(content):
                    self = .errorResponse(ErrorResponse(from: content, senderID: senderID))
                }
            case let .disconnect(content):
                self = .disconnectMessage(Disconnect(from: content, senderID: senderID))
            }
        }
        
        // MARK: Attributes
        
        var common: V1MessageProtocol {
            switch self {
            case let .permissionRequest(content):
                return content
            case let .operationRequest(content):
                return content
            case let .signPayloadRequest(content):
                return content
            case let .broadcastRequest(content):
                return content
            case let .permissionResponse(content):
                return content
            case let .operationResponse(content):
                return content
            case let .signPayloadResponse(content):
                return content
            case let .broadcastResponse(content):
                return content
            case let .errorResponse(content):
                return content
            case let .disconnectMessage(content):
                return content
            }
        }
        
        // MARK: Codable
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(`Type`.self, forKey: .type)
            switch type {
            case .permissionRequest:
                self = .permissionRequest(try PermissionRequest(from: decoder))
            case .operationRequest:
                self = .operationRequest(try OperationRequest(from: decoder))
            case .signPayloadRequest:
                self = .signPayloadRequest(try SignPayloadRequest(from: decoder))
            case .broadcastRequest:
                self = .broadcastRequest(try BroadcastRequest(from: decoder))
            case .permissionResponse:
                self = .permissionResponse(try PermissionResponse(from: decoder))
            case .operationResponse:
                self = .operationResponse(try OperationResponse(from: decoder))
            case .signPayloadResponse:
                self = .signPayloadResponse(try SignPayloadResponse(from: decoder))
            case .broadcastResponse:
                self = .broadcastResponse(try BroadcastResponse(from: decoder))
            case .errorResponse:
                self = .errorResponse(try ErrorResponse(from: decoder))
            case .disconnectMessage:
                self = .disconnectMessage(try Disconnect(from: decoder))
            }
        }
        
        func encode(to encoder: Encoder) throws {
            switch self {
            case let .permissionRequest(content):
                try content.encode(to: encoder)
            case let .operationRequest(content):
                try content.encode(to: encoder)
            case let .signPayloadRequest(content):
                try content.encode(to: encoder)
            case let .broadcastRequest(content):
                try content.encode(to: encoder)
            case let .permissionResponse(content):
                try content.encode(to: encoder)
            case let .operationResponse(content):
                try content.encode(to: encoder)
            case let .signPayloadResponse(content):
                try content.encode(to: encoder)
            case let .broadcastResponse(content):
                try content.encode(to: encoder)
            case let .errorResponse(content):
                try content.encode(to: encoder)
            case let .disconnectMessage(content):
                try content.encode(to: encoder)
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case type
        }
        
        enum `Type`: String, Codable {
            case permissionRequest = "permission_request"
            case operationRequest = "operation_request"
            case signPayloadRequest = "sign_payload_request"
            case broadcastRequest = "broadcast_request"
            case permissionResponse = "permission_response"
            case operationResponse = "operation_response"
            case signPayloadResponse = "sign_payload_response"
            case broadcastResponse = "broadcast_response"
            case errorResponse = "error"
            case disconnectMessage = "disconnect"
        }
    }
}

// MARK: Protocol

protocol V1MessageProtocol: VersionedMessageProtocol {
    var type: Beacon.Message.Versioned.V1.`Type` { get }
}
