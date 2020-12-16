//
//  CountryListInteractor.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 12/12/2020.
//
import Foundation

class CountryListInteractor {
    private let presenter: CountryListPresentable
    private let countriesOnlineWorker: CountriesWorker?
    private let countriesOfflineWorker: CountriesWorker?
    private var networkMonitor = Reach()
    
    var countries: [Country]?
    
    init(presenter: CountryListPresentable) {
        self.presenter = presenter
        self.countriesOnlineWorker = CountriesWorker(store: CountriesStoreAPI())
        self.countriesOfflineWorker = CountriesWorker(store: CountriesStoreDatabase())
    }
}

extension CountryListInteractor: CountryListBusinessLogic {
    
    // MARK: - Fetch countries from db
    func fetchDatabaseCountries(completion: (() -> ())?) {
        DispatchQueue.global().async { [weak self] in
            self?.countriesOfflineWorker?.fetch {
                guard let value = $0.value, $0.isSuccess else {
                    let error = $0.error ?? .unknownReason(nil)
                    DispatchQueue.main.async {
                        self?.presenter.presentSearchedCountries(error: error)
                        completion?()
                    }
                    return
                }
                
                // sorting countries
                let sortedCountries = value.sortByDistance()
                self?.countries = sortedCountries
                
                DispatchQueue.main.async {
                    self?.presenter.presentSearchedCountries(
                        for: CountryListModels.Response(countries: sortedCountries)
                    )
                    completion?()
                }
            }
        }
    }
    
    // MARK: - Download countries from API
    func fetchOnlineCountries() {
        countriesOnlineWorker?.fetch { [weak self] in
            // once downloaded, insert/update countries into database and then present them
            if let countries = $0.value {
                if let storedCountries = self?.countriesOfflineWorker?.updateCountries(countries).value {
                    DispatchQueue.main.async {
                        self?.presentCountries(result: .success(storedCountries))
                    }
                }
            }
        }
    }
    
    private func presentCountries(result: Result<[Country], DataError>) {
        guard let value = result.value, result.isSuccess else {
            presenter.presentFetchedCountries(error: result.error ?? .unknownReason(nil))
            return
        }
        
        // sorting countries
        let sortedCountries = value.sortByDistance()
        self.countries = sortedCountries
        
        // present countries
        presenter.presentFetchedCountries(
            for: CountryListModels.Response(countries: sortedCountries)
        )
    }
    
    // MARK: - Search countries
    func searchCountries(with request: CountryListModels.SearchRequest) {
        let workerRequest = CountriesModels.SearchRequest(query: request.text)
        
        countriesOfflineWorker?.search(with: workerRequest) { [weak self] in
            guard let value = $0.value, $0.isSuccess else {
                self?.presenter.presentSearchedCountries(error: $0.error ?? .unknownReason(nil))
                return
            }
            
            self?.countries = value
            
            self?.presenter.presentSearchedCountries(
                for: CountryListModels.Response(countries: value)
            )
        }
    }
}
