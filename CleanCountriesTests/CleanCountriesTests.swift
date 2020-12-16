//
//  CleanCountriesTests.swift
//  CleanCountriesTests
//
//  Created by Nicola De Bei on 12/12/2020.
//

import XCTest
@testable import CleanCountriesDemo

class CleanCountriesTests: XCTestCase {

    // MARK: - Subject under test
    
    var sut: CountriesStoreAPI!
    var testCountries: [Country]!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        setupCountriesMockStore()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
        resetCountriesMemStore()
    }

    // MARK: - Test setup
    
    func setupCountriesMockStore()
    {
      sut = CountriesStoreAPI()
      
        testCountries = [Seeds.Countries.italy,
                         Seeds.Countries.spain]
      
        CountriesStoreAPI.countries = testCountries
    }
    
    func resetCountriesMemStore()
    {
        CountriesStoreAPI.countries = []
        sut = nil
    }
    
    // MARK: - Test CRUD operations - Optional error
    
    func testFetchCountriesShouldReturnListOfCountries_OptionalError()
    {
      // Given
      
      // When
      var fetchedCountries = [Country]()
      var fetchedCountriesError: DataError?
      let expect = expectation(description: "Wait for fetch() to return")
        sut.fetch { result in
            switch result {
            case let .success(countries):
                fetchedCountries = countries
                expect.fulfill()
            case let .failure(error):
                fetchedCountriesError = error
                expect.fulfill()
            }
        }
        
      waitForExpectations(timeout: 1.0)
      
      // Then
      XCTAssertEqual(fetchedCountries.count,
                     testCountries.count,
                     "fetch() should return a list of countries")
      for country in fetchedCountries {
        XCTAssert(testCountries.contains(where: { testCountry -> Bool in
            testCountry == country
        }), "Fetched countries should match the countries in the data store")
      }
      XCTAssertNil(fetchedCountriesError, "fetch() should not return an error")
    }
    
    func testFetchCountryShouldReturnCountry_OptionalError()
    {
      // Given
      let countryToFetch = testCountries.first!
      
      // When
      var fetchedCountry: Country?
      var fetchCountryError: DataError?
      let expect = expectation(description: "Wait for fetchCountry() to return")
        sut.fetchCountry(id: countryToFetch.id) { result in
        switch result {
        case let .success(country):
            fetchedCountry = country
            expect.fulfill()
        case let .failure(error):
            fetchCountryError = error
            expect.fulfill()
        }
      }
      waitForExpectations(timeout: 1.0)
      
      // Then
      XCTAssertEqual(fetchedCountry, countryToFetch, "fetchCountry() should return a country")
      XCTAssertNil(fetchCountryError, "fetchCountry() should not return an error")
    }

    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
