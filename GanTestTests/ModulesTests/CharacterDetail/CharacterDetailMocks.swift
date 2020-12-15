//
//  CharacterDetailMocks.swift
//  GanTestTests
//
//  Created by Eduardo Nieto on 15/12/2020.
//

@testable import GanTest

class CharacterDetailInteractorMock: CharacterDetailInteractorInterface {

    var viewDidLoadCalled = false
    func viewLoaded() {
        viewDidLoadCalled = true
    }
}


class CharacterDetailPresenterMock: CharacterDetailPresenterInterface {
    var showDataCalled = false
    var showErrorCalled = false

    
    func show(characterDetail: CharacterViewModel) {
        showDataCalled = true
    }
    
    func showFileLoading(error: CharacterDetailError) {
        showErrorCalled = true
    }
}


class CharacterDetailViewControllerMock: CharacterDetailViewControllerInterface {

    var displayCharacterDetail = false
    var showErrorAlert = false

    func displayCharacterDetail(viewModel: CharacterViewModel) {
        displayCharacterDetail = true
    }
    
    func showErrorAlert(alertViewModel: AlertViewModel) {
        showErrorAlert = true
    }
    

}
