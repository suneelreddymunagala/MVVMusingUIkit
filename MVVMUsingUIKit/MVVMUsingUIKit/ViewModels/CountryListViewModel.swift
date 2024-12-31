//
//  CountryListViewModel.swift
//  MVVMUsingUIKit
//
//  Created by Suneel Apprikart on 31/12/24.
//
import Foundation

class CountryListViewModel: AnyObject {
    
    weak var delegate: RequestDelegate?
    private var state: ViewState {
        didSet {
            delegate?.didUpdate(with: state)
        }
    }
    
    private var countries: [CountryData] = []
    private let countriesService: CountryEndPointService = CountryEndPointService()
    
    init() {
        state = .idle
    }
    
}

//MARK: Services
extension CountryListViewModel {
    func fetchCountries() {
        state = .loading
        
        
        Task {
            do {
                let response = try await CountryEndPointService.getAllCountries()
                
                guard let data = response.data,
                (response.error == nil) else {
                    self.state = .error(response.error)
                    return
                }
                
                self.state = .success
                self.countries = data
            }
        }
    }
}

//MARK: DataSource
extension CountryListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfCountries: Int {
        return self.countries.count
    }
    
    func getCountryVM(at index: Int) -> CountryViewModel {
        let countryViewModel = CountryViewModel(countryData: self.countries[index])
        return countryViewModel
    }
}
