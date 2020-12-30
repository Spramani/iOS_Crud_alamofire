//
//  create_ItemViewController.swift
//  Crud_alamofire
//
//  Created by MAC on 28/12/20.
//

import UIKit
import Alamofire

class create_ItemViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
//    static let shared = create_ItemViewController()
//
//    let defaults = UserDefaults(suiteName: "shubh.Crud-alamofire")
    var storedata:String?
       
    var dats = [itemmodel]()
    var imagess:UIImage?

    @IBOutlet weak var imagename: UILabel!
    @IBOutlet weak var descriptions: UITextField!
    @IBOutlet weak var titles: UITextField!
    @IBOutlet weak var images: UITextField!
    
    @IBOutlet weak var imageviw: UIImageView!
    var tokenstore : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titles.delegate = self
        descriptions.delegate = self
        
    
//        tokenstore = UserDefaults.standard.value(forKey: "storeData") as! String
        
        print("\(storedata)")
     //   images.delegate = self
        
//        let values = UserDefaults.standard.g
        // Do any additional setup after loading the view.
    }
    
    @IBAction func button(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self

        let actionsheet = UIAlertController(title: "Photo Source", message: "Choose a Source", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionsheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))

        actionsheet.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))

        self.present(actionsheet, animated: true, completion: nil)

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imaged = info[UIImagePickerController.InfoKey.originalImage]  as! UIImage
        imageviw.image = imaged
        imagess = imaged
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
    @IBAction func add(_ sender: UIButton) {
//        addtitem()
        //imagesss()
        let dataimage = imagess!.jpegData(compressionQuality: 1)!
       
        send_img(data_img: dataimage)
    }
   
 
    func addtitem() {
        let parameter:Parameters = ["title": titles.text!, "description": descriptions.text!, "image": images.text!]

        let headers: HTTPHeaders = ["contentType": "multipart/form-data"]
                
        AF.request("https://adsumoriginator.com/apidemo/api/create_item", method: .post, parameters: parameter, encoding: JSONEncoding.default,headers: headers).validate(statusCode: 200..<600).responseJSON { (response) in
            switch  response.result {
            case .success(let data):
                    print("\(data)")
            break
            case .failure(let error):
                    print("\(error)")
            break
            }
            print("\(response)")
        
        }
    }
    
    func send_img(data_img : Data?){
        
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(storedata ?? "hello")","Content-type": "multipart/form-data"]
        print(storedata)
       
        let parameter:Parameters = ["title": titles.text!, "description": descriptions.text!]
        AF.upload(multipartFormData: { (multipartFormData) in
            print(multipartFormData)
                if let  data = data_img {
                multipartFormData.append(data, withName: "image[]", fileName: "image.jpeg", mimeType: "image/jpeg")
                }
                for (key, value) in parameter
                {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
        }, to:"https://adsumoriginator.com/apidemo/api/create_item", usingThreshold: UInt64.init(),method: .post, headers: headers).responseJSON
        { (response) in
                                print(response)
                                switch response.result {
                                case .success(let value) :
//                                    let json = value as! [String:Any]
//                                    if json["result"] as! Bool  {
                                        print("data sent success\(value)")
                                      //  self.displayMsg(title: "Alert", msg: "Query sent successfully")
//                                        self.navigationController?.popViewController(animated: true)
//                                    }else{
//                                    //    self.displayMsg(title: "Alert", msg: "Some thing went wrong")
//                                         print("wrong message")
//                                    }
//                                    //                SVProgressHUD.dismiss()
            
                                case .failure(let error):
                                    //            SVProgressHUD.dismiss()
                               //     self.displayMsg(title: "Alert", msg: "Fail to sent query")
                                    
                                    print(error)
                                }
                            }
    }
    
    
    
//
    @IBAction func submitBtnTap(sender: UIButton) {

            //let data = imagesArray + documentArray
            if titles.text!.isEmpty{
                print("enter data")
                //  self.displayMsg(title: "Alert", msg: "Please select hospital")
            }else if descriptions.text!.isEmpty{
                print("enter data")
                // self.displayMsg(title: "Alert", msg: "Please enter description")
            }else{

//                let imageary = imagesArray
//                let documentary = documentArray
                let url : String = "https://adsumoriginator.com/apidemo/api/create_item"
                let imageary: [String] = [""]
                let headers: HTTPHeaders = ["Authorization": "Bearer \(storedata)","Content-type": "multipart/form-data"]
              
                
                let param:Parameters = ["title": titles.text!, "description": descriptions.text!]
//                let param   = ["hospital_name": selectHosptitalTxtFld.text!,
//                               "description": descrptionTxtFld.text! ] as [String : Any]

                AF.upload(multipartFormData: { [self] (multipartFormData) in

                    for (key, value) in param {
                        multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                    }
                    for img in imageary {
                        guard let imgData = imagess!.jpegData(compressionQuality: 1) else { return }
                        multipartFormData.append(imgData, withName: "image[]", fileName: "\(Date().timeIntervalSince1970)" + ".png", mimeType: "image/png")
                    }
//                    }
                    if imageary.isEmpty {
                        multipartFormData.append(("").data(using: String.Encoding.utf8)!, withName: "image[]")
                    }
                },to: url, usingThreshold: UInt64.init(),
                  method: .post,headers: headers).responseJSON { (response) in
                    print(response)
                    switch response.result {
                    case .success(let value) :
                        let json = value as! [String:Any]
                        print(json)

                    case .failure(let error):
                        //            SVProgressHUD.dismiss()
                       // self.displayMsg(title: "Alert", msg: "Fail to sent query")
                        print(error)
                    }
                }

    

            }
        }

    

}
