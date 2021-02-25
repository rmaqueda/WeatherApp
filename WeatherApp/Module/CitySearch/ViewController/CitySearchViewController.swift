//
//  CitySearchViewController.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 25/01/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//
// https://developer.apple.com/documentation/mapkit/searching_for_nearby_points_of_interest

import UIKit
import Combine
import MapKit

class CitySearchViewController: UITableViewController, UISearchBarDelegate, MKLocalSearchCompleterDelegate {
    private let viewModel: CitySearchViewModel
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchCompleter: MKLocalSearchCompleter?
    private var completerResults: [MKLocalSearchCompletion] = []

    required init(viewModel: CitySearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureSearch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
 
        configureSearchCompleter()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        stopProvidingCompletions()
    }
    
    // MARK: Configuration
    
    private func configureSearchCompleter() {
        searchCompleter = MKLocalSearchCompleter()
        let filters = MKPointOfInterestFilter(including: [.airport])
        searchCompleter?.pointOfInterestFilter = filters
        searchCompleter?.resultTypes = [.address, .pointOfInterest]
        searchCompleter?.delegate = self
    }

    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = searchController.searchBar
        tableView.tableHeaderView?.backgroundColor = .black
        tableView.backgroundColor = .black
    }
    
    private func configureSearch() {
        searchController.searchBar.delegate = self
        searchController.searchBar.barStyle = .black
        searchController.searchBar.keyboardAppearance = .dark
        searchController.searchBar.tintColor = .white
        searchController.searchBar.showsCancelButton = true
        searchController.automaticallyShowsScopeBar = false
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func stopProvidingCompletions() {
        searchCompleter = nil
    }
        
    // MARK: TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        completerResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = completerResults[indexPath.row]
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "CityReuseIdentifier")
        cell.backgroundColor = .black
        cell.selectionStyle = .none
        cell.textLabel?.attributedText = (city.title + " " + city.subtitle).highlightedString(rangeValues: city.titleHighlightRanges)
        
        return cell
    }
        
    // MARK: TableView Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let city = searchCompleter?.results[indexPath.row] else {
            return
        }
        
        // TODO: Fix this double dismiss
        dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
        
        let searchRequest = MKLocalSearch.Request(completion: city)
        search(using: searchRequest)
    }
    
    // MARK: UISearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            completerResults = []
            tableView.reloadData()
        } else {
            searchCompleter?.queryFragment = searchText
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: MKLocalSearchCompleter Delegate
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        completerResults = completer.results
        tableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        if let error = error as NSError? {
            print("MKLocalSearchCompleter encountered an error: \(error.localizedDescription). The query fragment is: \"\(completer.queryFragment)\"")
        }
        completerResults = []
        tableView.reloadData()
    }
    
    // MARK: MKLocalSearch Request
    
    private func search(using searchRequest: MKLocalSearch.Request) {
        searchRequest.resultTypes = [.address, .pointOfInterest]

        let localSearch = MKLocalSearch(request: searchRequest)
        localSearch.start { [weak self] response, error in
            guard error == nil else { return }
            guard let self = self else { return }

            if let item = response?.mapItems.first,
               let name = item.name {
                let city = City(name: name,
                                coordinate: City.Coordinate(lat: item.placemark.coordinate.latitude, lon: item.placemark.coordinate.longitude),
                                timeZone: item.timeZone,
                                temperature: nil)

                self.viewModel.presentForecast(for: city)
            }
        }
    }
    
}
