//
//  ListViewController.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/14/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import UIKit

enum ViewState {
    case blank
    case loading
    case data(Any?)
    case error(Error)
}

protocol SongsListViewModelProtocol {
    var list: [Song] { get }
    var viewState: ViewState { get }
    var dataUpdateClosure: ((ViewState)->())? { get set }
}

class SongsListViewController: UITableViewController {
    
    private var viewModel: SongsListViewModelProtocol!
    
    convenience init(viewModel: SongsListViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
        self.viewModel.dataUpdateClosure = { [weak self] (viewState) in
            DispatchQueue.main.async {
                self?.handle(viewState: viewState)
            }
        }
    }
    
    private func handle(viewState: ViewState) { // TODO: complement this function's logic
        switch viewState {
        case .blank:
            break
        case .loading:
            break
        case .data(_):
            tableView.reloadData()
        case .error(_):
            break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "SongTableCell", bundle: nil), forCellReuseIdentifier: "SongTableCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableCell", for: indexPath)

        if let cell = cell as? SongTableCell {
            cell.bind(viewModel.list[indexPath.row])
        }

        return cell
    }

}
