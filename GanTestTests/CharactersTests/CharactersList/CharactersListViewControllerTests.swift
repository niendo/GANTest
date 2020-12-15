//
//  CharactersListViewControllerTests.swift
//  GanTestTests
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import XCTest
@testable import GanTest

class CharactersListViewControllerTests: XCTestCase {
    
    var sut: CharactersListViewController!
    var interactor: CharactersListInteractorMock!
    var window: UIWindow!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        window = UIWindow()
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "charactersList") as? CharactersListViewController
        interactor = CharactersListInteractorMock()
        sut.interactor = interactor
        
    }

    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    override func tearDownWithError() throws {
        sut = nil
        interactor = nil
        window = nil
        try super.tearDownWithError()
    }
    
    func testViewShouldFetchDataWhenLoadedOk() {
        loadView()

        XCTAssert(interactor.fetchDataCalled, "Should fetch when the view is loaded")
    }
    
    func testViewShouldDisplayDataWhenFetchedOk() {
        loadView()

        let remoteModel = [CharacterRemoteModel(char_id: 1, name: "name", birthday: "birthday", occupation: ["Occupation"], img: "Img", status: "status", nickname: "nickname", appearance: [1], portrayed: "portrayed", category: "category", better_call_saul_appearance: [1])]

        let viewModel = CharacterListViewModel(models: remoteModel)
        sut.displayFetchedData(viewModel: viewModel)
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), viewModel.charactersViewModel?.count)

    }
    
    func testViewShouldDisplayDataWhenFilteredOk() {
        loadView()

        let remoteModel = [CharacterRemoteModel(char_id: 1, name: "name", birthday: "birthday", occupation: ["Occupation"], img: "Img", status: "status", nickname: "nickname", appearance: [1], portrayed: "portrayed", category: "category", better_call_saul_appearance: [1])]

        let viewModel = CharacterListViewModel(models: remoteModel)
        sut.displayFilteredData(viewModel: viewModel)
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), viewModel.charactersViewModel?.count)

    }
    
    func testViewShouldDisplayErrorOk() {
        loadView()
        let alertviewModel = AlertViewModel(title: "title", subtitle: "subtitle", acceptTitle: "accept", cancelTitle: nil)
       
        sut.showErrorAlert(alertViewModel: alertviewModel)
        
        XCTAssertTrue(sut.alert?.isBeingPresented ?? false, "Alert should be presented")

    }
    
    func testViewShouldDisplayLoadingOk() {
        loadView()
       
       
        sut.spinnerView(add: true)
        
        XCTAssertTrue(sut.spinner?.isViewLoaded ?? false, "spinner should be presented")

    }
    
    
}
