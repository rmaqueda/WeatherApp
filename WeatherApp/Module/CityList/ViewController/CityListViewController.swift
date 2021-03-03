//
//  CityListViewController.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 24/01/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import UIKit
import Combine

class CityListViewController: BaseTableViewController, CityListFooterViewDelegate, UITableViewDragDelegate {
    private let viewModel: CityListViewModelProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    required init(viewModel: CityListViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
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
        footerView.configure(for: viewModel.unitTemperature)
        
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
        // TODO: Finish magnitude change feature
        //viewModel.unitTemperature.toggle()
    }
    
    func didPressTWCButton() {
        viewModel.didPressTWC()
    }
    
    func didPressSearchButton() {
        viewModel.presentCitySearch()
    }
    
}
