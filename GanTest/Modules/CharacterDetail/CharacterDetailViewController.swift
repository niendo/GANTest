//
//  CharacterDetailViewController.swift
//  GanTest
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import UIKit
protocol CharacterDetailViewControllerInterface: class {
    func displayCharacterDetail(viewModel: CharacterViewModel)
    func showErrorAlert(alertViewModel: AlertViewModel)
}


class CharacterDetailViewController: UIViewController, CharacterDetailViewControllerInterface {
    var interactor: CharacterDetailInteractorInterface?
    var router: (CharacterDetailRouterInterface & CharacterDetailDataPassing)?
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var seasonAppearanceLabel: UILabel!
    var alertViewModel: AlertViewModel?
    var alert: UIAlertController?
    
    var viewModel: CharacterViewModel?

    var isViewShown: Bool = false {
        didSet {
            if let alertViewModel = alertViewModel, isViewShown {
                createDismissalAlert(alertViewModel: alertViewModel)
                self.alertViewModel = nil
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.viewLoaded()

    }
    

    // MARK: - Configure

    func configure() {
        let view = self
        let interactor = CharacterDetailInteractor()
        let presenter = CharacterDetailPresenter()
        let router = CharacterDetailRouter()
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        router.dataStore = interactor
    }
    
    private func createDismissalAlert(alertViewModel: AlertViewModel) {
        alert = UIAlertController(title: alertViewModel.title, message: alertViewModel.subtitle, preferredStyle: .alert)

        alert?.addAction(UIAlertAction(title: alertViewModel.acceptTitle, style: .default, handler: { (action) in
            self.router?.routeToCharactersList(segue: nil)
        }))
        
        if let cancelTitle = alertViewModel.cancelTitle {
            alert?.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: nil))
        }
        
        self.present(alert!, animated: true)
    }
    
    func displayCharacterDetail(viewModel: CharacterViewModel) {
        title = viewModel.name
        if let url = URL(string: viewModel.image){
            image.downloaded(from: url)
        }
        nameLabel.text = viewModel.name
        occupationLabel.text = viewModel.occupation
        statusLabel.text = viewModel.status
        nicknameLabel.text = viewModel.nickname
        seasonAppearanceLabel.text = viewModel.seasonAppearance
        self.viewModel = viewModel

    }

    

    func showErrorAlert(alertViewModel: AlertViewModel) {
        if isViewShown {
            createNoActionAlert(alertViewModel: alertViewModel)
        } else {
            self.alertViewModel = alertViewModel
        }
    }
    
    private func createNoActionAlert(alertViewModel: AlertViewModel) {
        alert = UIAlertController(title: alertViewModel.title, message: alertViewModel.subtitle, preferredStyle: .alert)

        alert?.addAction(UIAlertAction(title: alertViewModel.acceptTitle, style: .default, handler: nil))
        
        if let cancelTitle = alertViewModel.cancelTitle {
            alert?.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: nil))
        }
        
        self.present(alert!, animated: true)
    }

}
