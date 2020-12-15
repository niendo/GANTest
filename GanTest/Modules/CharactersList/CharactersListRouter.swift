//
//  CharactersRouter.swift
//  GanTest
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import Foundation
import UIKit
protocol CharactersListRouterInterface {
    func routeToCharacterDetail(segue: UIStoryboardSegue?)

}

protocol CharactersListDataPassing {
    var dataStore: CharactersListDataStore? { get }
}


class CharactersListRouter: CharactersListRouterInterface, CharactersListDataPassing {
    
    weak var view: CharactersListViewController?
    var dataStore: CharactersListDataStore?
    var presentedCurrencies: [String]?
    
    // MARK: - Route to new module
    
    func routeToCharacterDetail(segue: UIStoryboardSegue?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationView = storyboard.instantiateViewController(withIdentifier: "characterDetail") as! CharacterDetailViewController
        destinationView.configure()
        navigateToCharacterDetail(source: view!, destination: destinationView)
        
        var destinationDataStore = destinationView.router!.dataStore!

        pasDataToCharacterDetail(source: dataStore!, destination: &destinationDataStore)

    }
    
    
    private func pasDataToCharacterDetail(source: CharactersListDataStore, destination: inout CharacterDetailDataStore) {
        destination.characterDetail = source.characterDetail
    }
     
    private func navigateToCharacterDetail(source: CharactersListViewController, destination: CharacterDetailViewController) {

        
        source.navigationController?.pushViewController(destination, animated: false)

        
    }
}
