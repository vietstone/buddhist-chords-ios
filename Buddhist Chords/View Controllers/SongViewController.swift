//
//  SongViewController.swift
//  Buddhist Chords
//
//  Created by Viet Nguyen Tran on 4/14/18.
//  Copyright © 2018 iossimple. All rights reserved.
//

import UIKit
import WebKit

// TODO:
class SongViewController: UIViewController {
    private var webView: WKWebView!
    @IBOutlet weak var webViewContainer: UIView!
    
    static func createViewVC() -> SongViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SongViewController") as? SongViewController else {
            assert(false, "Wrong loading SongsListViewController from story board")
            return SongViewController()
        }
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        if let filePath = Bundle.main.path(forResource: "sample", ofType: "html") {
//            if (loadFile) {
                // load file
//                let filePathURL = URL.init(fileURLWithPath: filePath)
//                let fileDirectoryURL = filePathURL.deletingLastPathComponent()
//                webView.loadFileURL(filePathURL, allowingReadAccessTo: fileDirectoryURL)
//            } else {
                do {
                    // load html string - baseURL needs to be set for local files to load correctly
                    let html = try String(contentsOfFile: filePath, encoding: .utf8)
                    webView.loadHTMLString(html, baseURL: Bundle.main.resourceURL)
                } catch {
                    print("Error loading html")
                }
//            }
        }
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
    }

}
