//
//  ViewController.swift
//  DTM
//
//  Created by Syedaffan on 8/24/20.
//
//if ViewController.myGlobalVar.region == "Greater Noida"{
//    self.navBar.title = "Greater Noida"
//    for i in 0...3{
//    let imgurl = URL(string: importer.mallsingrimg![i])!
//    if let data = try? Data(contentsOf: imgurl ){
//
//        imageArr?.append(data)
//
//    }
//    }
//    importer.dataimg = imageArr
//    }else if ViewController.myGlobalVar.region == "Noida"{
//
//    }else if ViewController.myGlobalVar.region == "Delhi"{
//        self.navBar.title = "Delhi"
//        for i in 0...7{
//        let imgurl = URL(string: importer.mallsindimg![i])!
//        if let data = try? Data(contentsOf: imgurl ){
//
//            imageArr?.append(data)
//
//        }
//        }
//        importer.dataimg = imageArr
//    }
import UIKit

// assiging the delegate for our uipicker view
class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let urlforgr = "https://dtmappapi.herokuapp.com/grapi"
    let urlforn = "https://dtmappapi.herokuapp.com/napi"
    let urlford = "https://dtmappapi.herokuapp.com/dapi"
    var imageArr : [Data]? = []
    
    
    // all outlets
    @IBOutlet weak var locPick: UIPickerView!
    @IBOutlet weak var nextb: UIButton!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    // making a variible of array to contain the regions oin out loc picker
    var locationPicker:[String] = [String]();
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // rendering all the stuff for our location picker view
        render()
        loderfu()
        
        
      
        // setting data source anf delgate
        self.locPick.delegate = self
        self.locPick.dataSource = self
        //picker view init
        locationPicker = ["Greater Noida","Noida","Delhi"]
        
        
    
        
        
    }
    
    @IBAction func next(_ sender: Any) {
        DispatchQueue.main.async { [self] in
            lodervu()
        }
        
        // gets in a variable what region is being selceted currently by the user
        let selectedReg = locationPicker[locPick.selectedRow(inComponent: 0)]
        
        
        // having a no shadow when clicked for our button
        nextb.layer.shadowOpacity = 0.0;
        // setting the selected region by the user to the global variable region
        myGlobalVar.region = selectedReg
        
        
        if selectedReg == "Greater Noida"{
        let task = URLSession.shared.dataTask(with: URL(string: urlforgr)!, completionHandler: { [self]data, response, error in
            guard let data = data, error == nil else{
                print("somthin wrong")
                return
            }
            var result: GrNoida?
            do {
                result = try JSONDecoder().decode(GrNoida.self, from: data)
            } catch  {
                print(error)
            }
            
            guard let json = result else{
                
                return
            }
            Malls.importer.mallsingr = [json.gvname,json.mmname,json.apname,json.oaname]
            
            
            Malls.importer.mallsingrimg =  [json.gvmallimage,json.mmmallimage,json.apmallimage,json.oamallimage]
            //print(json)
            Malls.importer.gvname = json.gvname
          //  Malls.importer.gvdis = json.gvdis
          //  Malls.importer.gvfloors = json.gvfloors
                                      
            Malls.importer.msname = json.mmname
          //  Malls.importer.msdis = json.mmdis
          //  Malls.importer.msfloors = json.mmfloors
                                      
            Malls.importer.anname = json.apname
          //  Malls.importer.andis = json.apdis
           // Malls.importer.anfloors = json.apfloors
                                      
            Malls.importer.oaname = json.oaname
          //  Malls.importer.oadis = json.oadis
           // Malls.importer.omfloors = json.oafloors
            
            //self.navBar.title = "Greater Noida"
               for i in 0...3{
                let imgurl = URL(string: Malls.importer.mallsingrimg![i])!
                if let data = try? Data(contentsOf: imgurl ){
           
                    imageArr?.append(data)
           
               }
               }
            Malls.importer.dataimg = imageArr
                //print(imageArr)
            DispatchQueue.main.async {
                loderfu()
                //print(Malls.importer.dataimg)
                performSegue(withIdentifier: "Malls", sender: self)
                
            }
           
        })
        task.resume()

        // performing a segue whrn the next button is clicked
       
        
        
        
        }else if selectedReg == "Noida"{
            let task = URLSession.shared.dataTask(with: URL(string: urlforn)!, completionHandler: { [self]data, response, error in
                guard let data = data, error == nil else{
                    print("somthin wrong")
                    return
                }
                var result: Noida?
                do {
                    result = try JSONDecoder().decode(Noida.self, from: data)
                } catch  {
                    print(error)
                }
                
                guard let json = result else{
                    
                    return
                }
               Malls.importer.mallsinn = [json.dmname,json.lcname,json.ggname,json.gpname]
                
                
                Malls.importer.mallsinnimg =  [json.dmmallimage,json.lcmallimage,json.ggmallimage,json.gpmallimage]
               // let lcfloorurl = [URL(string: json.lcfloorimages[0])!,URL(string: json.lcfloorimages[1])!,URL(string: json.lcfloorimages[2])!]
//                for i in 0...2{ // getting one by one data from the array we make below
//                                    if let imageData = try? Data(contentsOf: lcfloorurl[i]){
//                                        
//                                        self.imageArrForLc?.append(imageData) // appending the data to our image array we made in starting of the file
//                                        
//                                    }
//                }
               // Malls.importer.dataFloorLc = imageArrForLc
                Malls.importer.dmname = json.dmname
               // Malls.importer.dmdis = json.dmdis
               // Malls.importer.dmfloors = json.dmfloors
                Malls.importer.lcname = json.lcname
               // Malls.importer.lcdis = json.lcdis
               // Malls.importer.lcfloors = json.lcfloors
             
                                   
                Malls.importer.ggname = json.ggname
               // Malls.importer.ggdis = json.ggdis
              //  Malls.importer.ggfloors = json.ggfloors
                Malls.importer.gpname = json.gpname
              //  Malls.importer.gpdis = json.gpdis
              //  Malls.importer.gpfloors = json.gpfloors
                //print(json)
                for i in 0...3{
                 let imgurl = URL(string: Malls.importer.mallsinnimg![i])!
                 if let data = try? Data(contentsOf: imgurl ){
            
                     imageArr?.append(data)
            
                }
                }
             Malls.importer.dataimg = imageArr
                DispatchQueue.main.async {
                   
                    performSegue(withIdentifier: "Malls", sender: self)
                    loderfu()
                }
               
            })
            task.resume()
        }else if selectedReg == "Delhi"{
            let task = URLSession.shared.dataTask(with: URL(string: urlford)!, completionHandler: { [self]data, response, error in
                guard let data = data, error == nil else{
                    print("somthin wrong")
                    return
                }
                var result: Delhi?
                do {
                    result = try JSONDecoder().decode(Delhi.self, from: data)
                } catch  {
                    print(error)
                }
                
                guard let json = result else{
                    
                    return
                }
                Malls.importer.mallsind = [json.vsname,json.tcname,json.ccname,json.cmname,json.amname,json.dsname,json.scname,json.pmname]


                Malls.importer.mallsindimg =  [json.vsmallimage,json.tcmallimage,json.ccmallimage,json.cmmallimage,json.ammallimage,json.dsmallimage,json.scmallimage,json.pmmallimage]
                //print(json)
                Malls.importer.vsname = json.vsname
            
                Malls.importer.tcname = json.tcname
              //  Malls.importer.tcdis = json.tcdis
              //  Malls.importer.tcfloors = json.tcfloors
                                        
                Malls.importer.ccname = json.ccname
              //  Malls.importer.ccdis = json.ccdis
              //  Malls.importer.ccfloors = json.ccfloors
                                        
                Malls.importer.cmname = json.cmname
              //  Malls.importer.cmdis = json.cmdis
               // Malls.importer.cmfloors = json.cmfloors
              
                Malls.importer.dsname = json.dsname
                //Malls.importer.dsdis = json.dsdis
               // Malls.importer.dsfloors = json.dsfloors
                                        
                Malls.importer.amname = json.amname
               // Malls.importer.amdis = json.amdis
               // Malls.importer.amfloors = json.amfloors
                                        
                Malls.importer.pmname = json.pmname
               // Malls.importer.pmdis = json.pmdis
               // Malls.importer.pmfloors = json.pmfloors
                                        
                Malls.importer.scname = json.scname
              //  Malls.importer.scdis = json.scdis
              //  Malls.importer.scfloors = json.scfloors
                for i in 0...7{
                 let imgurl = URL(string: Malls.importer.mallsindimg![i])!
                 if let data = try? Data(contentsOf: imgurl ){
            
                     imageArr?.append(data)
            
                }
                }
             Malls.importer.dataimg = imageArr
                DispatchQueue.main.async {
                    loderfu()
                    performSegue(withIdentifier: "Malls", sender: self)
                    
                }
                
            })
            task.resume()
        }
        
        
        
        
    }
    
    //functions
    // setting number of collumbs
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // setting the number og rows to the value of stuff in our array
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locationPicker.count
    }
    // setting each row to the stuff in our array by one by one
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locationPicker[row]
    }
    
    func render(){
        

        
        // all elemnet styles
        
        nextb.layer.cornerRadius = 10
        locPick.layer.cornerRadius = 20
        nextb.layer.shadowOffset = CGSize(width: 2.0, height: 2.0);
        nextb.layer.shadowRadius = 2.0;
        nextb.layer.shadowOpacity = 1.0;
        nextb.layer.masksToBounds = false;
        locPick.layer.shadowOffset = CGSize(width: 2.0, height: 2.0);
        locPick.layer.shadowRadius = 2.0;
        locPick.layer.shadowOpacity = 1.0;
        locPick.layer.masksToBounds = false;
    }
    
    
    
    
    // global variable for region
    
    struct myGlobalVar {
        static var region = String()
       
    }
    func loderfu(){
        self.loader.stopAnimating()
        self.loader.isHidden = true
        self.loader.isUserInteractionEnabled = false
        self.loaderView.isExclusiveTouch = false
        self.loaderView.isUserInteractionEnabled = false
        
    }
    func lodervu(){
        self.loader.startAnimating()
        self.loader.isHidden = false
        self.loader.isUserInteractionEnabled = true
        self.loaderView.isExclusiveTouch = true
        self.loaderView.isUserInteractionEnabled = true
    }
            
        }
  
    
    
    
    
    
    
    
    



