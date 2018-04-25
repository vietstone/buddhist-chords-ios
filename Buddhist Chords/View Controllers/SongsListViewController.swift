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
            if let refreshControl = self.refreshControl, !refreshControl.isRefreshing {
                refreshControl.beginRefreshing()
                let newContentOffset = tableView.contentOffset.y - refreshControl.frame.size.height
                tableView.setContentOffset(CGPoint(x: 0, y: newContentOffset), animated: true)
            }
        case .data(_):
            refreshControl?.endRefreshing()
            tableView.reloadData()
        case .error(let error):
            refreshControl?.endRefreshing()
            alert(error: error)
            break
        }
    }
    
    private func configureUI() {
        tableView.register(UINib(nibName: "SongTableCell", bundle: nil), forCellReuseIdentifier: "SongTableCell")
        tableView.tableFooterView = UIView()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.refreshControl = refreshControl
        
        navigationItem.backBarButtonItem = UIBarButtonItem.noTitleBackItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        refresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Refreshing data
    
    @objc func refresh() {
        if viewModel.canFetch {
            viewModel.fetch()
        } else {
            refreshControl?.endRefreshing()
        }
    }
    
    // MARK: - Alert
    private func alert(error: Error) {
        let alert = UIAlertController.errorAlert(title: NSLocalizedString("Error", comment: "Error Inform"), message: error.localizedDescription)
        self.present(alert, animated: true, completion: nil)
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
