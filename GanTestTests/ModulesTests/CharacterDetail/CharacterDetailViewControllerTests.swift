//
//  CharacterDetailViewControllerTests.swift
//  GanTestTests
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import XCTest
@testable import GanTest

class CharacterDetailViewControllerTests: XCTestCase {
    
    var sut: CharacterDetailViewController!
    var interactor: CharacterDetailInteractorMock!
    var window: UIWindow!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        window = UIWindow()
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "characterDetail") as? CharacterDetailViewController
        interactor = CharacterDetailInteractorMock()
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

    func testMethodOk() {
        loadView()

    }
    
}
