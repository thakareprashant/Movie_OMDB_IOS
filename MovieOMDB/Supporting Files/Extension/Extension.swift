//
//  Extension.swift
//  MovieOMDB
//
//  Created by prashant thakare on 14/07/22.
//

import Foundation
import UIKit
extension UIImageView {
    func load(url: URL, completion:@escaping(Bool) -> Void
    ) {
        self.image = nil
            
            URLSession.shared.dataTask(with:url, completionHandler: { (data, response, error) -> Void in

                if error != nil {
                    print(error as Any)
                    completion(false)
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: data!)
                    self.image = image
                    completion(true)
                })

            }).resume()
        
        
        
        
        
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//
//                        self?.image = image
//                        completion(true)
//                    }
//                }
//                else{
//                    completion(false)
//                }
//            }
//            else{
//                completion(false)
//            }
//
//        }
//    }
}
}

