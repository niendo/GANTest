//
//  CharactersListWorkerTests.swift
//  GanTestTests
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import XCTest
@testable import GanTest

class CharactersWorkerTests: XCTestCase {
    
    var sut: CharactersWorker!
    var store: RemoteStoreMock!
    override func setUp() {

    }

    override func setUpWithError() throws {
        try super.setUpWithError()
        store = RemoteStoreMock()
        sut = CharactersWorker(remote: store)
    }

    override func tearDownWithError() throws {

        sut = nil
    }
    
    // MARK: - fetchExchange

    func testMethodOk() {
        
    }
}
