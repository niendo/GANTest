//
//  CharacterDetailPresenterTests.swift
//  GanTestTests
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import XCTest
@testable import GanTest

class CharacterDetailPresenterTests: XCTestCase {
    
    var sut: CharacterDetailPresenter!
    var view: CharacterDetailViewControllerMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CharacterDetailPresenter()
        view = CharacterDetailViewControllerMock()
        sut.view = view
        
    }

    override func tearDownWithError() throws {
        sut = nil
        view = nil
        try super.tearDownWithError()
    }

    
}
