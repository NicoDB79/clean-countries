@testable import CleanCountriesDemo
import XCTest

struct Seeds
{
    struct Countries
    {
        static let italy = Country(id: "79",
                                   enabled: true,
                                   code3l: "ITA",
                                   code2l: "IT",
                                   name: "Italy",
                                   officialName: "Republic of Italy",
                                   flag: "",
                                   latitude: "30.85883075",
                                   longitude: "34.91753797",
                                   zoom: "7")
        
        static let spain = Country(id: "153",
                                   enabled: true,
                                   code3l: "ESP",
                                   code2l: "ES",
                                   name: "Spain",
                                   officialName: "Kingdom of Spain",
                                   flag: "",
                                   latitude: "39.87299401",
                                   longitude: "-3.67089492",
                                   zoom: "6")
    }
}
