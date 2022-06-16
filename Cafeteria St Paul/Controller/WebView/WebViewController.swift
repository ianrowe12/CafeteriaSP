//
//  WebViewController.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 5/27/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    
    let webView = WKWebView()
    
    override func viewWillDisappear(_ animated: Bool) {
        Haptics.selectionVibration()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.addSubview(webView)
        
        guard let url = URL(string: "https://vidrr2005.github.io/SodaSP/") else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
