//
//  Errors.swift
//  GanTest
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import Foundation
enum NetworkError: Error, Equatable {
    case noNetwork
    case timeout
    case noResponse
    case serverError
    case invalidURL
    case formatError
    case noData
    case notJSONData
    case incorrectJSONFormat
    case serviceError(reason: String)
    case other(reason: String)
    case unknown
    
}

enum CharacterListError: Error, Equatable {
    case networkError
    case other(reason: String)
    case unknown
    
}


enum CharacterDetailError: Error, Equatable {
    case other(reason: String)
    case unknown
    
}
