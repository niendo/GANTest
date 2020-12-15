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

    func testMethodOk() {
       
       
    }
    
}
