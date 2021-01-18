//
//  CountryListViewControllerTests.swift
//  CleanCountriesTests
//
//  Created by Nicola De Bei on 15/12/2020.
//

import XCTest
@testable import CleanCountriesDemo

class CountryListViewControllerTests: XCTestCase {
    
    // MARK: - Subject under test
    var sut: CountryListViewController!
    var window: UIWindow!
    
    override func setUpWithError() throws {
        super.setUp()
        window = UIWindow()
        setupCountryListViewController()
    }
    
    override func tearDownWithError() throws {
        window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupCountryListViewController() {
        sut = CountryListViewController.instantiate(storyboardName: "CountryList")
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    class CountryListBusinessLogicSpy: CountryListInteractorProtocol {
        var countries: [Country]?
        
        // MARK: Method call expectations
        var fetchCountriesCalled = false
        
        func fetchDatabaseCountries(completion: (() -> ())?) {
            fetchCountriesCalled = true
        }
        
        func fetchOnlineCountries() {
            fetchCountriesCalled = true
        }
        
        func searchCountries(with request: CountryListModels.SearchRequest) {}
    }
    
    func testShouldFetchCountriesWhenViewDidAppear()
    {
        // Given
        let interactor = CountryListBusinessLogicSpy()
        sut.interactor = interactor
        loadView()
        
        // When
        sut.viewDidAppear(true)
        
        // Then
        XCTAssert(interactor.fetchCountriesCalled, "Should fetch countries right after the view appears")
    }
}
