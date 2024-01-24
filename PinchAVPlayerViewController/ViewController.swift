//
//  ViewController.swift
//  PinchAVPlayerViewController
//
//  Created by k on 2024/1/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }


    @IBAction func playAction(_ sender: Any) {
        let playerViewController = VideoPlayerViewController(urlString: "https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4")
        present(playerViewController, animated: true)
    }
    
}

