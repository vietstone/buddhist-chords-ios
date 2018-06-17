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
    @IBOutlet weak var chordsLabel: UILabel!
    @IBOutlet weak var chordsButton: UIButton!
    
    // dummy
    var isChecked = false
    
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
        
        let wrapperContent = SongViewController.wrapperContent
        let songContent = song?.content ?? ""
        let displayContent = wrapperContent.replacingOccurrences(of: "<----------body---------->", with: songContent)
        
        webView.loadHTMLString(displayContent, baseURL: nil)
        
        
        // Chords handle
        chordsLabel.text = NSLocalizedString("On/off chords", comment: "")
        updateCheckBoxImage()
        chordsButton.addTarget(self, action: #selector(dummyHandleCheckbox), for: .touchUpInside)
        
        // Mp3
        let listenButton = UIBarButtonItem(title: NSLocalizedString("Listen", comment: ""), style: .plain, target: self, action: #selector(openMp3))
        navigationItem.rightBarButtonItem = listenButton
    }
    
    @objc func openMp3() {
        let link = "http://data17.chiasenhac.com/downloads/1039/0/1038064-720f3451/128/Moi%20Ngay%20Toi%20Chon%20Mot%20Niem%20Vui%20-%20Hong%20Nh%20[128kbps_MP3].mp3"
        if let url = URL(string: link) {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
    }
    
    @objc private func dummyHandleCheckbox() {
        isChecked = !isChecked
        updateCheckBoxImage()
    }
    
    private func updateCheckBoxImage() {
        let image = isChecked ? #imageLiteral(resourceName: "checked_box") : #imageLiteral(resourceName: "unchecked_box")
        chordsButton.setImage(image, for: .normal)
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
