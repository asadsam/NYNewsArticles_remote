//
//  Utils.swift
//  NYNewsArticles
//
//  Created by Asadullah Jamadar on 28/04/2023.
//

import Foundation
import UIKit

extension NSObject
{
    func convertModelToData<T:Codable>(_ model:T)->Data?
    {
        do
        {
            let reqData = try JSONEncoder().encode(model)
            return reqData
        }
        catch let error
        {
            print(error)
            return nil
        }
    }
    func convertDataToModel<E:Codable>(_ data:Data , type:E.Type)->E?
    {
        do
        {
            let response = try JSONDecoder().decode(type, from: data)
            return response
        }
        catch let error
        {
            print(error)
            return nil
        }
    }
}

extension UIImageView {
    func download(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill, placeholder: UIImage? = nil) {
        contentMode = mode
        image = placeholder
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print("error on download \(error ?? URLError(.badServerResponse))")
                return
            }
            guard 200 ..< 300 ~= response.statusCode else {
                print("statusCode != 2xx; \(response.statusCode)")
                return
            }
            guard let image = UIImage(data: data) else {
                print("not valid image")
                return
            }
            DispatchQueue.main.async {
                print("download completed \(url.lastPathComponent)")
                self.image = image
            }
        }.resume()
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
