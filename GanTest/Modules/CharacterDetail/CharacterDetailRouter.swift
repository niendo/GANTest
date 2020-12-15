//
//  CharacterDetailRouter.swift
//  GanTest
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import UIKit

protocol CharacterDetailRouterInterface {
    func routeToCharactersList(segue: UIStoryboardSegue?)

}

protocol CharacterDetailDataPassing {
    var dataStore: CharacterDetailDataStore? { get }
}

class CharacterDetailRouter: CharacterDetailRouterInterface, CharacterDetailDataPassing {
    
    weak var view: CharacterDetailViewController?
    var dataStore: CharacterDetailDataStore?
//    var selectedCurrencyPair: CurrencyPair?

    // MARK: - To characters list

    func routeToCharactersList(segue: UIStoryboardSegue?) {
       
        let destinationView = view?.presentingViewController as! CharactersListViewController

        navigateToCharactersList(source: view!, destination: destinationView)
    }
     
    private func navigateToCharactersList(source: CharacterDetailViewController, destination: CharactersListViewController) {
        
//        source.dismiss(animated: true) {
//            DispatchQueue.main.async {
//                destination.isViewShown = true
//            }
//        }
    }


}
