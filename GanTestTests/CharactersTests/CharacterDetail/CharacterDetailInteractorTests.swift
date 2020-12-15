//
//  CharacterDetailInteractorTests.swift
//  GanTestTests
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import XCTest
@testable import GanTest

class CharacterDetailInteractorTests: XCTestCase {
    
    var sut: CharacterDetailInteractor!
    var presenter: CharacterDetailPresenterMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CharacterDetailInteractor()
        presenter = CharacterDetailPresenterMock()
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
