//
//  DetailViewController.swift
//  incodeTest
//
//  Created by Emmanuel Lopez Guerrero on 7/13/18.
//  Copyright © 2018 Emmanuel Lopez Guerrero. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import AlamofireImage

class DetailViewController: UIViewController {
   
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var plot: UILabel!

    var name = ""
    var requestUrl = ""
    var Poster: String?
    var Title: String?
    var Plot: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImageView()
    }

    func setUpImageView() {
        requestUrl = "https://www.omdbapi.com/?apikey=1e700da7&i=\(name)&plot=full"
        
        Alamofire.request(requestUrl).responseJSON { response in
            
            let result = response.result
            
            if let json = result.value as? Dictionary<String, Any>{
                if let dictionary = json as? [String: Any] {
                    let Poster = dictionary["Poster"] as? String
                    self.lbl.text = dictionary["Title"] as? String
                    self.plot.text = dictionary["Plot"] as? String
                    
                    Alamofire.request(Poster!).responseImage { response in
                        if let image = response.result.value {
                            self.img.image  = image
                        }
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
