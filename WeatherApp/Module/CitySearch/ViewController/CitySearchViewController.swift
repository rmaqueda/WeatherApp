//
//  CitySearchViewController.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 25/01/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import UIKit
import Combine

final class CitySearchViewController: BaseTableViewController, UISearchBarDelegate {
    private let viewModel: CitySearchViewModelProtocol
    private let searchController = UISearchController(searchResultsController: nil)
    private var cancellables = Set<AnyCancellable>()
    
    required init(viewModel: CitySearchViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureSearch()
        configureBindings()
    }
    
    // MARK: Configuration
    
    private func configureTableView() {
        tableView.tableHeaderView = searchController.searchBar
    }
    
    private func configureSearch() {
        searchController.searchBar.barStyle = .black
        searchController.searchBar.delegate = self
        searchController.searchBar.showsCancelButton = true
        searchController.automaticallyShowsScopeBar = false
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func configureBindings() {
        viewModel.citiesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
            
    // MARK: TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = viewModel.cities[indexPath.row]
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "CityReuseIdentifier")
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.textLabel?.attributedText = city
        
        return cell
    }
        
    // MARK: TableView Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCity(at: indexPath.row)
        dismissAll()
    }
    
    // MARK: UISearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchCities(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismissAll()
    }
        
    private func dismissAll(_ completion: (() -> Void)? = nil) {
        searchController.dismiss(animated: false) { [weak self] in
            self?.dismiss(animated: true) {
                completion?()
            }
        }
    }
    
}
