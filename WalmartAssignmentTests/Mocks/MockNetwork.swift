//
//  MockNetwork.swift
//  WalmartAssignmentTests
//
//  Created by radha chilamkurthy on 25/04/22.
//

@testable
import WalmartAssignment
import Foundation
import Combine

final class BundleClass {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
}

struct MockNetwork: NetworkProtocol {
    
    var isInternetReachable: Bool
    var isSuccess: Bool
    var errorType: NetworkError? = nil
    
    var mockNasaAstronomyData: Data? {
        guard let ressourceURL =  BundleClass().bundle.url(forResource: "AstronomyResponse", withExtension: "json") else {
            return nil
        }
        let jsonData = try? Data(contentsOf: ressourceURL)
        return jsonData
    }
    
    var expectedAstronomyModel: NasaAstronomy? {
        guard let jsonData =  mockNasaAstronomyData,
              let model = try? JSONDecoder().decode(NasaAstronomy.self, from: jsonData)else {
                  return nil
              }
        
        return model
    }

    func request(for request: URLRequest,
                 receive: DispatchQueue) -> AnyPublisher<Data, NetworkError> {
        
        if isSuccess {
            return Just(mockNasaAstronomyData!)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: errorType ?? .unknown)
                .eraseToAnyPublisher()
        }
    }
    
    func request(for url: URL, receive: DispatchQueue) -> AnyPublisher<Data, NetworkError> {
        
        if isSuccess {
            return Just(mockNasaAstronomyData!)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: errorType ?? .unknown)
                .eraseToAnyPublisher()
        }
    }
}