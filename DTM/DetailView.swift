//
//  DetailView.swift
//  DTM
//
//  Created by Syedaffan on 10/25/20.
//
import UIKit
import MapKit


class DetailView: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    
    
    // all outlets
    //api link
    let url = "https://dtmappapi.herokuapp.com/detailgr"
    let url2 = "https://dtmappapi.herokuapp.com/detailn"
    let url3 = "https://dtmappapi.herokuapp.com/detaild"
    var counter  = 0
    var imageArrForgv : [Data]? = []
    var imageArrFormm : [Data]? = []
    var imageArrForoa : [Data]? = []
    var imageArrForap : [Data]? = []
    var imageArrForlc : [Data]? = []
    
    

    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var detailTable: UITableView!
    @IBOutlet weak var navigation: UIButton!
    @IBOutlet weak var dislabel: UILabel!
    @IBOutlet weak var mallimage: UIImageView!
    @IBOutlet weak var zoomImage: UIImageView!
    @IBOutlet var zoomView: UIView!
    @IBOutlet var blurView: UIVisualEffectView!

    
    
    
    
    var floornumbercell : Int? = nil // cell amount variable to be used later
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setting delgate and data source for our table view
        detailTable.delegate = self
        detailTable.dataSource = self
        //rendering all the detail for the selcted mall while the detail seque starts at first
        
        blurView.bounds = self.view.bounds
        zoomView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width*0.9, height: self.view.bounds.height*0.8)
        zoomView.layer.cornerRadius = 5
        counter = 0
       // navigation.isEnabled = false
      
    //print("heloo\(floornumbercell)")
    }
    // navigation/map action
    @IBAction func navigationButton(_ sender: Any) {
        //giving address to the mapkit to the value of the current value of dislabel
        coordinates(forAddress: dislabel.text!) {
            (location) in
            guard let location = location else {
                // Handle error here.
                return
            }
            //opening the directions for that location
            self.openMapForPlace(lat: location.latitude, long: location.longitude)
        }
        
    }
    
    
    @IBAction func cancelZoomClicked(_ sender: Any) {
        
        animateScaleOut(desiredView: zoomView)
        animateScaleOut(desiredView: blurView)
        
    }
    
    
    // big boss 2 lies her e
    
    //table view stubs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ViewController.myGlobalVar.region == "Greater Noida"{
            switch Malls.importer.sender {
            case 2:
                return 5
            default:
               return 3
            }
           
        }else if ViewController.myGlobalVar.region == "Noida"{
            return 3
        }else{
            return 3
        }// testing number for logix city data
        //floornumbercell! // amount of cells to be presented  = floors in mall
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        
        navBar.title = ""
        let cell = detailTable.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! floorCell // custom cell
//
//            cell.floorButton.isEnabled = false
//            cell.floorButton.isUserInteractionEnabled = false
        
      
        
            if ViewController.myGlobalVar.region == "Greater Noida"{
                
                let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { [self]data, response, error in
                    guard let data = data, error == nil else{
                        print("somthin wrong")
                        return
                    }
                    var result: detailgr?
                    do {
                        result = try JSONDecoder().decode(detailgr.self, from: data)
                        
                      
                    } catch  {
                        print(error)
                    }
                    
                    guard let json = result else{
                        
                        return
                    }
                    Malls.importer.gvfloors = json.gvfloors
                      Malls.importer.gvdis = json.gvdis
                      Malls.importer.gvfloors = json.gvfloors
                      Malls.importer.msdis = json.mmdis
                      Malls.importer.msfloors = json.mmfloors
                      Malls.importer.andis = json.apdis
                      Malls.importer.anfloors = json.apfloors
                      Malls.importer.oadis = json.oadis
                      Malls.importer.omfloors = json.oafloors
                      Malls.importer.gvfloornames = json.gvfloornames
                      Malls.importer.mmfloornames = json.mmfloornames
                    Malls.importer.apfloornames = json.apfloornames
                    Malls.importer.oafloornames = json.oafloornames
             
                    
                    switch Malls.importer.sender {
                    //if the sender.tag was 0..3 do this
                    
                    case 0:// on zero tag we know its grand venice hence we do the following stuff
                        //setting nav title
                        floornumbercell = 3
                        print(indexPath.row)
                        if indexPath.row == 0 && counter == 0{
                            let gvfloorurl = [URL(string: json.gvfloorimages[0])!,URL(string: json.gvfloorimages[1])!,URL(string: json.gvfloorimages[2])!]
                            for i in 0...2{ // getting one by one data from the array we make below
                                                if let imageData = try? Data(contentsOf: gvfloorurl[i]){

                                                    self.imageArrForgv?.append(imageData) // appending the data to our image array we made in starting of the file
                                                    //print(imageArrForLc)
                                                }
                            }
                            Malls.importer.dataFloor = imageArrForgv
                              //  print(Malls.importer.dataFloor)
                            
                           
                        }
                        if indexPath.row == 1 {
                            counter = 2
                        }
                       
                        Malls.importer.gvfloornames = json.gvfloornames
                        let images = UIImage(data: Malls.importer.dataFloor![indexPath.row]) // setting a var for our cell to contain picture for each row of cell
                        DispatchQueue.main.async {
                            navBar.title = Malls.importer.gvname
                            cell.floorButton.setBackgroundImage(images, for: .normal) // setting image from that var to each cell's button in each row
                            cell.floorName.text =  Malls.importer.gvfloornames![indexPath.row]// setting floornames label from global [var] to each cell of wach row
                            cell.shopButton.tag = indexPath.row // setting the shopbutton tag to indexpath.row which sets 3 int means 0...2
                            cell.shopButton.addTarget(self, action: #selector(shopstapped(_:)), for: .touchUpInside) // adding custom rtarget function refer to the func below
                            
                            cell.floorbuttonzoom.tag = indexPath.row // setting floorbutton's tag to indexpath.row which sets 3 int means 0...2
                            cell.floorbuttonzoom.addTarget(self, action: #selector(zoomTapped(_:)), for: .touchUpInside)// adding functionality i.e ibaaction to this button refer to line ()
                            
                          
                              dislabel.text = Malls.importer.gvdis
                              mallimage.image = UIImage(data: Malls.importer.dataimg![0])
                            cell.shopButton.isUserInteractionEnabled = true
                            cell.shopButton.isEnabled = true
                            navigation.isEnabled = true
                            navigation.isUserInteractionEnabled = true
                            
                            
                        }
                     
                     
                      
                       
                     
                        floornumbercell = Malls.importer.gvfloors
                        
                    case 1:
                        print(indexPath.row)
                        if indexPath.row == 0 && counter == 0{
                            let mmfloorurl = [URL(string: json.mmfloorimages[0])!,URL(string: json.mmfloorimages[1])!,URL(string: json.mmfloorimages[2])!]
                            for i in 0...2{ // getting one by one data from the array we make below
                                                if let imageData = try? Data(contentsOf: mmfloorurl[i]){

                                                    self.imageArrFormm?.append(imageData) // appending the data to our image array we made in starting of the file
                                                    //print(imageArrForLc)
                                                }
                            }
                            Malls.importer.dataFloor = imageArrFormm
                              //  print(Malls.importer.dataFloor)
                            
                           
                        }
                        if indexPath.row == 1 {
                            counter = 2
                        }
                       
                        Malls.importer.mmfloornames = json.mmfloornames
                        let images = UIImage(data: Malls.importer.dataFloor![indexPath.row]) // setting a var for our cell to contain picture for each row of cell
                        DispatchQueue.main.async {
                            navBar.title = Malls.importer.msname
                            cell.floorButton.setBackgroundImage(images, for: .normal) // setting image from that var to each cell's button in each row
                            cell.floorName.text =  Malls.importer.mmfloornames![indexPath.row]// setting floornames label from global [var] to each cell of wach row
                            cell.shopButton.tag = indexPath.row // setting the shopbutton tag to indexpath.row which sets 3 int means 0...2
                            cell.shopButton.addTarget(self, action: #selector(shopstapped(_:)), for: .touchUpInside) // adding custom rtarget function refer to the func below
                            
                            cell.floorbuttonzoom.tag = indexPath.row // setting floorbutton's tag to indexpath.row which sets 3 int means 0...2
                            cell.floorbuttonzoom.addTarget(self, action: #selector(zoomTapped(_:)), for: .touchUpInside)// adding functionality i.e ibaaction to this button refer to line ()
                            
                             
                              dislabel.text = Malls.importer.msdis
                              mallimage.image = UIImage(data: Malls.importer.dataimg![1])
                            cell.shopButton.isUserInteractionEnabled = true
                            cell.shopButton.isEnabled = true
                            navigation.isEnabled = true
                            navigation.isUserInteractionEnabled = true
                            
                            
                        }
                     
                     
                      
                       
                     
                        floornumbercell = Malls.importer.msfloors
                    case 2:
                         counter = 0
                       // print(indexPath.row)
                        if indexPath.row == 0 && counter == 0{
                            let apfloorurl = [URL(string: json.apfloorimages[0])!,URL(string: json.apfloorimages[1])!,URL(string: json.apfloorimages[2])!,URL(string: json.apfloorimages[3])!,URL(string: json.apfloorimages[4])!]
                            for i in 0...4{ // getting one by one data from the array we make below
                                                if let imageData = try? Data(contentsOf: apfloorurl[i]){

                                                    self.imageArrForap?.append(imageData) // appending the data to our image array we made in starting of the file
                                                    //print(imageArrForLc)
                                                }
                            }
                            Malls.importer.dataFloor = imageArrForap
                               // print(Malls.importer.dataFloor)
                            
                           
                        }
                        if indexPath.row == 1 {
                            counter = 2
                        }
                       
                        Malls.importer.apfloornames = json.apfloornames
                        let images = UIImage(data: Malls.importer.dataFloor![indexPath.row]) // setting a var for our cell to contain picture for each row of cell
                        DispatchQueue.main.async {
                            navBar.title = Malls.importer.anname
                            cell.floorButton.setBackgroundImage(images, for: .normal) // setting image from that var to each cell's button in each row
                            cell.floorName.text =  Malls.importer.apfloornames![indexPath.row]// setting floornames label from global [var] to each cell of wach row
                            cell.shopButton.tag = indexPath.row // setting the shopbutton tag to indexpath.row which sets 3 int means 0...2
                            cell.shopButton.addTarget(self, action: #selector(shopstapped(_:)), for: .touchUpInside) // adding custom rtarget function refer to the func below
                            
                            cell.floorbuttonzoom.tag = indexPath.row // setting floorbutton's tag to indexpath.row which sets 3 int means 0...2
                            cell.floorbuttonzoom.addTarget(self, action: #selector(zoomTapped(_:)), for: .touchUpInside)// adding functionality i.e ibaaction to this button refer to line ()
                            
                             
                              dislabel.text = Malls.importer.andis
                              mallimage.image = UIImage(data: Malls.importer.dataimg![2])
                            cell.shopButton.isUserInteractionEnabled = true
                            cell.shopButton.isEnabled = true
                            navigation.isEnabled = true
                            navigation.isUserInteractionEnabled = true
                            
                            
                        }
                     
                     
                      
                       
                     
                        floornumbercell = Malls.importer.anfloors
                    case 3:
                        print(indexPath.row)
                        if indexPath.row == 0 && counter == 0{
                            let oafloorurl = [URL(string: json.oafloorimages[0])!,URL(string: json.oafloorimages[1])!,URL(string: json.oafloorimages[2])!]
                            for i in 0...2{ // getting one by one data from the array we make below
                                                if let imageData = try? Data(contentsOf: oafloorurl[i]){

                                                    self.imageArrForoa?.append(imageData) // appending the data to our image array we made in starting of the file
                                                    //print(imageArrForLc)
                                                }
                            }
                            Malls.importer.dataFloor = imageArrForoa
                              //  print(Malls.importer.dataFloor)
                            
                           
                        }
                        if indexPath.row == 1 {
                            counter = 2
                        }
                       
                        Malls.importer.oafloornames = json.oafloornames
                        let images = UIImage(data: Malls.importer.dataFloor![indexPath.row]) // setting a var for our cell to contain picture for each row of cell
                        DispatchQueue.main.async {
                            navBar.title = Malls.importer.oaname
                            cell.floorButton.setBackgroundImage(images, for: .normal) // setting image from that var to each cell's button in each row
                            cell.floorName.text =  Malls.importer.oafloornames![indexPath.row]// setting floornames label from global [var] to each cell of wach row
                            cell.shopButton.tag = indexPath.row // setting the shopbutton tag to indexpath.row which sets 3 int means 0...2
                            cell.shopButton.addTarget(self, action: #selector(shopstapped(_:)), for: .touchUpInside) // adding custom rtarget function refer to the func below
                            
                            cell.floorbuttonzoom.tag = indexPath.row // setting floorbutton's tag to indexpath.row which sets 3 int means 0...2
                            cell.floorbuttonzoom.addTarget(self, action: #selector(zoomTapped(_:)), for: .touchUpInside)// adding functionality i.e ibaaction to this button refer to line ()
                            
                             
                              dislabel.text = Malls.importer.oadis
                              mallimage.image = UIImage(data: Malls.importer.dataimg![3])
                            cell.shopButton.isUserInteractionEnabled = true
                            cell.shopButton.isEnabled = true
                            navigation.isEnabled = true
                            navigation.isUserInteractionEnabled = true
                            
                            
                        }
                     
                     
                      
                       
                     
                        floornumbercell = Malls.importer.omfloors
                    default:
                        return
                    }
                    
                    
                })
                task.resume()
            
            } // networking
       
       
            
         //   let cell = detailTable.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! floorCell // custom cell
            
            
               else if ViewController.myGlobalVar.region == "Noida"{
              
                   
                    let task = URLSession.shared.dataTask(with: URL(string: url2)!, completionHandler: { [self]data, response, error in
                        guard let data = data, error == nil else{
                            print("somthin wrong")
                            return
                        }
                        var result: detailn?
                        do {
                            result = try JSONDecoder().decode(detailn.self, from: data)
                        } catch  {
                            print("thisisthe\(error)")
                        }
                        
                        guard let json = result else{
                            
                            return
                        }
                        
                        Malls.importer.dmdis = json.dmdis
                        Malls.importer.dmfloors = json.dmfloors
                        Malls.importer.lcdis = json.lcdis
                        Malls.importer.lcfloors = json.lcfloors
                        Malls.importer.ggdis = json.ggdis
                        Malls.importer.ggfloors = json.ggfloors
                        Malls.importer.gpdis = json.gpdis
                        Malls.importer.gpfloors = json.gpfloors
                      
                     
                        
                        switch Malls.importer.sender {
                        case 0:
                            DispatchQueue.main.async {
                                navBar.title = Malls.importer.dmname
                                dislabel.text = Malls.importer.dmdis
                                mallimage.image = UIImage(data: Malls.importer.dataimg![0])
                                cell.shopButton.isUserInteractionEnabled = true
                                cell.shopButton.isEnabled = true
                                navigation.isEnabled = true
                                navigation.isUserInteractionEnabled = true
                            }
                        
                            floornumbercell = Malls.importer.dmfloors
                        case 1:
                           counter = 0
                            //print(indexPath.row)
                            if indexPath.row == 0 && counter == 0{
                                let lcfloorurl = [URL(string: json.lcfloorimages[0])!,URL(string: json.lcfloorimages[1])!,URL(string: json.lcfloorimages[2])!]
                                for i in 0...2{ // getting one by one data from the array we make below
                                                    if let imageData = try? Data(contentsOf: lcfloorurl[i]){

                                                        self.imageArrForlc?.append(imageData) // appending the data to our image array we made in starting of the file
                                                        //print(imageArrForLc)
                                                    }
                                }
                                Malls.importer.dataFloor = imageArrForlc
                                print("datastored")
                                  //  print(Malls.importer.dataFloor)
                                
                               
                            }else{
                                counter = 2
                            }
                           // else{
                           // print("fucked")
                            //}
                           // if indexPath.row == 1 {
                           //     counter = 2
                           // }
                           
                            Malls.importer.lcfloornames = json.lcfloornames
                            let images = UIImage(data: Malls.importer.dataFloor![indexPath.row]) // setting a var for our cell to contain picture for each row of cell
                            DispatchQueue.main.async {
                                navBar.title = Malls.importer.lcname
                                cell.floorButton.setBackgroundImage(images, for: .normal) // setting image from that var to each cell's button in each row
                                cell.floorName.text =  Malls.importer.lcfloornames![indexPath.row]// setting floornames label from global [var] to each cell of wach row
                                cell.shopButton.tag = indexPath.row // setting the shopbutton tag to indexpath.row which sets 3 int means 0...2
                                cell.shopButton.addTarget(self, action: #selector(shopstapped(_:)), for: .touchUpInside) // adding custom rtarget function refer to the func below
                                
                                cell.floorbuttonzoom.tag = indexPath.row // setting floorbutton's tag to indexpath.row which sets 3 int means 0...2
                                 cell.floorbuttonzoom.addTarget(self, action: #selector(zoomTapped(_:)), for: .touchUpInside)// adding functionality i.e ibaaction to this button refer to line ()
                                
                                 
                                  dislabel.text = Malls.importer.lcdis
                                  mallimage.image = UIImage(data: Malls.importer.dataimg![1])
                                cell.shopButton.isUserInteractionEnabled = true
                                cell.shopButton.isEnabled = true
                                navigation.isEnabled = true
                                navigation.isUserInteractionEnabled = true
                                
                                
                            }
                         
                         
                          
                           
                         
                            floornumbercell = Malls.importer.lcfloors
                        case 2:
                            DispatchQueue.main.async {
                            navBar.title = Malls.importer.ggname
                            dislabel.text = Malls.importer.ggdis
                            mallimage.image = UIImage(data: Malls.importer.dataimg![2])
                            floornumbercell = Malls.importer.ggfloors
                                cell.shopButton.isUserInteractionEnabled = true
                                cell.shopButton.isEnabled = true
                                navigation.isEnabled = true
                                navigation.isUserInteractionEnabled = true
                            }
                        case 3:
                            DispatchQueue.main.async {
                            navBar.title = Malls.importer.gpname
                            dislabel.text = Malls.importer.gpdis
                            mallimage.image = UIImage(data: Malls.importer.dataimg![3])
                            floornumbercell = Malls.importer.gpfloors
                                cell.shopButton.isUserInteractionEnabled = true
                                cell.shopButton.isEnabled = true
                                navigation.isEnabled = true
                                navigation.isUserInteractionEnabled = true
                            }
                        default:
                            return //UITableViewCell()
                        }
                    })
                    
                    task.resume()

        }else if ViewController.myGlobalVar.region == "Delhi"{
            let task = URLSession.shared.dataTask(with: URL(string: url3)!, completionHandler: { [self]data, response, error in
                guard let data = data, error == nil else{
                    print("somthin wrong")
                    return
                }
                var result: detaild?
                do {
                    result = try JSONDecoder().decode(detaild.self, from: data)
                } catch  {
                    print("thisisthe\(error)")
                }
                
                guard let json = result else{
                    
                    return
                }
                
                Malls.importer.vsdis = json.vsdis
                Malls.importer.vsfloors = json.vsfloors
                
                Malls.importer.tcdis = json.tcdis
                Malls.importer.tcfloors = json.tcfloors
                
                Malls.importer.ccdis = json.ccdis
                Malls.importer.ccfloors = json.ccfloors
               
                Malls.importer.cmdis = json.cmdis
                Malls.importer.cmfloors = json.cmfloors
                
                Malls.importer.scfloors = json.scfloors
                Malls.importer.scdis = json.scdis
                
                Malls.importer.pmdis = json.pmdis
                Malls.importer.pmfloors = json.pmfloors
                
                Malls.importer.amdis = json.amdis
                Malls.importer.amfloors = json.amfloors
                
                Malls.importer.dsdis = json.dsdis
                Malls.importer.dsfloors = json.dsfloors
                
               
               
                switch Malls.importer.sender {
                case 0:
                    DispatchQueue.main.async {
                        navBar.title = Malls.importer.vsname
                        dislabel.text = Malls.importer.vsdis
                        mallimage.image = UIImage(data: Malls.importer.dataimg![0])
                        floornumbercell = Malls.importer.vsfloors
                        cell.shopButton.isUserInteractionEnabled = true
                        cell.shopButton.isEnabled = true
                        navigation.isEnabled = true
                        navigation.isUserInteractionEnabled = true
                    }
                    
                case 1:
                    DispatchQueue.main.async {
                    navBar.title = Malls.importer.tcname
                    dislabel.text = Malls.importer.tcdis
                    mallimage.image = UIImage(data: Malls.importer.dataimg![1])
                    floornumbercell = Malls.importer.tcfloors
                        cell.shopButton.isUserInteractionEnabled = true
                        cell.shopButton.isEnabled = true
                        navigation.isEnabled = true
                        navigation.isUserInteractionEnabled = true
                    }
                case 2:
                        DispatchQueue.main.async {
                    navBar.title = Malls.importer.ccname
                    dislabel.text = Malls.importer.ccdis
                    mallimage.image = UIImage(data: Malls.importer.dataimg![2])
                    floornumbercell = Malls.importer.ccfloors
                            cell.shopButton.isUserInteractionEnabled = true
                            cell.shopButton.isEnabled = true
                            navigation.isEnabled = true
                            navigation.isUserInteractionEnabled = true
                        }
                case 3:
                            DispatchQueue.main.async {
                    navBar.title = Malls.importer.cmname
                    dislabel.text = Malls.importer.cmdis
                    mallimage.image = UIImage(data: Malls.importer.dataimg![3])
                    floornumbercell = Malls.importer.cmfloors
                                cell.shopButton.isUserInteractionEnabled = true
                                cell.shopButton.isEnabled = true
                                navigation.isEnabled = true
                                navigation.isUserInteractionEnabled = true
                            }
                case 4:
                                DispatchQueue.main.async {
                    navBar.title = Malls.importer.dsname
                    dislabel.text = Malls.importer.dsdis
                    mallimage.image = UIImage(data: Malls.importer.dataimg![4])
                    floornumbercell = Malls.importer.dsfloors
                                    cell.shopButton.isUserInteractionEnabled = true
                                    cell.shopButton.isEnabled = true
                                    navigation.isEnabled = true
                                    navigation.isUserInteractionEnabled = true
                                }
                case 5:
                                    DispatchQueue.main.async {
                    navBar.title = Malls.importer.amname
                    dislabel.text = Malls.importer.amdis
                    mallimage.image = UIImage(data: Malls.importer.dataimg![5])
                    floornumbercell = Malls.importer.amfloors
                                        cell.shopButton.isUserInteractionEnabled = true
                                        cell.shopButton.isEnabled = true
                                        navigation.isEnabled = true
                                        navigation.isUserInteractionEnabled = true
                                    }
                case 6:
                                        DispatchQueue.main.async {
                    navBar.title = Malls.importer.pmname
                    dislabel.text = Malls.importer.pmdis
                    mallimage.image = UIImage(data: Malls.importer.dataimg![6])
                    floornumbercell = Malls.importer.pmfloors
                                            cell.shopButton.isUserInteractionEnabled = true
                                            cell.shopButton.isEnabled = true
                                            navigation.isEnabled = true
                                            navigation.isUserInteractionEnabled = true
                                        }
                case 7:
                                            DispatchQueue.main.async {
                    navBar.title = Malls.importer.scname
                    dislabel.text = Malls.importer.scdis
                    mallimage.image = UIImage(data: Malls.importer.dataimg![7])
                    floornumbercell = Malls.importer.scfloors
                                                cell.shopButton.isUserInteractionEnabled = true
                                                cell.shopButton.isEnabled = true
                                                navigation.isEnabled = true
                                                navigation.isUserInteractionEnabled = true
                                            }
                    
                default:
                    return //UITableViewCell()
                }
              
            })
            task.resume()
           
            
                
            
        }
        
       
        return cell
       
        
    }
    // function to turn string type address to a geolocation for directions in map
    func coordinates(forAddress address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            (placemarks, error) in
            guard error == nil else {
                print("Geocoding error: \(error!)")
                completion(nil)
                return
            }
            completion(placemarks?.first?.location?.coordinate)
        }
    }
    //func to open map app with the selected location , mapkit takes coordinated not as string address but as lat and lon so we convert our adress to geolocation previosly and later when we mention this function we put them in place of lat and lon rather than giving a line of address(its how mapkit knows where is the loaction)
     func openMapForPlace(lat:Double = 0, long:Double = 0, placeName:String = "") {
        let latitude: CLLocationDegrees = lat
        let longitude: CLLocationDegrees = long
        
        let regionDistance:CLLocationDistance = 100
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = placeName
        mapItem.openInMaps(launchOptions: options)
    }
        @objc func shopstapped(_ sender: UIButton){ // ok so this function doesnt need explanation beause i dont know how to but this is hardcoded to get hold of button tapped in each and every indiviual cells in the table view with the help of sender tag-- this func is a target func targeted on line (110)
        
        let button = sender.tag
        
        Malls.importer.floorsender = button // setting sender.tag to our foorsender which is  global so can be used and initalized anywhere.
        
        
    }
    //functionality i.e. ibaaction for our floorbutton when its tapped refer to line()
    @objc func zoomTapped(_ sender: UIButton){
        let zoomButton = sender.tag // this is equal to the tag of the button tapped whoch would be numbers from indexpath.row
        
        Malls.importer.zoomsender = zoomButton // setting that tag to global level
        animateScaleIn(desiredView: blurView) // animating our zoom view for blur first
        animateScaleIn(desiredView: zoomView) // animitaing the actual view now
        
    }
    
    
    ///animation functions
    
    /// Animates a view to scale in and display
    func animateScaleIn(desiredView: UIView) {
        
        let i = Malls.importer.zoomsender // checking which floor wwas clicked by the help of thsi global sender
        zoomImage.image = UIImage(data: Malls.importer.dataFloor![i!]) // tapping inot the image array and setting the image of the zoomed in view image
        
        let backgroundView = self.view!
        backgroundView.addSubview(desiredView)
        desiredView.center = backgroundView.center
        desiredView.isHidden = false
        
        desiredView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        desiredView.alpha = 0
        
        UIView.animate(withDuration: 0.2) {
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
            //            desiredView.transform = CGAffineTransform.identity
        }
    }
    
    /// Animates a view to scale out remove from the display
    func animateScaleOut(desiredView: UIView) {
        UIView.animate(withDuration: 0.2, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            desiredView.alpha = 0
        }, completion: { (success: Bool) in
            desiredView.removeFromSuperview()
        })
        
        UIView.animate(withDuration: 0.2, animations: {
            
        }, completion: { _ in
            
        })
    }
    
}

