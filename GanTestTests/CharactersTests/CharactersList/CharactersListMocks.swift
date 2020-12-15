//
//  CharacterListMocks.swift
//  GanTestTests
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import Foundation
@testable import GanTest

class CharactersListInteractorMock: CharactersListInteractorInterface {
    
    var fetchDataCalled = false
    var getAllCharactersCalled = false
    var getCharactersInSeasonCalled = false
    var filterCharactersByNameCalled = false
    var selectCharacterCalled = false

    
    func fetchData() {
        fetchDataCalled = true
    }
    
    func getAllCharacters() {
        getAllCharactersCalled = true
    }
    
    func getCharactersIn(season: Int) {
        getCharactersInSeasonCalled = true
    }
    
    func filterCharactersByName(_ nameChar: String) {
        filterCharactersByNameCalled = true
    }
    
    func select(character: CharacterViewModel) {
        selectCharacterCalled = true
    }
}


class CharactersListPresenterMock: CharactersListPresenterInterface {

    

    var showDataCalled = false
    var showLoadingCalled = false
    var showErrorCalled = false
    var filterSeasonCalled = false
    var filterNameCalled = false
    var numberOfElementsShown = 0

    
    func show(data: [CharacterRemoteModel]) {
        showDataCalled = true
        numberOfElementsShown = data.count
    }

    func loadingData() {
        showLoadingCalled = true
    }

    func show(error: String) {
        showErrorCalled = true
    }
    
    func filter(season: Int) {
        filterSeasonCalled = true
    }
    
    func filter(charName: String) {
        filterNameCalled = true
    }
}


class CharactersListViewControllerMock: CharactersListViewControllerInterface {

    var displayFetchedDataCalled = false
    var spinnerViewCalled = false
    var showErrorAlertCalled = false
    var displayFilteredDataCalled = false
    var numberOfElementsShown = 0
    var spinnerIsShowing = false

    func displayFetchedData(viewModel: CharacterListViewModel) {
        numberOfElementsShown = viewModel.charactersViewModel?.count ?? 0
        displayFetchedDataCalled = true
    }
    
    func spinnerView(add: Bool) {
        spinnerIsShowing = add
        spinnerViewCalled = true
    }
    
    func showErrorAlert(alertViewModel: AlertViewModel) {
        showErrorAlertCalled = true
    }
    
    func displayFilteredData(viewModel: CharacterListViewModel) {
        numberOfElementsShown = viewModel.charactersViewModel?.count ?? 0

        displayFilteredDataCalled = true
    }
}



class RemoteStoreMock: CharacterRemoteStoreProtocol {

    var getDataCalled = false

    func get(completionHandler: @escaping ServiceCompletionHandler) {
        getDataCalled = true
    }
}
