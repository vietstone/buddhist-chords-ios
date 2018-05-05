//
//  SearchViewController.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 5/5/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import UIKit

class SearchViewController: SongsListViewController, UISearchBarDelegate {
    
    private var searchBar = UISearchBar()
    
    convenience init(viewModel: SearchViewModel) {
        self.init()
        self.viewModel = viewModel
        self.viewModel.dataUpdateClosure = { [weak self] (viewState) in
            DispatchQueue.main.async {
                self?.handle(viewState: viewState)
            }
        }
    }

    private func configureUI() {
        
        searchBar.placeholder = NSLocalizedString("Search", comment: "Search placeholder")
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchBar.becomeFirstResponder()
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TextField Color Customization
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor.lightText
        
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = UIColor.white
        
        let clearButton = textFieldInsideSearchBar?.value(forKey: "clearButton") as! UIButton
        clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        clearButton.tintColor = UIColor.white
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: false, completion: nil)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // TODO
    }
}