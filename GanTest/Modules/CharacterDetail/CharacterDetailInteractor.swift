//
//  CharacterDetailInteractor.swift
//  GanTest
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import Foundation
protocol CharacterDetailInteractorInterface {
    func viewLoaded()
}

protocol CharacterDetailDataStore {
    var characterDetail: CharacterViewModel? { get set }
    var error: CharacterDetailError? { get }
}

class CharacterDetailInteractor: CharacterDetailInteractorInterface, CharacterDetailDataStore {
 
    var presenter: CharacterDetailPresenterInterface?
    var characterDetail: CharacterViewModel?
    var error: CharacterDetailError?
    
    // MARK: - Fetch Currencies

    func viewLoaded() {
        if let characterdetail = characterDetail {
            presenter?.show(characterDetail: characterdetail)

        }
    }
    
}
