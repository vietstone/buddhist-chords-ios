//
//  SongViewController.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/14/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import UIKit
import WebKit
import SafariServices

class SongViewController: UIViewController {
    private var webView: WKWebView!
    @IBOutlet weak var webViewContainer: UIView!
    
    @IBOutlet weak var topControlsView: UIView!
    @IBOutlet weak var chordsLabel: UILabel!
    @IBOutlet weak var chordsButton: UIButton!
    
    var isDisplayingChords = false
    
    private var song: Song?
    
    static var wrapperContent: String {
        guard let filepath = Bundle.main.path(forResource: "wrapper", ofType: "html") else {
            assert(false, "Wrong opening file wrapper.html")
            return ""
        }
        
        guard let content = try? String(contentsOfFile: filepath) else {
            assert(false, "Wrong loading content from wrapper.html")
            return ""
        }
        
        return content
    }
    
    static func createViewVC(with song: Song) -> SongViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SongViewController") as? SongViewController else {
            assert(false, "Wrong loading SongsListViewController from story board")
            return SongViewController()
        }
        vc.song = song
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        title = song?.name
        
        updateControls()
        updateWebviewContent()
    }
    
    private func updateControls() {
        // Chords
        if let _ = song?.contentWithChords {
            topControlsView.isHidden = false
            chordsLabel.text = NSLocalizedString("On/off chords", comment: "")
            chordsButton.addTarget(self, action: #selector(handleChangeChordsCheckbox), for: .touchUpInside)
            updateChordsCheckBoxImage()
        } else {
            topControlsView.isHidden = true
        }
        
        // Mp3
        if let _ = song?.mp3Link {
            let listenButton = UIBarButtonItem(title: NSLocalizedString("Listen", comment: ""), style: .plain, target: self, action: #selector(openMp3))
            navigationItem.rightBarButtonItem = listenButton
        }
    }
    
    @objc func openMp3() {
        if let mp3Link = song?.mp3Link {
            if let url = URL(string: mp3Link) {
                let vc = SFSafariViewController(url: url)
                present(vc, animated: true)
            }
        }
    }
    
    @objc private func handleChangeChordsCheckbox() {
        isDisplayingChords = !isDisplayingChords
        updateChordsCheckBoxImage()
        updateWebviewContent()
    }
    
    private func updateChordsCheckBoxImage() {
        let image = isDisplayingChords ? #imageLiteral(resourceName: "checked_box") : #imageLiteral(resourceName: "unchecked_box")
        chordsButton.setImage(image, for: .normal)
    }
    
    private func updateWebviewContent() {
        let content = song?.content ?? ""
        let contentWithChords = song?.contentWithChords ?? ""
        let contentToDisplay = isDisplayingChords ? contentWithChords : content
        
        let wrapperContent = SongViewController.wrapperContent
        let displayContent = wrapperContent.replacingOccurrences(of: "<----------body---------->", with: contentToDisplay)
        
        webView.loadHTMLString(displayContent, baseURL: nil)
    }
    
    private func initView() {
        webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.webViewContainer.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: self.webViewContainer.topAnchor),
            webView.leftAnchor.constraint(equalTo: self.webViewContainer.leftAnchor),
            webView.bottomAnchor.constraint(equalTo: self.webViewContainer.bottomAnchor),
            webView.rightAnchor.constraint(equalTo: self.webViewContainer.rightAnchor)
            ])
        
        if #available(iOS 11, *) {
            // ok, nothing
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }

}
