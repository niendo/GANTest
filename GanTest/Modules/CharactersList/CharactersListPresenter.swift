//
//  CharactersPresenter.swift
//  GanTest
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import Foundation
protocol CharactersListPresenterInterface {
    func show(data: [CharacterRemoteModel])
    func filter(season: Int)
    func filter(charName: String)
    func loadingData()
    func show(error: String)
}

class CharactersListPresenter: CharactersListPresenterInterface {
    
    var view: CharactersListViewControllerInterface?
    private var viewModel: CharacterListViewModel?

    // MARK: - Show Loading
    func loadingData() {
        view?.spinnerView(add: true)

    }
    
    // MARK: - Show Data
    func show(data: [CharacterRemoteModel]) {
        let charactersViewModel = CharacterListViewModel(models: data)
        view?.spinnerView(add: false)
        view?.displayFetchedData(viewModel: charactersViewModel)
        self.viewModel = charactersViewModel
    }
    
    // MARK: - Show error
    func show(error: String) {
        let errorAlertData = AlertViewModel(title: "An error has occurred", subtitle: error, acceptTitle: "Ok", cancelTitle: nil)
        view?.showErrorAlert(alertViewModel: errorAlertData)

    }
    
    // MARK: - Filters

    func filter(season: Int) {
        var filteredViewModel = viewModel
        
        let filteredArray = viewModel?.charactersViewModel?.filter { $0.seasonAppearanceArray.contains(season)
            
        }
        if let filteredArray = filteredArray {
            filteredViewModel?.charactersViewModel = filteredArray
        }
        
        if let filteredViewModel = filteredViewModel {
            view?.displayFilteredData(viewModel: filteredViewModel)
        }
        
  
    }
    
    func filter(charName: String) {
        var filteredViewModel = viewModel
        if charName != "" {
            let filteredArray = viewModel?.charactersViewModel?.filter { $0.name.contains(charName)}
            if let filteredArray = filteredArray {
                filteredViewModel?.charactersViewModel = filteredArray

            }
        }
       
        
        if let filteredViewModel = filteredViewModel {
            view?.displayFilteredData(viewModel: filteredViewModel)
        }

    }

    
}
