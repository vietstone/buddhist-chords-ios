//
//  ListViewController.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/14/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import UIKit

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
        tableView.tableFooterView = UIView()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
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
            let song = viewModel.list[indexPath.row]
            cell.bind(song)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = viewModel.list[indexPath.row]
        let songVC = SongViewController.createViewVC(with: song)
        self.navigationController?.pushViewController(songVC, animated: true)
    }

}
