//
//  CharactersListViewController.swift
//  GanTest
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import UIKit
protocol CharactersListViewControllerInterface: class {
    func displayFetchedData(viewModel: CharacterListViewModel)
    func spinnerView(add: Bool)
    func showErrorAlert(alertViewModel: AlertViewModel)
}


class CharactersListViewController: UIViewController, CharactersListViewControllerInterface {

    var interactor: CharactersListInteractorInterface?
    var router: (CharactersListRouterInterface & CharactersListDataPassing)?
    
    var resultSearchController = UISearchController()
    
    var spinner: SpinnerViewController?

    var alertViewModel: AlertViewModel?
    var alert: UIAlertController?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var seasonsStackView: UIStackView!
    
    private var viewModel: CharacterListViewModel?
   

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Breaking Bad characters"
        let nib = UINib(nibName: "CharactersTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "characters")
        interactor?.fetchData()
    }
    
    // MARK: - Show fetched Data
    func displayFetchedData(viewModel: CharacterListViewModel) {
        self.viewModel = viewModel
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        resultSearchController.delegate = self
        
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        label.text = "Select Season:"
        seasonsStackView.addArrangedSubview(label)
        for season in viewModel.seasonFilterElements {
            let button: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 50))
            button.setTitle("\(season)", for: .normal)
            button.tag = season

            button.setTitleColor(.systemBlue, for: .normal)
            button.setTitleColor(.systemGray, for: .selected)
            button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false

            seasonsStackView.addArrangedSubview(button)
        }
        
        
        resetDataFilters()
    }
    
    func resetDataFilters() {
        if let characters = self.viewModel?.charactersViewModel {
            self.viewModel?.filteredCharactersViewModel =  characters
        }
        
        tableView.reloadData()

    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        sender.isEnabled = false
        sender.setTitleColor(.systemGray, for: .normal)
        for element in seasonsStackView.subviews {
            if let button = element as? UIButton {
                if sender.tag != button.tag {
                    button.setTitleColor(.systemBlue, for: .normal)
                    button.isEnabled = true
                }
                    
            }
            
        }
        viewModel?.filteredCharactersViewModel.removeAll(keepingCapacity: false)
        self.tableView.reloadData()

        let filteredArray = viewModel?.charactersViewModel?.filter { $0.seasonAppearanceArray.contains(sender.tag)}
        if let filteredArray = filteredArray {
            viewModel?.filteredCharactersViewModel = filteredArray
        }

        self.tableView.reloadData()
        
        
    }
    
    // MARK: - Spinner view
    func spinnerView(add: Bool) {
        if add{
            if spinner == nil {
                spinner = SpinnerViewController()
            }
            addChild(spinner!)
            spinner?.view.frame = view.frame
            view.addSubview(spinner!.view)
            spinner?.didMove(toParent: self)
        } else {
            spinner?.willMove(toParent: nil)
            spinner?.view.removeFromSuperview()
            spinner?.removeFromParent()
            spinner = nil
        }
        

    }
    
    // MARK: - Create Alerts
    private func createDismissalAlert(alertViewModel: AlertViewModel) {
        alert = UIAlertController(title: alertViewModel.title, message: alertViewModel.subtitle, preferredStyle: .alert)

        alert?.addAction(UIAlertAction(title: alertViewModel.acceptTitle, style: .default, handler: { (action) in
            print("action")
        }))
        
        
        if let cancelTitle = alertViewModel.cancelTitle {
            alert?.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: nil))
        }
        
        self.present(alert!, animated: true)
    }
    
    func showErrorAlert(alertViewModel: AlertViewModel) {
  
        createNoActionAlert(alertViewModel: alertViewModel)
        
    }
    
    private func createNoActionAlert(alertViewModel: AlertViewModel) {
        alert = UIAlertController(title: alertViewModel.title, message: alertViewModel.subtitle, preferredStyle: .alert)

        alert?.addAction(UIAlertAction(title: alertViewModel.acceptTitle, style: .default, handler: nil))
        
        if let cancelTitle = alertViewModel.cancelTitle {
            alert?.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: nil))
        }
        
        self.present(alert!, animated: true)
    }
    
    
    // MARK: - Configure Module
    private func configure() {
        let view = self
        let interactor = CharactersListInteractor()
        let presenter = CharactersListPresenter()
        let router = CharactersListRouter()
        let worker = CharactersWorker(remote: CharacterRemoteStore())
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.view = view
        router.view = view
        router.dataStore = interactor
    }

}

extension CharactersListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return viewModel?.filteredCharactersViewModel.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "characters") as! CharactersTableViewCell
        cell.set(viewModel: viewModel?.filteredCharactersViewModel[indexPath.row])
      
        return cell
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let character = viewModel?.charactersViewModel?[indexPath.row] {
            interactor?.select(character: character)
            router?.routeToCharacterDetail(segue: nil)
        } else {
            showErrorAlert(alertViewModel: AlertViewModel(title: "Error", subtitle: "Character not found", acceptTitle: "Ok", cancelTitle: nil))
        }
        
    }
}

extension CharactersListViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    
    func willPresentSearchController(_ searchController: UISearchController) {
        seasonsStackView.isHidden = true
    }
    
    
    func didDismissSearchController(_ searchController: UISearchController) {
        seasonsStackView.isHidden = false
        resetDataFilters()
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel?.filteredCharactersViewModel.removeAll(keepingCapacity: false)

        let filteredArray = viewModel?.charactersViewModel?.filter { $0.name.contains(searchController.searchBar.text!)
            
        }
        if let filteredArray = filteredArray {
            viewModel?.filteredCharactersViewModel = filteredArray

        }

        self.tableView.reloadData()
    }
}
