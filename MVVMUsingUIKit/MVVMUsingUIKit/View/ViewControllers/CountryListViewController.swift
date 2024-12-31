//
//  CountryListViewController.swift
//  MVVMUsingUIKit
//
//  Created by Suneel Apprikart on 31/12/24.
//

import Foundation
import UIKit

class CountryListViewController: BaseViewController {
    
    @IBOutlet weak var countryTV: UITableView!
    
    static var identifier: String {
        return String(describing: CountryListViewController.self)
    }
    
    private let countryListVM: CountryListViewModel = CountryListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        
        self.countryListVM.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.countryListVM.fetchCountries()
    }
    
    
}

//MARK:
extension CountryListViewController: RequestDelegate {
    func didUpdate(with state: ViewState) {
        DispatchQueue.main.async {
        switch state {
        case .idle:
            print("Nothing..")
            break
            
        case .success:
            self.countryTV.reloadData()
            self.hideLoader()
            
        case .error:
            //handle error
            self.hideLoader()
            
        case .loading:
            self.showLoader()
        }
       
           
        }
    }
  
}
//MARK: UITableViewDelegate, UITableViewDataSource
extension CountryListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return countryListVM.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryListVM.numberOfCountries
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let countryCell = tableView.dequeueReusableCell(withIdentifier: CountryTVCell.identifier, for: indexPath) as? CountryTVCell else {
            return UITableViewCell()
        }
        
        let viewModel = countryListVM.getCountryVM(at: indexPath.row)
        countryCell.configureCountryDataUsing(viewModel: viewModel)
        return countryCell
    }
}

//MARK: UI
extension CountryListViewController {
   private func setUpUI() {
       self.title = "Country List"
       self.setUpForCountryTV()
    }
    
    private func setUpForCountryTV() {
        self.countryTV.delegate = self
        self.countryTV.dataSource = self
        self.countryTV.register(CountryTVCell.nib, forCellReuseIdentifier: CountryTVCell.identifier)
    }
}
