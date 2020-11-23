//
//  GrNoida.swift
//  DTM
//
//  Created by Syedaffan on 8/24/20.
//

import UIKit


//node.js api




class Malls: UIViewController, UITableViewDelegate,  UITableViewDataSource {
   
    
    
    
    
    //all variables here
   
    var dataCount : IndexPath? = nil
    var titleArraygn : [String]? = []
    var titleArrayn : [String]? = []
    var titleArrayd : [String]? = []
    
    //table view outlet
    @IBOutlet weak var mallTableView: UITableView!
    
    
    //ui view on which the loader is placed
    //@IBOutlet weak var loderView: UIView!
    // loader duh
    //@IBOutlet weak var loder: UIActivityIndicatorView!
    //outlet for nav bar to change titles
    @IBOutlet weak var navBar: UINavigationItem!
    // scroll lenght changer so all button are hide and used when needed/ basically acesses the lenght feature /height of the view
    
    // prefered light or dark = dark
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting delgate and datasource for table view
        mallTableView.delegate = self
        mallTableView.dataSource = self
       
        // making seprator for cells clear colour
        self.mallTableView.separatorColor = .clear
        // starting loading
       // loder.startAnimating()
        // blank title for nav
        navBar.title = ""
        
            
      //  self.mallTableView.reloadData()
        
        
        }
        
    
    
    
    
    
    // main code table view
    
    // number of rows for each region i.e nummber of malls in each region are hardcoded here
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var value : Int? = nil
        if ViewController.myGlobalVar.region == "Greater Noida"{
            value = 4
        }else if ViewController.myGlobalVar.region == "Noida"{
            value = 4
        }else if ViewController.myGlobalVar.region == "Delhi"{
            value = 8
        }
        return value!
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // custom cell for our table view
        let cell = mallTableView.dequeueReusableCell(withIdentifier: "mallcells", for: indexPath) as! MallCells
        // cusrtom cell styles
        DispatchQueue.main.async {
            
            cell.mallbutton.layer.cornerRadius = 10
            cell.mallbutton.titleLabel!.layer.shadowOffset = CGSize(width: 2.0, height: 2.0);
            cell.mallbutton.titleLabel!.layer.shadowRadius = 2.0;
            cell.mallbutton.titleLabel!.layer.shadowOpacity = 1.0;
            cell.mallbutton.titleLabel!.layer.masksToBounds = false;
            cell.mallbutton.layer.opacity = 0.9
            cell.mallbutton.tag = indexPath.row
            cell.mallbutton.addTarget(self, action: #selector(self.mallTapped(_:)), for: .touchUpInside)
            
        }
        

            
            
            
            
            
            
            
            
            
            /// populating data on the cell's button!
            
            
            
            
            // checking selected region
            if ViewController.myGlobalVar.region == "Greater Noida"{
               
                
                
              
                   
               
                DispatchQueue.main.async { [self] in
                       
                      //  mallTableView.reloadData()
                        if let futureCell = tableView.cellForRow(at: indexPath) as? MallCells {
                            navBar.title = "Greater Noida"
                            futureCell.mallbutton.setBackgroundImage(UIImage(data: importer.dataimg![indexPath.row]), for: .normal)
                        
                            futureCell.mallbutton.setTitle(importer.mallsingr![indexPath.row], for: .normal)
                           
                       // futureCell.mallbutton.setTitle(importer.mallsinn![indexPath.row], for: .normal)
                        }
                      
                       
                    }
                    
                
                
                
 
            }else if ViewController.myGlobalVar.region == "Noida"{
              
             
                   
               
                    DispatchQueue.main.async { [self] in
                        navBar.title = "Noida"
                        if let futureCell = tableView.cellForRow(at: indexPath) as? MallCells {
                            futureCell.mallbutton.setBackgroundImage(UIImage(data: importer.dataimg![indexPath.row]), for: .normal)
                        
                            futureCell.mallbutton.setTitle(importer.mallsinn![indexPath.row], for: .normal)
                            
                       // futureCell.mallbutton.setTitle(importer.mallsinn![indexPath.row], for: .normal)
                        }
                        
                    }
                
            }else if ViewController.myGlobalVar.region == "Delhi"{
              
              
                   
               
                    DispatchQueue.main.async { [self] in
                        navBar.title = "Delhi"
                        if let futureCell = tableView.cellForRow(at: indexPath) as? MallCells {
                        futureCell.mallbutton.setBackgroundImage(UIImage(data: importer.dataimg![indexPath.row]), for: .normal)
                        
                            futureCell.mallbutton.setTitle(importer.mallsind![indexPath.row], for: .normal)
                            
                      //  futureCell.mallbutton.setTitle(importer.mallsind![indexPath.row], for: .normal)
                        }
                        
                    }
                
            }
            
        
            
       
        
        return cell
    }
    @objc func mallTapped(_ sender: UIButton){ // ok so this function doesnt need explanation beause i dont know how to but this is hardcoded to get hold of button tapped in each and every indiviual cells in the table view with the help of sender tag-- this func is a target func targeted on line (110)
        
        let button = sender.tag
        
        Malls.importer.sender = button // setting sender.tag to our foorsender which is  global so can be used and initalized anywhere.
        performSegue(withIdentifier: "detail", sender: self)
        
    }
    // global variables for the detail view we have
    struct importer {
        static var mallsingrimg : [String]? = []
        static var mallsinnimg : [String]? = []
        static var mallsindimg : [String]? = []
        static var mallsingr : [String]? = []
        static var mallsinn : [String]? = []
        static var mallsind : [String]? = []
        // global sender.tag
        static var sender : Int? = nil
        // global floorsender.tag
        static var floorsender : Int? = nil
        // global zoomsender.tag
        static var zoomsender : Int? = nil
        //global callsender.tag
        static var callsender : Int? = nil
        //gr noida
        
        static var gvfloors : Int? = nil
        static var omfloors : Int? = nil
        static var anfloors : Int? = nil
        static var msfloors : Int? = nil
        static var gvname :String? = nil
        static var msname :String? = nil
        static var anname :String? = nil
        static var oaname :String? = nil
        static var gvdis : String? = nil
        static var msdis : String? = nil
        static var andis : String? = nil
        static var oadis : String? = nil
        
        
        //noida
        
        static var dataimg : [Data]? = nil
        static var dataFloorLc : [Data]? = nil // array contains all the floors in lc i.e. logix city noida
        static var phoneNumberslg : [Int]? = nil
        static var phoneNumbersg : [Int]? = nil
        static var phoneNumbers1 : [Int]? = nil
        static var lcfloors : Int? = nil
        static var ggfloors : Int? = nil
        static var gpfloors : Int? = nil
        static var dmfloors : Int? = nil
        static var dmname :String? = nil
        static var lcname :String? = nil
        static var ggname :String? = nil
        static var gpname :String? = nil
        static var dmdis : String? = nil
        static var lcdis : String? = nil
        static var ggdis : String? = nil
        static var gpdis : String? = nil
        
        static var lcfloornames : [String]? = nil
        static var lcshopnameslg : [String]? = nil
        static var lcshopnamesg : [String]? = nil
        static var lcshopnames1 : [String]? = nil
        static var lcshopnames2 : [String]? = nil
        static var lcshopnames3: [String]? = nil
        static var lcshopnames4 : [String]? = nil
        
        
        //delhi
        
        
        static var vsfloors : Int? = nil
        static var tcfloors : Int? = nil
        static var ccfloors : Int? = nil
        static var cmfloors : Int? = nil
        static var dsfloors : Int? = nil
        static var amfloors : Int? = nil
        static var pmfloors : Int? = nil
        static var scfloors : Int? = nil
        static var vsname :String? = nil
        static var tcname :String? = nil
        static var ccname :String? = nil
        static var cmname :String? = nil
        static var dsname :String? = nil
        static var amname :String? = nil
        static var pmname :String? = nil
        static var scname :String? = nil
        static var vsdis : String? = nil
        static var tcdis : String? = nil
        static var ccdis : String? = nil
        static var cmdis : String? = nil
        static var dsdis : String? = nil
        static var amdis : String? = nil
        static var pmdis : String? = nil
        static var scdis : String? = nil
        
        
    }
    // stoping loding activity function
    
}

    

