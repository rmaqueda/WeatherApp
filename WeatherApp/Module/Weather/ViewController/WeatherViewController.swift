//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 04/02/2021.
//

import UIKit
import Combine

class WeatherViewController: UICollectionViewController {
    private let layout = WeatherCollectionViewLayout()
    private let viewModel: WeatherViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    
    required init(viewModel: WeatherViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(collectionViewLayout: layout.createLayout())
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented, use: init(viewModel:)")
    }
        
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureCacheSwitch()
        configureBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.requestForecast()
    }

    // MARK: Configuration
    
    private func configureCollectionView() {
        collectionView.register(CityCollectionViewCell.self)
        collectionView.register(TemperatureCollectionViewCell.self)
        collectionView.register(DailyForecastCollectionViewCell.self)
        collectionView.register(ActivityIndicatorCollectionViewCell.self)
    }
    
    private func configureBindings() {
        viewModel.dataSourcePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] viewModel in
                if let error = viewModel.error {
                    self?.handleError(error: error)
                }
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func configureCacheSwitch() {
        let label = UILabel()
        label.text = "Use cache"
        label.accessibilityIdentifier = "CacheLabel"

        let prefSwitch = UISwitch(frame: .zero)
        prefSwitch.isOn = false
        prefSwitch.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        prefSwitch.accessibilityIdentifier = "CacheSwitch"

        let stackView = UIStackView()
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(prefSwitch)
        stackView.spacing = 8
        
        let barButton = UIBarButtonItem(customView: stackView)
        navigationItem.rightBarButtonItem = barButton
    }
     
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.dataSource.sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.dataSource.sections[section].metadata.numberOfItems
    }
        
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.dataSource.sections[indexPath.section]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: section.metadata.reuseIdentifier,
                                                            for: indexPath) as? WeatherViewRepresentable else {
            fatalError("Invalid reuse identifier: \(section.metadata.reuseIdentifier)")
        }
        
        cell.configure(with: section, indexPath: indexPath)
        
        return cell
    }
        
    // MARK: Actions
    
    @objc func switchToggled(_ sender: UISwitch) {
//        viewModel.cacheSwitchDidChange(isEnable: sender.isOn)
//        requestForecast()
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
    
}
