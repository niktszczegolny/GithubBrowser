//
//  ImageDownloader.swift
//  GHRepoBrowser
//
//  Created by Andrzej Puczyk on 17/07/2019.
//  Copyright © 2019 Andrzej Puczyk. All rights reserved.
//

import UIKit

class ImageDownloader {

    let imageURL: String

    init(imageURL: String) {
        self.imageURL = imageURL
    }

    func perform(_ completionBlock: ((String?, UIImage?) -> Void)?) {
        guard let url = URL(string: imageURL) else {
            completionBlock?(imageURL, nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self, completionBlock] data, response, error in
            StatusBarLoader.default.update(false)
            guard let data = data else {
                completionBlock?(self?.imageURL, nil)
                return
            }
            DispatchQueue.main.async() {
                completionBlock?(self?.imageURL, UIImage(data: data))
            }
        }

        StatusBarLoader.default.update(true)
        task.resume()
    }

}
