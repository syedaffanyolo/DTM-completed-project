//
//  shopView.swift
//  DTM
//
//  Created by Syedaffan on 11/15/20.
//

import UIKit
var thres = false
class shopView: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    let urlgr = "https://dtmappapi.herokuapp.com/shopgr"
    let urlgr1 = "https://dtmappapi.herokuapp.com/shopgr1"
    
    var sp: Shopgr? = nil
    var dataarr: [String] = []
    var dataarr1: [String] = []
    var dataarr2: [String] = []
    
    //outlets
    @IBOutlet weak var back: UIBarButtonItem!
    @IBOutlet weak var shopTable: UITableView!
    @IBOutlet weak var navbar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // datasource and delgates for the shop tableview
        shopTable.dataSource = self
        shopTable.delegate = self
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func callbutton(_ sender: Any) {
        
        // here add the calling the shops functionality
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if ViewController.myGlobalVar.region == "Greater Noida"{// harcoded cell numbers in row for testing
             switch Malls.importer.sender{
             case 0:
                 switch Malls.importer.floorsender{
                 case 0:
                     return Malls.importer.gvshopnumbers![0]
                 case 1:
                     return Malls.importer.gvshopnumbers![1]
                 case 2:
                     return Malls.importer.gvshopnumbers![2]
                 case 3:
                     return Malls.importer.gvshopnumbers![3]
                 case 4:
                     return Malls.importer.gvshopnumbers![4]
                 default:
                     return 0
                
                 }
             case 1:
                 switch Malls.importer.floorsender{
                 case 0:
                     return Malls.importer.shopnumbers
                 case 1:
                     return Malls.importer.shopnumbers
                 case 2:
                     return Malls.importer.shopnumbers
                 case 3:
                     return Malls.importer.shopnumbers
               
                 default:
                     return 0
                
                 }
             case 3:
                 switch Malls.importer.floorsender{
                 case 0:
                     return Malls.importer.shopnumbers
                 case 1:
                     return Malls.importer.shopnumbers
                 case 2:
                     return Malls.importer.shopnumbers
                 case 3:
                     return Malls.importer.shopnumbers
                 case 4:
                     return Malls.importer.shopnumbers
                 default:
                     return 0
                
                 }
             case 4:
                 switch Malls.importer.floorsender{
                 case 0:
                     return Malls.importer.shopnumbers
                 case 1:
                     return Malls.importer.shopnumbers
                 case 2:
                     return Malls.importer.shopnumbers
                 case 3:
                     return Malls.importer.shopnumbers
            
                 default:
                     return 0
                
                 }
             default:
                 return 1
                 
             }
         }
    
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = shopTable.dequeueReusableCell(withIdentifier: "shopid", for: indexPath) as! shopCell // custom cell for shops
        // testing only in noida becasue we have data for logix city noida only rest regions and malls will be added as soon we get their data too
        
        
        
        if ViewController.myGlobalVar.region == "Greater Noida"{
            switch Malls.importer.sender{
                
            case 0:
            
                
//                let sp = try? JSONDecoder().decode(shopgr.self, from: Data(contentsOf: URL(string: urlgr)!))
//                print("SUIIII\(sp)")
                switch Malls.importer.floorsender{
                case 0: // checking which floor is clicked in this mall
                    
                    if indexPath.row <= 3{
                        if thres == false{
                            sp = try? JSONDecoder().decode(Shopgr.self, from: Data(contentsOf: URL(string: urlgr)!))
                            print("boom")
                            thres = true
                        }
                        dataarr.append((sp?.gvlg[indexPath.row])!)
                        dataarr1.append((sp?.tlg[indexPath.row])!)
                        Malls.importer.tlg = dataarr1
                        Malls.importer.gvshopslg = dataarr
                        
                    }
                    
                    if sp != nil{
                        DispatchQueue.main.async {
                            self.navbar.title = "LG"
                            
                            cell.shopname.text = Malls.importer.gvshopslg![indexPath.row] // implementing the shops in the specif floord to the shop cells
                            cell.time.text = Malls.importer.tlg![indexPath.row]
                            cell.callshop.tag = indexPath.row
                        
                            cell.callshop.addTarget(self, action: #selector(self.callClicked(_:)), for: .touchUpInside)

                        }
                        }

                    else{
                        print("cannot get shop data for shopgr")
                    }
                case 1:
                    if indexPath.row <= 6{
                        if thres == false{
                            sp = try? JSONDecoder().decode(Shopgr.self, from: Data(contentsOf: URL(string: urlgr)!))
                            print("boom")
                            thres = true
                        }
                        dataarr.append((sp?.gvg[indexPath.row])!)
                        Malls.importer.gvshopsg = dataarr
                        dataarr1.append((sp?.tg[indexPath.row])!)
                        Malls.importer.tg = dataarr1
                    }
                    
                    if sp != nil{
                        DispatchQueue.main.async {
                            self.navbar.title = "G"
                            print(indexPath.row)
                            cell.shopname.text = Malls.importer.gvshopsg![indexPath.row] // implementing the shops in the specif floord to the shop cells
                            cell.callshop.tag = indexPath.row
                            cell.callshop.addTarget(self, action: #selector(self.callClicked(_:)), for: .touchUpInside)
                            cell.time.text = Malls.importer.tg![indexPath.row]
                        }
                        }
                        
                    else{
                        print("cannot get shop data for shopgr")
                    }
                case 2:
                    
                    if indexPath.row <= 2{
                        if thres == false{
                            sp = try? JSONDecoder().decode(Shopgr.self, from: Data(contentsOf: URL(string: urlgr)!))
                            print("boom")
                            thres = true
                        }
                        dataarr.append((sp?.gvug[indexPath.row])!)
                        Malls.importer.gvshopsug = dataarr
                        dataarr1.append((sp?.tug[indexPath.row])!)
                        Malls.importer.tug = dataarr1
                    }
                    if sp != nil{
                        DispatchQueue.main.async {
                            self.navbar.title = "UG"
                    print("")
                            cell.shopname.text = Malls.importer.gvshopsug![indexPath.row] // implementing the shops in the specif floord to the shop cells
                            cell.callshop.tag = indexPath.row
                            cell.callshop.addTarget(self, action: #selector(self.callClicked(_:)), for: .touchUpInside)
                            cell.time.text = Malls.importer.tug![indexPath.row]
                        }
                        }

                    else{
                        print("cannot get shop data for shopgr")
                    }
                case 3:
                    if indexPath.row <= 1{
                        if thres == false{
                            sp = try? JSONDecoder().decode(Shopgr.self, from: Data(contentsOf: URL(string: urlgr)!))
                            print("boom")
                            thres = true
                        }
                        dataarr.append((sp?.gv1[indexPath.row])!)
                        Malls.importer.gvshop1 = dataarr
                        dataarr1.append((sp?.t1[indexPath.row])!)
                        Malls.importer.t1 = dataarr1
                    }
                    if sp != nil{
                        DispatchQueue.main.async {
                            self.navbar.title = "1"
                        print("")
                            cell.shopname.text = Malls.importer.gvshop1![indexPath.row] // implementing the shops in the specif floord to the shop cells
                            cell.callshop.tag = indexPath.row
                            cell.time.text = Malls.importer.t1![indexPath.row]
                            cell.callshop.addTarget(self, action: #selector(self.callClicked(_:)), for: .touchUpInside)

                        }
                        }

                    else{
                        print("cannot get shop data for shopgr")
                    }
                case 4:
                    
                    if indexPath.row <= 2{
                        if thres == false{
                            sp = try? JSONDecoder().decode(Shopgr.self, from: Data(contentsOf: URL(string: urlgr)!))
                            print("boom")
                            thres = true
                        }
                        dataarr.append((sp?.gv2[indexPath.row])!)
                        Malls.importer.gvshops2 = dataarr
                        dataarr1.append((sp?.t2[indexPath.row])!)
                        Malls.importer.t2 = dataarr1
                    }
                    
                                        if sp != nil{
                        DispatchQueue.main.async {
                            self.navbar.title = "2"

                            cell.shopname.text = Malls.importer.gvshops2?[indexPath.row] // implementing the shops in the specif floord to the shop cells
                            cell.callshop.tag = indexPath.row
                            cell.time.text = Malls.importer.t2![indexPath.row]
                            cell.callshop.addTarget(self, action: #selector(self.callClicked(_:)), for: .touchUpInside)

                        }
                        }

                    else{
                        print("cannot get shop data for shopgr")
                    }
                default:
                    return cell
               
                }
                
                
                
            case 1:
               print("")
            case 2:
                print("")
            default:
                return cell
            }
          
            
            
        }
        else if ViewController.myGlobalVar.region == "Noida"{// checking region
            let task = URLSession.shared.dataTask(with: URL(string: urlgr)!, completionHandler: { [self]data, response, error in
                guard let data = data, error == nil else{
                    print("somthin wrong")
                    return
                }
                var result: shopn?
                do {
                    result = try JSONDecoder().decode(shopn.self, from: data)
                } catch  {
                    print("thisisthe\(error)")
                }
                guard let json = result else{
                    
                    return
                }
                // Malls.importer.lcfloornames = json.lcfloornames // malls floornames
                 Malls.importer.lcshopnameslg = json.lcshopslg // shops in lower ground
                 Malls.importer.lcshopnamesg = json.lcshopg // shops in ground
                 Malls.importer.lcshopnames1 = json.lcshop1 // shops in 1st floor
                 Malls.importer.lcshopnames2 = json.lcshop2 // 2nd
                 Malls.importer.lcshopnames3 = json.lcshop3 // 3rd
                 Malls.importer.lcshopnames4 = json.lcshop4 // 4th
                 Malls.importer.phoneNumberslg = json.lcshopphonelg // getting all the phone numbers in lg floor into this array
                
                switch Malls.importer.sender {// checking which mall is selected in that region
                case 0: // dlf mall
                    print("lol") // no data so dummy code
                    DispatchQueue.main.async {
                        navbar.title = "DLF Mall"
                    }
                   
                case 1: // logix mall (got the data for this one)
                    DispatchQueue.main.async {
                    navbar.title = "Logix City"
                    if Malls.importer.floorsender == 0{ // checking which floor is clicked in this mall
                        cell.shopname.text = Malls.importer.lcshopnameslg![indexPath.row] // implementing the shops in the specif floord to the shop cells
                        cell.callshop.tag = indexPath.row
                        cell.callshop.addTarget(self, action: #selector(callClicked(_:)), for: .touchUpInside)
                    }else if Malls.importer.floorsender == 1{
                        cell.shopname.text = Malls.importer.lcshopnamesg![indexPath.row]
                    }else if Malls.importer.floorsender == 2{
                        cell.shopname.text = Malls.importer.lcshopnames1![indexPath.row]
                    }
                    }
                case 2:
                    navbar.title = "Garden Galleria"
                    print("lol")
                case 3:
                    navbar.title = "GIP Mall"
                    print("lol")
                    
                default:
                    return //UITableViewCell()
                }
            })
            task.resume()
            
    }
        return cell
    }
 
    
    @IBAction func back(_ sender: Any) {
        print("hereis\(Malls.importer.gr1images)")
        thres = false
        performSegue(withIdentifier: "backtodetail", sender: self)
    }
    
    
   @objc func callClicked(_ sender: UIButton){
        
        let callButton = sender.tag
        
        Malls.importer.callsender = callButton
        
       if ViewController.myGlobalVar.region == "Greater Noida"{// checking region
           
           switch Malls.importer.sender {
              
               case 0:
               switch Malls.importer.floorsender{
               case 0:
                   for i in 0...3{
                       if i == Malls.importer.callsender{
                           guard let number = URL(string: "tel://" + (sp?.phlg[Malls.importer.callsender!])!) else { return }
                                                     UIApplication.shared.open(number)
                       }
                   }
               case 1:
                   for i in 0...5{
                       if i == Malls.importer.callsender{
                           guard let number = URL(string: "tel://" + (sp?.phg[Malls.importer.callsender!])!) else { return }
                                                     UIApplication.shared.open(number)
                       }
                   }
               case 2:
                   for i in 0...1{
                       if i == Malls.importer.callsender{
                           guard let number = URL(string: "tel://" + (sp?.phug[Malls.importer.callsender!])!) else { return }
                                                     UIApplication.shared.open(number)
                       }
                   }
               case 4:
                   for i in 0...0{
                       if i == Malls.importer.callsender{
                           guard let number = URL(string: "tel://" + (sp?.ph1[Malls.importer.callsender!])!) else { return }
                                                     UIApplication.shared.open(number)
                       }
                   }
               case 2:
                   for i in 0...1{
                       if i == Malls.importer.callsender{
                           guard let number = URL(string: "tel://" + (sp?.ph2[Malls.importer.callsender!])!) else { return }
                                                     UIApplication.shared.open(number)
                       }
                   }
                

                   
                
               default:
                   return
                   }
           default:
               return
               }
              
                   
                   
           }
           
        
        if ViewController.myGlobalVar.region == "Noida"{// checking region
            
            switch Malls.importer.sender {// checking which mall is selected in that region
            case 0: // dlf mall
                print("lol") // no data so dummy code
            case 1: // logix mall (got the data for this one)
                if Malls.importer.floorsender == 0{ // checking which floor is clicked in this mall
                   
                    for calltag in 0...3{
                        if Malls.importer.callsender == calltag{
                            let phone = Malls.importer.phoneNumberslg![calltag]
                            guard let number = URL(string: "tel://" + "\(phone)") else { return }
                            UIApplication.shared.open(number)
                        }
                    }
                    
                }else if Malls.importer.floorsender == 1{
                    
                }else if Malls.importer.floorsender == 2{
                    
                }
            case 2:
                print("lol")
            case 3:
                print("lol")
                
            default:
                return
            }
        }
        print("calling")
    }
    }


    


//
