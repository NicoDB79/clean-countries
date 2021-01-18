//
//  CountryListViewController.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 18/01/2021.
//  
//

import UIKit
import SVProgressHUD
import Combine

class CountryListViewController: UIViewController, Storyboarded {
    
    // MARK: - Controls
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(
                UINib(nibName: String(describing: CountryListTableViewCell.self), bundle: nil),
                forCellReuseIdentifier: cellReuseIdentifier
            )
        }
    }
    
    private lazy var searchController: UISearchController = {
        $0.searchResultsUpdater = self
        $0.hidesNavigationBarDuringPresentation = false
        $0.obscuresBackgroundDuringPresentation = false
        $0.searchBar.placeholder = "country_list_search_message".localized
        return $0
    }(UISearchController(searchResultsController: nil))
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: Selector(("handleRefresh:")),
                                 for: UIControl.Event.valueChanged)
        
        return refreshControl
    }()
    
    
    // MARK: - Keyboard events
    
    let keyboardWillOpen = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .map {$0.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect}
        .map {$0.height}
    
    let keyboardWillHide =  NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat(0)}
    
    var cancellables: [AnyCancellable] = []
    var countryUpdateCancellable: AnyCancellable?
    
    // MARK: - Properties
    var interactor: CountryListInteractorProtocol?
    var router: CountryListRouterProtocol?
    
    // MARK: - View models
    
    private var listViewModel: CountryListModels.ListViewModel?
    
    // MARK: - Internal variables
    
    private let cellReuseIdentifier = "CountryListCell"
    
    // MARK: - Controller cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        fetchData()
        bindNotificationEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindKeyboardEvents()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cancellables.forEach { $0.cancel() }
    }
}

// MARK: - Events

private extension CountryListViewController {
    
    func configure() {
        tableView.refreshControl = self.refreshControl
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        self.titleLabel.text = "country_list_title".localized
    }
    
    func bindKeyboardEvents() {
        cancellables.append(
            keyboardWillOpen.sink(receiveValue: { height in
                self.tableView.setBottomInset(to: height)
            })
        )
        
        cancellables.append(
            keyboardWillHide.sink(receiveValue: { height in
                self.tableView.setBottomInset(to: 0.0)
            })
        )
    }
    
    func bindNotificationEvents() {
        countryUpdateCancellable =
            NotificationCenter.default.publisher(for: .countryUpdated).sink(receiveValue: { notification in
                self.fetchOfflineData()
        })
    }
    
    func fetchData() {
        SVProgressHUD.show()
        interactor?.fetchDatabaseCountries { [weak self] in
            self?.interactor?.fetchOnlineCountries()
        }
    }
    
    func fetchOfflineData() {
        interactor?.fetchDatabaseCountries(completion: nil)
    }
    
    func fetchOnlineData() {
        searchController.isActive = false
        self.interactor?.fetchOnlineCountries()
    }
    
    func searchData(for text: String) {
        interactor?.searchCountries(with: CountryListModels.SearchRequest(text: text))
    }
    
    func loadList() {
        self.tableView.refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.fetchOnlineData()
    }
}

extension CountryListViewController: CountryListViewProtocol{
    func displayFetchedCountries(with viewModel: CountryListModels.ListViewModel) {
        listViewModel = viewModel
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            self.loadList()
        }
    }
    
    func displaySearchedCountries(with viewModel: CountryListModels.ListViewModel) {
        listViewModel = viewModel
        DispatchQueue.main.async {
            self.loadList()
        }
    }
}

// MARK: - Delegates
extension CountryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let country = interactor?.countries?[indexPath.row] else { return }
        router?.showCountry(for: country)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

}

extension CountryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel?.displayedCountries.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! CountryListTableViewCell
        
        guard let model = listViewModel?.displayedCountries[indexPath.row] else { return cell }
        cell.bind(model)
        return cell
    }
}

extension CountryListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            fetchOfflineData()
            return
        }
        searchData(for: text)
    }
}

extension CountryListViewController: AppDisplayable {
    func display(error: AppModels.Error, completion: (() -> ())?) {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
}
