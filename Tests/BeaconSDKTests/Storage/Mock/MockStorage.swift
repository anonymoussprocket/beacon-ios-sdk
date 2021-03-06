//
//  MockStorage.swift
//  BeaconSDKTests
//
//  Created by Julia Samol on 12.11.20.
//  Copyright © 2020 Papers AG. All rights reserved.
//

@testable import BeaconSDK

class MockStorage: Storage {
    var peers: [Beacon.Peer] = []
    var appMetadata: [Beacon.AppMetadata] = []
    var permissions: [Beacon.Permission] = []
    var matrixSyncToken: String?
    var matrixRooms: [Matrix.Room] = []
    var sdkVersion: String?
    
    func getPeers(completion: @escaping (Result<[Beacon.Peer], Error>) -> ()) {
        completion(.success(peers))
    }
    
    func set(_ peers: [Beacon.Peer], completion: @escaping (Result<(), Error>) -> ()) {
        self.peers = peers
        completion(.success(()))
    }
    
    func getAppMetadata(completion: @escaping (Result<[Beacon.AppMetadata], Error>) -> ()) {
        completion(.success(appMetadata))
    }
    
    func set(_ appMetadata: [Beacon.AppMetadata], completion: @escaping (Result<(), Error>) -> ()) {
        self.appMetadata = appMetadata
        completion(.success(()))
    }
    
    func getPermissions(completion: @escaping (Result<[Beacon.Permission], Error>) -> ()) {
        completion(.success(permissions))
    }
    
    func set(_ permissions: [Beacon.Permission], completion: @escaping (Result<(), Error>) -> ()) {
        self.permissions = permissions
        completion(.success(()))
    }
    
    func getMatrixSyncToken(completion: @escaping (Result<String?, Error>) -> ()) {
        completion(.success(matrixSyncToken))
    }
    
    func setMatrixSyncToken(_ token: String, completion: @escaping (Result<(), Error>) -> ()) {
        self.matrixSyncToken = token
        completion(.success(()))
    }
    
    func getMatrixRooms(completion: @escaping (Result<[Matrix.Room], Error>) -> ()) {
        completion(.success(matrixRooms))
    }
    
    func set(_ rooms: [Matrix.Room], completion: @escaping (Result<(), Error>) -> ()) {
        self.matrixRooms = rooms
        completion(.success(()))
    }
    
    func getSDKVersion(completion: @escaping (Result<String?, Error>) -> ()) {
        completion(.success(sdkVersion))
    }
    
    func setSDKVersion(_ version: String, completion: @escaping (Result<(), Error>) -> ()) {
        sdkVersion = version
        completion(.success(()))
    }
}
