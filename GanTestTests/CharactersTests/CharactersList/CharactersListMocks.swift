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
    var selectCharacterCalled = false
    func fetchData() {
        fetchDataCalled = true
    }
    
    func select(character: CharacterViewModel) {
        selectCharacterCalled = true
    }
}


class CharactersListPresenterMock: CharactersListPresenterInterface {

    var showDataCalled = false
    var showLoadingCalled = false
    var showErrorCalled = false

    
    func show(data: [CharacterRemoteModel]) {
        showDataCalled = true
    }
    
    func loadingData() {
        showLoadingCalled = true
    }

    
    func show(error: String) {
        showErrorCalled = true
    }
}


class CharactersListViewControllerMock: CharactersListViewControllerInterface {

    var displayFetchedDataCalled = false
    var spinnerViewCalled = false
    var showErrorAlertCalled = false

    func displayFetchedData(viewModel: CharacterListViewModel) {
        displayFetchedDataCalled = true
    }
    
    func spinnerView(add: Bool) {
        spinnerViewCalled = true
    }
    
    func showErrorAlert(alertViewModel: AlertViewModel) {
        showErrorAlertCalled = true
    }
}

class RemoteStoreMock: CharacterRemoteStoreProtocol {

    var getDataCalled = false

    func get(completionHandler: @escaping ServiceCompletionHandler) {
        getDataCalled = true
    }
}
