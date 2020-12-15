//
//  RemoteStore.swift
//  GanTest
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import Foundation
typealias ServiceCompletionHandler = ([CharacterRemoteModel]?, Error?) -> Void

protocol CharacterRemoteStoreProtocol {
    func get(completionHandler: @escaping ServiceCompletionHandler)
}

class CharacterRemoteStore: CharacterRemoteStoreProtocol {
    
    // MARK: - get Data
    
    func get(completionHandler: @escaping ServiceCompletionHandler) {
        
        var datatask : URLSessionDataTask?
        let url = "https://breakingbadapi.com/api/characters"
        let components = URLComponents(string: url)

        guard let componentsURL = components?.url else {
            completionHandler(nil, NetworkError.invalidURL)
            return
        }
        let request =  URLRequest(url: componentsURL)
           
        datatask = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            if let error = error {
                completionHandler(nil,error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {

                switch httpResponse.statusCode {
                case 200:
                    guard let data = data else {
                        completionHandler(nil,NetworkError.noData)
                        return
                    }
                    
                    if let jsonString = String(data: data, encoding: .utf8) {

                        let jsonData = jsonString.data(using: .utf8)!
                        let data = try? JSONDecoder().decode([CharacterRemoteModel].self, from: jsonData)
                        completionHandler(data, nil)



                    } else {
                        completionHandler(nil,NetworkError.notJSONData)
                    }
                case 400:
                    completionHandler(nil,NetworkError.formatError)

                case 500:
                    completionHandler(nil,NetworkError.serverError)

                default:
                    completionHandler(nil,NetworkError.unknown)
                }
            }
            
            
        })
        datatask?.resume()
        
    }
}
