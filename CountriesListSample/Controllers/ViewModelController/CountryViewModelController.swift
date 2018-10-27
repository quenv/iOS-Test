//
//  CountryViewModelController.swift
//  CountriesListSample
//
//  Created by admin on 10/26/18.
//  Copyright © 2018 QueNguyen. All rights reserved.
//

import Foundation
import Alamofire

typealias RetrieveCountriesCompletionBlock = (_ success: Bool, _ error: NSError?) -> Void
typealias DataTypeRegion = [String: [CountryViewModel]]

class CountryViewModelController {
    
    // MARK: - Properties
    private var dataByRegion = DataTypeRegion()
    private var dataByAll = DataTypeRegion()
    private var viewModels = [CountryViewModel]()
    private var retrieveCountriesCompletionBlock: RetrieveCountriesCompletionBlock?
    
    var viewModelsCount: Int {
        return viewModels.count
    }
    
    // MARK: - Get data
    func retrieveCountries(_ completionBlock: @escaping RetrieveCountriesCompletionBlock) {
        retrieveCountriesCompletionBlock = completionBlock
        getData()
    }
    
    func viewModel(at index: Int) -> CountryViewModel? {
        guard index >= 0 && index < viewModelsCount else { return nil }
        return viewModels[index]
    }
    
    func listDataByRegion(isGroupRegion: Bool) -> DataTypeRegion {
        if isGroupRegion {
            return dataByRegion
        } else {
            return dataByAll
        }
    }
    
    // MARK: - Config data
    private func configData() {
        dataByAll = [CLString.emptyString : viewModels]
        dataByRegion = Dictionary(grouping: viewModels,
                                  by: { $0.region ?? CLString.emptyString })
    }
    
    // MARK: - Filter data
    func filterData(_ name: String) -> [CountryViewModel] {
        var filterList = [CountryViewModel]()
        filterList = viewModels.filter({ (country) -> Bool in
            return country.name.lowercased().contains(name.lowercased())
        })
        return filterList
    }
}

private extension CountryViewModelController {
    
    static func parse(_ jsonData: Data) -> [Country?]? {
        do {
            return try JSONDecoder().decode([Country].self, from: jsonData)
        } catch {
            return nil
        }
    }
    
    static func initViewModels(_ countries: [Country]) -> [CountryViewModel] {
        return countries.map { country in
            return CountryViewModel(country: country)
        }
    }
    
    func getData() {
        APIManager().getAllCountryList { [weak self] (countries, errorCode) in
            guard let strongSelf = self else { return }
            if let countries = countries {
                let countriesList = CountryViewModelController.initViewModels(countries)
                strongSelf.viewModels = countriesList
                strongSelf.configData()
                DispatchQueue.main.async {
                    strongSelf.retrieveCountriesCompletionBlock?(true, nil)
                }
            } else {
                DispatchQueue.main.async {
                    strongSelf.retrieveCountriesCompletionBlock?(false, NSError.createError(0, description: CLMessage.dataError))
                }
            }
        }
    }
}
