//
//  Models.swift
//  alamofire_crud
//
//  Created by MAC on 21/12/20.
//

import Foundation
import Alamofire

struct getModeles : Codable {
    let id : Int?
    let title : String?
    let description : String?
    let image : [String]?

    

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        image = try values.decodeIfPresent([String].self, forKey: .image)
    }

}


class getservices {
    fileprivate var baseurl = ""
    typealias serviescallback = (_ getmodels: getModeles?, _ status: Bool, _ message:String) -> Void
    var service:serviescallback?
    init(baseurl:String) {
        self.baseurl = baseurl
    }
    
    
    func getdata(endpoint: String ) {
        
        AF.request(self.baseurl + endpoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).response { (responseData) in
            guard let datas = responseData.data else {
                self.service?(nil, false, "")
                return
            }
            print(datas)
            do {
                let modelservices = try JSONDecoder().decode(getModeles.self, from: datas)
                print(modelservices)
                self.service?(modelservices, true , "")
            }catch{
                
                self.service?(nil, false , error.localizedDescription)
                
            }
          
        }
    }
    func complitionHandler(callBack: @escaping serviescallback) {
        self.service = callBack
    }
    
}
