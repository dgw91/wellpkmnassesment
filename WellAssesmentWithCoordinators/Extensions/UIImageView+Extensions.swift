//
//  UIImageView+Extensions.swift
//  WellPokemonAssesment_Wilde
//
//  Created by Derrick Wilde on 6/6/24.
//

import Foundation
import UIKit

extension UIImageView {
    func loadFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Error handling...
            guard let imageData = data else { return }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }.resume()
    }
}
