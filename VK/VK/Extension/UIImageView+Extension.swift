// UIImageView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit.UIImageView

// MARK: - Extension UIImageView

extension UIImageView {
    func loadImage(urlName: String) {
        guard let url = URL(string: urlName) else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
