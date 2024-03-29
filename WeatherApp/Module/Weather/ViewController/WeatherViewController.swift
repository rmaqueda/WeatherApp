//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 04/02/2021.
//

import UIKit
import Combine

final class WeatherViewController: BaseCollectionViewController {
    private let viewModel: WeatherViewModelProtocol
    private let layout: WeatherCollectionViewLayout
    private var cancellables = Set<AnyCancellable>()
    
    required init(viewModel: WeatherViewModelProtocol) {
        self.viewModel = viewModel
        self.layout = WeatherCollectionViewLayout(viewModel: viewModel)
        super.init(collectionViewLayout: self.layout.createLayout())
    }
        
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureNavigationBar()
        configureToolBar()
        configureBindings()
        
        viewModel.requestForecast()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        try? viewModel.updateCity()
    }
    
    // MARK: Configuration
    
    private func configureCollectionView() {
        collectionView.register(ActivityIndicatorCollectionViewCell.self)
        collectionView.register(CityCollectionViewCell.self)
        collectionView.register(TemperatureCollectionViewCell.self)
        collectionView.register(HourForecastCollectionViewCell.self)
    }
    
    private func configureBindings() {
        viewModel.dataSourcePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] viewModel in
                if let error = viewModel.error {
                    self?.handleError(error: error)
                } else {
                    self?.collectionView.reloadData()
                }
            }
            .store(in: &cancellables)
    }
    
    private func configureNavigationBar() {
        guard !viewModel.isSaved else { return }
        
        navigationController?.navigationBar.isHidden = false
        
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(didTapAdd(_:)))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel(_:)))
        
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    private func configureToolBar() {
        navigationController?.isToolbarHidden = false
        
        let twcButton = UIBarButtonItem(image: UIImage(named: "twc"), style: .plain, target: self, action: #selector(didTapTWC(_:)))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let listButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(didTapCancel(_:)))
        
        toolbarItems = [twcButton, spacer, listButton]
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.dataSource.sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.dataSource.sections[section].numberOfItems
    }
        
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.dataSource.sections[indexPath.section]
        
        // swiftlint:disable force_cast
        // Should dequeue a cell if the nib was previously registered, so force unwrap is safe
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: section.cellClass.reuseIdentifier,
                                                      for: indexPath) as! WeatherViewRepresentable
        // swiftlint:enable force_cast
                    
        cell.configure(with: section, indexPath: indexPath)
        
        return cell
    }
    
    private func handleError(error: APIClientError<OpenWeatherAPIError>) {
        var message: String = "The network request failed.\n\n"
        
        switch error {
        case .loadingError(let loadingError):
            message += loadingError.localizedDescription
        case .decodingError(let decodingError):
            message += decodingError.localizedDescription
        case .apiError(let apiError):
            message += apiError.error?.message.capitalized ?? "Unknown error."
        }
        
        presentRetryAlert(withTitle: "Oops", message: message) { [weak self] _ in
            self?.viewModel.requestForecast()
        }
    }
        
    // MARK: Actions
    
    @objc func didTapTWC(_ sender: UIBarButtonItem) {
        viewModel.didPressTWC()
    }
    
    @objc func didTapAdd(_ sender: UIBarButtonItem) {
        do {
            try viewModel.saveCity()
            navigationController?.navigationBar.isHidden = viewModel.isSaved
        } catch {
            print("Error saving city \(error)")
        }
    }
    
    @objc func didTapCancel(_ sender: UIBarButtonItem) {
        viewModel.didPressCityList()
    }
    
}
