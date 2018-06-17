//
//  SongViewController.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/14/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import UIKit
import WebKit

class SongViewController: UIViewController {
    private var webView: WKWebView!
    @IBOutlet weak var webViewContainer: UIView!
    
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
