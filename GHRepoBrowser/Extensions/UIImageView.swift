//
//  UIImageView.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 19/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

open class UIImageView: UIKit.UIImageView {

    var imageURL: String? {
        didSet {
            guard let imageURL = imageURL else {
                if oldValue != nil {
                    // remove downloader and image (previously set with old url)
                    imageDownloader = nil
                    image = nil
                }
                return
            }

            imageDownloader = ImageDownloader(imageURL: imageURL)
            imageDownloader?.perform { [weak self] (imageURL, image) in
                guard self?.imageURL == imageURL else {
                    return
                }
                DispatchQueue.main.async { self?.image = image }
            }
        }
    }

    private var imageDownloader: ImageDownloader?

}
