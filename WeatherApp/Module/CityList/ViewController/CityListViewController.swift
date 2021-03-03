//
//  CityListViewController.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 24/01/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import UIKit
import Combine

class CityListViewController: BaseTableViewController, CityListFooterViewDelegate, UITableViewDragDelegate, UITableViewDropDelegate {
    private let viewModel: CityListViewModelProtocol
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        return formatter
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    required init(viewModel: CityListViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func configureTableView() {
        tableView.register(CityTableViewCell.self)
        tableView.registerHeaderFooter(CityListFooterView.self)
        
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
    }
        
    // MARK: TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = viewModel.dataSource[indexPath.row]
        let cell: CityTableViewCell = tableView.dequeueReusableCell()
        cell.configure(with: city, dateFormatter: dateFormatter)
        
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
    
    // MARK: TableView Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 0 ? 92 : 82
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = viewModel.dataSource[indexPath.row]
        viewModel.presentForecast(for: city)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try? viewModel.deleteCity(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: TableView Drag & Drop Delegate
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
    
    func tableView(_ tableView: UITableView,
                   dropSessionDidUpdate session: UIDropSession,
                   withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        
        if session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        guard let source = coordinator.items.first?.sourceIndexPath,
              let destination = coordinator.destinationIndexPath else {
            return
        }
       
        try? viewModel.moveCity(from: source.row, to: destination.row)
        // TODO: could be possible avoid this reload?
        tableView.reloadData()
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
