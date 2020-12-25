//
//  LoginViewController.swift
//  alamofire_crud
//
//  Created by MAC on 24/12/20.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var password: UITextField!
  
    var getid:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        guard let phone = phone.text else { return }
        
        guard let password = password.text else { return }
        
      
        
        var result: String?
        //let url = "http://adsumoriginator.com/apidemo/api/login"
        
        let parameter: Parameters = [
                  "phone": phone,
                  "password": password
              ]
        
        let headers: HTTPHeaders = [.contentType("application/json")]
        
        
        AF.request("https://adsumoriginator.com/apidemo/api/login", method: .post, parameters: parameter, encoding: JSONEncoding.default,headers: headers).validate(statusCode: 200..<300).responseJSON { (response) in
            print("\(response)")
        
           
            switch response.result {
                                case .success(let data):
                                    
                                    do {
                                                    let users = try JSONDecoder().decode(Json4Swift_Base.self, from: response.data!)
                                                    print(users)

                                                } catch let error as NSError {
                                                    print("Failed to load: \(error.localizedDescription)")
                                                }
                                    
                                    print("isi: \(data)")
                                    let myJson = try! JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
                                    let d = myJson["data"] as! [String: Any]
                                    let d1 = d["user"] as! [String: Any]
                                    //let pageData = try JSONDecoder().decode(Json4Swift_Base.self, from: data)
                                    //let user = try? JSONDecoder().decode(Json4Swift_Base.self, from: response.data!)
                                    print(myJson)
//                                    let decodes = try JSONDecoder().decode(Json4Swift_Base.self, from: response.data)
//                                    print("\(decodes)")
                                    
//                                    let modelservices = try JSONDecoder().decode(Logins.self, from: response.data!)
                                  
                                    UserDefaults.standard.set(response.data,forKey: "storeData")
                                    
                                    let storybrd =
                                        UIStoryboard(name: "Main", bundle: nil)
                                    let details:ViewController = storybrd.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                                    self.navigationController?.pushViewController(details, animated: true)
                                    
                                case .failure(let error):
                                    do {
                                       
                                        let modelservices = try JSONDecoder().decode(Json4Swift_Base.self, from: response.data!)
                                        let results = modelservices.message
                                        print(results)
                                        
                                        let alert = UIAlertController(title: "message", message: "\(results ?? "nills")", preferredStyle: .alert)
                                        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { (_: UIAlertAction) in
                                            print("you are wrong!!")
                                        }))
                                        
                                        self.present(alert, animated: true, completion: nil)

                                    }catch{
                                        
                                        
                                    }
                                    

                                    print("need text")
                                    print("Request failed with error: \(error)")
                             }
            
                
        
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
