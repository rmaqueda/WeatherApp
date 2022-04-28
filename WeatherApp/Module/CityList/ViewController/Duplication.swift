//
//  Duplication.swift
//  WeatherApp
//
//  Created by Maqueda, Ricardo Javier on 28/4/22.
//

import Foundation
import Combine
import UIKit

final class CityListViewController2: BaseTableViewController, CityListFooterViewDelegate, UITableViewDragDelegate {
    private let viewModel: CityListViewModelProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    required init(viewModel: CityListViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    private func configureTableView() {
        tableView.register(CityTableViewCell.self)
        tableView.registerHeaderFooter(CityListFooterView.self)
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
    }
        
    // MARK: TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = viewModel.cities[indexPath.row]
        let cell: CityTableViewCell = tableView.dequeueReusableCell()
        cell.configure(with: city)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView: CityListFooterView = tableView.dequeueReusableHeaderFooterView()
        footerView.delegate = self
        footerView.configure(for: viewModel.temperatureUnit)
        
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        50
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        try? viewModel.moveCity(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    // MARK: TableView Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 0 ? 92 : 82
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = viewModel.cities[indexPath.row]
        viewModel.presentForecast(for: city)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try? viewModel.deleteCity(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: TableView Drag Delegate
        
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = viewModel.cities[indexPath.row]
        return [dragItem]
    }
    
    // MARK: CityListFooterView Delegate
    
    func didPressMagnitudeButton() {
        try? viewModel.toggleTemperatureUnit()
        tableView.reloadData()
    }
    
    func didPressTWCButton() {
        viewModel.didPressTWC()
    }
    
    func didPressSearchButton() {
        viewModel.presentCitySearch()
    }
    
}
