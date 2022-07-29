//
//  Globals.swift
//  MovieOMDB
//
//  Created by prashant thakare on 13/07/22.
//

import Foundation
import UIKit
class Globals{
    
    static let shared = Globals();
    func getAttrString(str1:String,str2:String) -> NSAttributedString{
       let attrString =  NSMutableAttributedString(string: str1,attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize:12)]);
        attrString.append(NSMutableAttributedString(string: str2,
                                                    attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]));
        return attrString;
        
    }
     func showAlert(title : String, message : String, viewcontroller: UIViewController) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewcontroller.present(alert, animated: true, completion: nil)
    }
    class func fetchingDataFromLocalStorage<T:Decodable>(model:T,completion:@escaping(T?)-> Void){
       
       
       let userDefaults = UserDefaults.standard
       do {
           let result = try userDefaults.getObject(forKey: "searchItems", castTo: T.self)
           
        completion(result)
          
           
           
       } catch {
          completion(nil)
           print(error.localizedDescription)
       }
   }
}
