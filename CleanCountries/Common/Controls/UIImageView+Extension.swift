//
//  UIImageView+Extension.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 14/12/2020.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func downloadImage(with url: URL?) {
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "flag_placeholder"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ], completionHandler:
                {
                    result in
                    switch result {
                    case .success(_):
                        break
                    case .failure(let error):
                        AppLog.d("Failed to download image with error: \(error.localizedDescription)")
                    }
                })
    }
}
