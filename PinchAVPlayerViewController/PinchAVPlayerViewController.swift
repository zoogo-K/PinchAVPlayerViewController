//
//  ViewController.swift
//  PinchAVPlayerViewController
//
//  Created by k on 2024/1/24.
//


import UIKit
import AVKit

class VideoPlayerViewController: AVPlayerViewController {
    
    convenience init(urlString: String) {
        self.init()
        player = AVPlayer(url: URL(string: urlString)!)
        player?.play()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        processSubviews(view)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        view.viewWithTag(999)?.addGestureRecognizer(pinchGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.viewWithTag(999)?.addGestureRecognizer(panGesture)
    }
    
    private func processSubviews(_ view: UIView) {
        for subview in view.subviews {
            if NSStringFromClass(type(of: subview)) == "AVPlaybackContentContainerView" {
                subview.tag = 999
            }
            if NSStringFromClass(type(of: subview)) == "__AVPlayerLayerView" {
                subview.tag = 1000
            }
            processSubviews(subview)
        }
    }
    
    @objc private func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        guard let vv = view.viewWithTag(1000) else { return }

        if gesture.state == .began || gesture.state == .changed {
            vv.layer.transform = CATransform3DScale(vv.layer.transform, gesture.scale, gesture.scale, 0)
            gesture.scale = 1
        }
    }

    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view)
        guard let vv = view.viewWithTag(1000) else { return }
        if gesture.state == .began || gesture.state == .changed {
            let newCenter = CGPoint(x: vv.layer.position.x + translation.x, y: vv.layer.position.y + translation.y)
            vv.layer.position = newCenter
            gesture.setTranslation(CGPoint.zero, in: self.view)
        }
    }
}
