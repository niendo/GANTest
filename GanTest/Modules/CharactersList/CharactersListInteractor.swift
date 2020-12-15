//
//  CharactersInteractor.swift
//  GanTest
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import Foundation
protocol CharactersListInteractorInterface {
    func fetchData()
    func select(character: CharacterViewModel)
}

protocol CharactersListDataStore {
    var characterDetail: CharacterViewModel? { get set }
    var error: CharacterDetailError? { get }
}

class CharactersListInteractor: CharactersListInteractorInterface, CharactersListDataStore {
    var characterDetail: CharacterViewModel?
    var error: CharacterDetailError?

    var presenter: CharactersListPresenterInterface?
    var worker: CharactersWorker?
    
    // MARK: - Fetch data
    func fetchData() {
        presenter?.loadingData()
        worker?.fetchData(completionHandler: { (result, error) in
            if let error = error {
                switch error {
                case CharacterListError.networkError:
                    self.presenter?.show(error: "There was an error with the network")
                default:
                    self.presenter?.show(error: "There was an unkown error")
                }
                
            }
            guard let data = result else {
                self.presenter?.show(error: "An error has ocurred fetching the information")
                return
            }
            
            self.presenter?.show(data: data)
        })
     
    }
    
    func select(character: CharacterViewModel) {
        self.characterDetail = character
    }

}
