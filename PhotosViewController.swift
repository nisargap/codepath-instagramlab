//
//  PhotosViewController.swift
//  InstagramLab
//
//  Created by Nisarga Patel on 2/4/16.
//  Copyright © 2016 Nisarga Patel. All rights reserved.
//
import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var photosView: UITableView!
    var pics : [NSDictionary]?
    override func viewDidLoad() {
        super.viewDidLoad()
        photosView.dataSource = self
        photosView.delegate = self
        
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
//                            NSLog("response: \(responseDictionary)")
                            
                            self.pics = responseDictionary["data"] as? [NSDictionary]
                            self.photosView.reloadData()
                            
                    }
                }
        });
        task.resume()
        // Do any additional setup after loading the view.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if let pics = pics {
            
            return pics.count
        } else {
            
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        /*
        let picDetails = pics![indexPath.row]
        
        let images = picDetails["images"] as! NSDictionary
        
        print(images["low_resolution"])
        */
        /*
        let low_res = images["low_resolution"] as! NSDictionary
        
        let low_res_url = low_res["url"] as! String
        */
        /*
        let imageUrl = NSURL(string: low_res_url)
        
        NSLog(low_res_url)
        */
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell") as! InstagramCell
        
        let picDetails = pics![indexPath.row]
        
        let images = picDetails["images"] as! NSDictionary
        
        let imageObj = images["low_resolution"] as! NSDictionary
        
        print(imageObj["url"] as! String)
        
        let imageURL = NSURL(string: imageObj["url"] as! String)
        
        cell.InstagramImage.setImageWithURL(imageURL!)
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
