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

    
}
