//
//  URLSessionProtocol.swift
//  WalmartAssignment
//
//  Created by radha chilamkurthy on 25/04/22.
//

import Foundation

protocol URLSessionProtocol {
    
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
    
    func dataTaskPublisher(for url: URL) -> URLSession.DataTaskPublisher
    
    func getAllTasks(completionHandler: @escaping ([URLSessionTask]) -> Void)
    
    func invalidateAndCancel()
}

extension URLSession: URLSessionProtocol {}
