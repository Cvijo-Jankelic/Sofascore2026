//
//  ImageExstension.swift
//  sofascore2026
//
//  Created by akademija on 17.03.2026..
//
import UIKit

extension UIImageView {
    func loadImage(from url: URL?) {
        guard let url = url else { return }
            
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
                
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
