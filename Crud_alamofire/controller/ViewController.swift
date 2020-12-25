//
//  ViewController.swift
//  alamofire_crud
//
//  Created by MAC on 21/12/20.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var getmodels = [getModeles]()
   
    @IBOutlet weak var tblViews: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dataget()
    }
    
    //get data
//    http://adsumoriginator.com/apidemo/api/list_item
    
    
    func dataget() {
        let dataes  = getservices(baseurl: "https://adsumoriginator.com/apidemo/api/")
        dataes.getdata(endpoint: "list_item")
        dataes.complitionHandler {[weak self] (getmodels, status, message) in
            if status {
                guard let self = self  else {
                    return
                }
                guard let getmodeldats = getmodels else {
                    return
                }
                self.getmodels = [getmodeldats]
                self.tblViews.reloadData()
                
                
            }
        }
        print(dataes)
    }


}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getmodels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = tblViews.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! tableCell
        let getdata = getmodels[indexPath.row]
        cells.first.text = getdata.title
        cells.second.text = getdata.description
        return cells
    }
    

}


class tableCell:UITableViewCell {
    @IBOutlet weak var first:UILabel!
    
    @IBOutlet weak var second: UILabel!
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
