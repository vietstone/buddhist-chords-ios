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
    
    override func lastInit() {
        self.modalTransitionStyle = .crossDissolve
    }

    private func configureUI() {
        
        searchBar.placeholder = NSLocalizedString("Search", comment: "Search placeholder")
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(pressCancel))
    }
    
    @objc private func pressCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Textfield color customization
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
        
        // Active the search bar
        searchBar.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.resignFirstResponder()
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let vm = viewModel as? SearchViewModel {
            vm.filter(with: searchText)
        }
    }
}
