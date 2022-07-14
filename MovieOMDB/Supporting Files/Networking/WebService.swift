//
//  WebService.swift
//  MovieOMDB
//
//  Created by prashant thakare on 13/07/22.
//

import Foundation
class WebService{
    static let shared = WebService();
    func apiCalling<T:Decodable>(url:String,Request:[String:Any]?,Response:T,completionHandler:@escaping (Bool,T?) -> Void){
        
        guard let url = URL(string: url) else{
            return
        }
        var urlReq = URLRequest(url:url);
        urlReq.allowsCellularAccess = true
        URLSession.shared.dataTask(with: urlReq) { (data, response, err) in
            guard let data = data else{
                completionHandler(false,nil)
                return
            }
            do{
                let result = try JSONDecoder().decode(T.self, from: data);
                print(result)
                completionHandler(true,result);
                
            }
            catch{
                completionHandler(false,nil);
            }
        }.resume();
    }
    
}
