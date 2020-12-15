//
//  CharactersViewModel.swift
//  GanTest
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import Foundation
struct CharacterViewModel {
    private let model: CharacterRemoteModel?
    
    init(model: CharacterRemoteModel?) {
        self.model = model
    }
}
extension CharacterViewModel {
    var name: String {
        return model?.name ?? ""
    }
    
    var image: String {
        return model?.img ?? ""
    }
    
    var occupation: String {
        var returnValue = String()
        if let value = model?.occupation {
            for element in value {
                if element != value.first {
                    returnValue += " "
                }
                returnValue += "\(element)"
                
                if element != value.last {
                    returnValue += ", "
                }
            }
        }
        
        return returnValue
    }
    
    var status: String {
        return model?.status ?? ""
    }
    
    var nickname: String {
        return model?.nickname ?? ""
    }
    
    var seasonAppearance: String {
        var returnValue = "Appears in season"
        if let value = model?.appearance {
            for element in value {
                if element != value.first {
                    returnValue += " "
                }
                
                returnValue += " \(element)"
                
                if element != value.last {
                    returnValue += ","
                }
            }
        }
        return returnValue
    }
    var seasonAppearanceArray: [Int] {
        return model?.appearance ?? [Int]()
    }
    
}

struct CharacterListViewModel {
    var charactersViewModel: [CharacterViewModel]?
    var seasonFilterElements = [Int]()
    private var models: [CharacterRemoteModel]
    
    init(models: [CharacterRemoteModel]) {
        charactersViewModel = [CharacterViewModel]()
        self.models = models
        
        for model in models {
            if let appearance = model.appearance {
                for season in appearance {
                    if !seasonFilterElements.contains(season) {
                        seasonFilterElements.append(season)
                    }
                }
            }
            
            let characterViewModel = CharacterViewModel(model: model)
            charactersViewModel?.append(characterViewModel)
        }
        
        seasonFilterElements = seasonFilterElements.sorted()
    }
}

struct AlertViewModel {
    var title: String
    var subtitle: String
    var acceptTitle: String
    var cancelTitle: String?
    
}
