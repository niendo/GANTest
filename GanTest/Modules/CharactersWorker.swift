//
//  CharactersWorkers.swift
//  GanTest
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import Foundation
class CharactersWorker {

    var remote: CharacterRemoteStoreProtocol?

    init(remote: CharacterRemoteStoreProtocol) {
        self.remote = remote
        
    }
    
    // MARK: - Remote data fetch
    func fetchData(completionHandler: @escaping ([CharacterRemoteModel]?, Error?) -> Void) {
        
        self.remote?.get(completionHandler: { (result, error) in
            DispatchQueue.main.async {
                completionHandler(result,error)
            }
        })
    }
}
