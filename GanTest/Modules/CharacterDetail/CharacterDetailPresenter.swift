//
//  CharacterDetailPresenter.swift
//  GanTest
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import Foundation
protocol CharacterDetailPresenterInterface {
    func show(characterDetail: CharacterViewModel)
    func showFileLoading(error: CharacterDetailError)
}

class CharacterDetailPresenter: CharacterDetailPresenterInterface {
    
    weak var view: CharacterDetailViewControllerInterface?
    
    // MARK: - Show character detail

    func show(characterDetail: CharacterViewModel) {

       
        view?.displayCharacterDetail(viewModel: characterDetail)
    }
    
    // MARK: - Views logic

    
    
    func showFileLoading(error: CharacterDetailError) {
        let alertViewModel = AlertViewModel(title: "Character", subtitle: "No character to show", acceptTitle: "Ok", cancelTitle: nil)
        view?.showErrorAlert(alertViewModel: alertViewModel)
    }
    



}
