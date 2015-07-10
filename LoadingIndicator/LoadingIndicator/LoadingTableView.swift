//
//  LoadingTableView.swift
//  LoadingIndicator
//
//  Created by Sztanyi Szabolcs on 10/07/15.
//  Copyright (c) 2015 Zappdesigntemplates. All rights reserved.
//

import UIKit

class LoadingTableView: UITableView {

    let loadingImage = UIImage(named: "loadingIndicator")
    var loadingImageView: UIImageView

    required init(coder aDecoder: NSCoder) {
        loadingImageView = UIImageView(image: loadingImage)
        super.init(coder: aDecoder)
        addSubview(loadingImageView)
        adjustSizeOfLoadingIndicator()
    }

    func showLoadingIndicator() {
        loadingImageView.hidden = false
        self.bringSubviewToFront(loadingImageView)

        startRefreshing()
    }

    func hideLoadingIndicator() {
        loadingImageView.hidden = true

        stopRefreshing()
    }

    override func reloadData() {
        super.reloadData()
        self.bringSubviewToFront(loadingImageView)
    }

    // MARK: private methods
    // Adjust the size so that the indicator is always in the middle of the screen
    override func layoutSubviews() {
        super.layoutSubviews()
        adjustSizeOfLoadingIndicator()
    }

    private func adjustSizeOfLoadingIndicator() {
        let loadingImageSize = loadingImage?.size
        loadingImageView.frame = CGRectMake(CGRectGetWidth(frame)/2 - loadingImageSize!.width/2, CGRectGetHeight(frame)/2-loadingImageSize!.height/2, loadingImageSize!.width, loadingImageSize!.height)
    }

    // Start the rotating animation
    private func startRefreshing() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.removedOnCompletion = false
        animation.toValue = M_PI * 2.0
        animation.duration = 0.8
        animation.cumulative = true
        animation.repeatCount = Float.infinity
        loadingImageView.layer.addAnimation(animation, forKey: "rotationAnimation")
    }

    // Stop the rotating animation
    private func stopRefreshing() {
        loadingImageView.layer.removeAllAnimations()
    }
}
