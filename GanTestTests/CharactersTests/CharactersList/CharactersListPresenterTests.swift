//
//  CharacterListPresenterTests.swift
//  GanTestTests
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import XCTest
@testable import GanTest

class CharactersListPresenterTests: XCTestCase {
    
    var sut: CharactersListPresenter!
    var view: CharactersListViewControllerMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CharactersListPresenter()
        view = CharactersListViewControllerMock()
        sut.view = view
        
    }

    override func tearDownWithError() throws {
        sut = nil
        view = nil
        try super.tearDownWithError()
    }
    
    func testLoadingDataOk() {
        sut.loadingData()
        XCTAssert(view.spinnerViewCalled)
    }

    
    func testShowDataOk () {
        let data = [CharacterRemoteModel(char_id: 1, name: "Name", birthday: "birthday", occupation: ["Occupation"], img: "Imt", status: "status", nickname: "nickname", appearance: [1,2], portrayed: "portrayed", category: "category", better_call_saul_appearance: [1])]
        sut.show(data: data)
        XCTAssert(view.spinnerViewCalled)
        XCTAssert(view.displayFetchedDataCalled)
        
    }
    
    func testShowErrorOk() {
        sut.show(error: "error")
        XCTAssert(view.showErrorAlertCalled)
    }
    
    func testFilterSeasonOk() {
        let data = [CharacterRemoteModel(char_id: 1, name: "Name", birthday: "birthday", occupation: ["Occupation"], img: "Imt", status: "status", nickname: "nickname", appearance: [1,2], portrayed: "portrayed", category: "category", better_call_saul_appearance: [1])]
        sut.show(data: data)

        sut.filter(season: 1)
        XCTAssert(view.displayFilteredDataCalled)
        XCTAssertEqual(data.count, view.numberOfElementsShown)
    }
    
    func testFilterSeasonNoElementsOk() {
        let data = [CharacterRemoteModel(char_id: 1, name: "Name", birthday: "birthday", occupation: ["Occupation"], img: "Imt", status: "status", nickname: "nickname", appearance: [1,2], portrayed: "portrayed", category: "category", better_call_saul_appearance: [1])]
        sut.show(data: data)

        sut.filter(season: 3)
        XCTAssert(view.displayFilteredDataCalled)
        XCTAssertEqual(0, view.numberOfElementsShown)
    }
    
    func testFilterSeasonNoDataFail() {


        sut.filter(season: 1)
        XCTAssertFalse(view.displayFilteredDataCalled, "Data to filter does not exist, so filter cannot happen")
    }
    
    func testFilterNameOk() {
        let data = [CharacterRemoteModel(char_id: 1, name: "Name", birthday: "birthday", occupation: ["Occupation"], img: "Imt", status: "status", nickname: "nickname", appearance: [1,2], portrayed: "portrayed", category: "category", better_call_saul_appearance: [1])]
        sut.show(data: data)

        sut.filter(charName: "Na")
        
        XCTAssert(view.displayFilteredDataCalled)
        XCTAssertEqual(data.count, view.numberOfElementsShown)
    }
    
    func testFilterNameNoElementsOk() {
        let data = [CharacterRemoteModel(char_id: 1, name: "Name", birthday: "birthday", occupation: ["Occupation"], img: "Imt", status: "status", nickname: "nickname", appearance: [1,2], portrayed: "portrayed", category: "category", better_call_saul_appearance: [1])]
        sut.show(data: data)

        sut.filter(charName: "Eduardo")
        
        XCTAssert(view.displayFilteredDataCalled)
        XCTAssertEqual(0, view.numberOfElementsShown)
    }
    
    func testFilterNameNoDataFail() {

        sut.filter(charName: "Na")
        XCTAssertFalse(view.displayFilteredDataCalled, "Data to filter does not exist, so filter cannot happen")
    }

    
}
