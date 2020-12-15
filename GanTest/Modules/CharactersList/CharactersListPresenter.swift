//
//  CharactersPresenter.swift
//  GanTest
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import Foundation
protocol CharactersListPresenterInterface {
    func show(data: [CharacterRemoteModel])
    func loadingData()
    func show(error: String)
}

class CharactersListPresenter: CharactersListPresenterInterface {

    var view: CharactersListViewControllerInterface?
    
    // MARK: - Show Loading
    func loadingData() {
        view?.spinnerView(add: true)

    }
    
    // MARK: - Show Data
    func show(data: [CharacterRemoteModel]) {
        let charactersViewModel = CharacterListViewModel(models: data)
        view?.spinnerView(add: false)

        view?.displayFetchedData(viewModel: charactersViewModel)
    }
    
    // MARK: - Show error
    func show(error: String) {
        let errorAlertData = AlertViewModel(title: "An error has occurred", subtitle: error, acceptTitle: "Ok", cancelTitle: nil)
        view?.showErrorAlert(alertViewModel: errorAlertData)

    }

    
}
