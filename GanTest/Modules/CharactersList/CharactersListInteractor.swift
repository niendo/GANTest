//
//  CharactersInteractor.swift
//  GanTest
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import Foundation
protocol CharactersListInteractorInterface {
    func fetchData()
    func getAllCharacters()
    func getCharactersIn(season: Int)
    func filterCharactersByName(_ nameChar: String)
    func select(character: CharacterViewModel)
}

protocol CharactersListDataStore {
    var characterDetail: CharacterViewModel? { get set }
    var error: CharacterDetailError? { get }
}

class CharactersListInteractor: CharactersListInteractorInterface, CharactersListDataStore {

    var characterDetail: CharacterViewModel?
    var data: [CharacterRemoteModel]?
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
            self.data = data
            self.presenter?.show(data: data)
        })
     
    }
    
    // MARK: - Select character

    func select(character: CharacterViewModel) {
        self.characterDetail = character
    }
    // MARK: - Restore original data

    func getAllCharacters() {
        if let data = data {
            presenter?.show(data: data)
        }
    }
    // MARK: - Filters

    func getCharactersIn(season: Int) {
        presenter?.filter(season: season)
    }
    

    func filterCharactersByName(_ nameChar: String) {
        presenter?.filter(charName: nameChar)
    }


}
