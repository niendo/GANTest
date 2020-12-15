//
//  CharactersListInteractorTests.swift
//  GanTestTests
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import XCTest
@testable import GanTest

class CharactersListInteractorTests: XCTestCase {
    
    var sut: CharactersListInteractor!
    var presenter: CharactersListPresenterMock!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CharactersListInteractor()
        presenter = CharactersListPresenterMock()
        sut.presenter = presenter
        
    }

    override func tearDownWithError() throws {
        sut = nil
        presenter = nil
        try super.tearDownWithError()
    }
    
    func testFetchDataOk() {
        sut.fetchData()
        XCTAssert(presenter.showLoadingCalled)
    }

    func testGetAllCharactersOk() {
       
        sut.data = [CharacterRemoteModel(char_id: 1, name: "Name", birthday: "birthday", occupation: ["Occupation"], img: "Imt", status: "status", nickname: "nickname", appearance: [1], portrayed: "portrayed", category: "category", better_call_saul_appearance: [1])]
        sut.getAllCharacters()
        XCTAssert(presenter.showDataCalled)

        
    }
    
    func testFilterCharactersSeasonOk() {

        sut.getCharactersIn(season: 1)
        XCTAssert(presenter.filterSeasonCalled)
    }
    
    func testFilterCharactersNameOk() {

        sut.filterCharactersByName("Name")
        XCTAssert(presenter.filterNameCalled)
    }
    
}
