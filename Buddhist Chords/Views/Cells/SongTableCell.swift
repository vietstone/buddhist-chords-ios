//
//  SongTableCell.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/14/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import UIKit

class SongTableCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBAction func pressFavorite(_ sender: Any) {
        guard let song = song else {
            return
        }
        
        // logic for data
        song.toggleFavorite()
        
        // re-display UI
        bind(song)
    }
    
    private var song: Song?
    
    func bind(_ song: Song) {
        self.nameLabel.text = song.name
        let favoriteImage = song.isFavorited ? #imageLiteral(resourceName: "favorited_yes") : #imageLiteral(resourceName: "favorited_no")
        favoriteButton.setImage(favoriteImage, for: .normal)
        
        self.song = song
    }
}

extension SongTableCell {
    
}
