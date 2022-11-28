// UIImageView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit.UIImageView

// MARK: - Extension UIImageView

/// UIImageView extension. Load image by StringURL
extension UIImageView {
    // MARK: - Pubic Methods

    func loadImage(urlName: String) {
        guard let url = URL(string: urlName) else { return }
        DispatchQueue.global().async { [weak self] in
            guard let self = self,
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else { return }

            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
