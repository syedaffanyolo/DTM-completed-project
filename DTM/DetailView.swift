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
    @IBOutlet weak var backtomalls: UIBarButtonItem!
    //api link
    let urlgr = "https://dtmappapi.herokuapp.com/detailgr"
    let urlgr1 = "https://dtmappapi.herokuapp.com/detailgr1"
    let urlgr2 = "https://dtmappapi.herokuapp.com/detailgr2"
    let urlgr3 = "https://dtmappapi.herokuapp.com/detailgr3"
    let url2 = "https://dtmappapi.herokuapp.com/detailn"
    let url3 = "https://dtmappapi.herokuapp.com/detaild"
    var counter  = 0
    var imageArrForgv : [Data]? = []
    var imageArrFormm : [Data]? = []
    var imageArrForoa : [Data]? = []
    var imageArrForap : [Data]? = []
    var imageArrForlc : [Data]? = []
    var jsong : detailgr?
    var dis : String = ""
    var images : UIImage?
    var datastgr0 : Bool = false
    var datastgr1 : Bool = false
    var datastgr2 : Bool = false
    var datastgr3 : Bool = false
    var datastn : Bool = false
    var datastd : Bool = false
    var killTask : Bool = false
    var currenTask : URLSessionDataTask?
    var backpressed : Bool = false
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var detailTable: UITableView!
    @IBOutlet weak var navigation: UIButton!
    @IBOutlet weak var dislabel: UILabel!
    @IBOutlet weak var mallimage: UIImageView!
    @IBOutlet weak var zoomImage: UIImageView!
    @IBOutlet var zoomView: UIView!
    @IBOutlet var blurView: UIVisualEffectView!
    //@IBOutlet weak var backing: UIBarButtonItem!
    
    
    
    
    
    var floornumbercell : Int? = nil // cell amount variable to be used later
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setting delgate and data source for our table view
        detailTable.delegate = self
        detailTable.dataSource = self
        //rendering all the detail for the selcted mall while the detail seque starts at first
        // backing.target = self
        // backing.action = #selector(backed(_:))
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
    
    
    
    
    // big boss 2 lies here
    
    //table view stubs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ViewController.myGlobalVar.region == "Greater Noida"{
            switch Malls.importer.sender {
            case 0:
                return 5
            case 1:
                return 5
            case 2:
                return 5
            case 3:
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
    //    @objc func backed(_ sender: UIBarButtonItem){
    //
    //
    //        navigationController?.popViewController(animated: true)
    //
    //        dismiss(animated: true, completion: nil)
    //    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        navBar.title = ""
        let cell = detailTable.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! floorCell // custom cell
        //
        //            cell.floorButton.isEnabled = false
        //            cell.floorButton.isUserInteractionEnabled = false
        
        
        
        if ViewController.myGlobalVar.region == "Greater Noida" {
            
            
            switch Malls.importer.sender{
            case 0:
                if datastgr0 == false{
                    let pr = try? JSONDecoder().decode(detailgr.self, from: Data(contentsOf: URL(string: urlgr)!))
                    Malls.importer.gvdis = pr?.gvdis
                    Malls.importer.gvfloors = pr?.gvfloors
                    Malls.importer.gvfloornames = pr?.gvfloornames
                    print("grand\(pr?.gvfloorimages)")
                    let gvfloorurl = [pr!.gvfloorimages[0], pr!.gvfloorimages[1],pr!.gvfloorimages[2],pr!.gvfloorimages[3],pr!.gvfloorimages[4]]
                    for i in 0...4{ // getting one by one data from the array we make below
                        if let imageData = try? Data(contentsOf: URL(string: gvfloorurl[i])!){
                            
                            self.imageArrForgv?.append(imageData) // appending the data to our image array we made in starting of the file
                            //print(imageArrForLc)
                        }
                    }
                    Malls.importer.dataFloor = imageArrForgv
                    

                    datastgr0 = true
                }
                //print("here\(Malls.importer.dataFloor)")
//                if Malls.importer.killTask == false{
//                    //let image =
//                   // Malls.importer.gr1images = [UIImage(data: Malls.importer.dataFloor)]
//                    //print("heretoo\(Malls.importer.dataFloor)")
//                    //Malls.importer.gr1images![indexPath.row] =
//                   //print( "here\(UIImage(data: Malls.importer.dataFloor![indexPath.row])!)")
//                   // print("doingmyjob\(indexPath.row)")
//
//                }
//                if indexPath.row == 2{
//                    Malls.importer.killTask = true
//                   // print("doingmyjob\(Malls.importer.gr1images)")
//                }
                
                
                DispatchQueue.main.async {
                    self.navBar.title = Malls.importer.gvname
                    cell.floorButton.setBackgroundImage(UIImage(data:Malls.importer.dataFloor![indexPath.row]), for: .normal) // setting image from that var to each cell's button in each row
                    cell.floorName.text =  Malls.importer.gvfloornames![indexPath.row]// setting floornames label from global [var] to each cell of wach row
                    cell.shopButton.tag = indexPath.row // setting the shopbutton tag to indexpath.row which sets 3 int means 0...2
                    cell.shopButton.addTarget(self, action: #selector(self.shopstapped(_:)), for: .touchUpInside) // adding custom rtarget function refer to the func below
                    
                    cell.floorbuttonzoom.tag = indexPath.row // setting floorbutton's tag to indexpath.row which sets 3 int means 0...2
                    cell.floorbuttonzoom.addTarget(self, action: #selector(self.zoomTapped(_:)), for: .touchUpInside)// adding functionality i.e ibaaction to this button refer to line ()
                    
                    
                    self.dislabel.text = Malls.importer.gvdis
                    self.mallimage.image = UIImage(data: Malls.importer.dataimg![0])
                    cell.shopButton.isUserInteractionEnabled = true
                    cell.shopButton.isEnabled = true
                    self.navigation.isEnabled = true
                    self.navigation.isUserInteractionEnabled = true
                    
                    
                }
                floornumbercell = Malls.importer.gvfloors
                
            case 1:
                if datastgr1 == false{
                    let pr = try? JSONDecoder().decode(detailgr1.self, from: Data(contentsOf: URL(string: urlgr1)!))
                    Malls.importer.mmdis = pr?.mmdis
                    Malls.importer.mmfloors = pr?.mmfloors
                    Malls.importer.mmshopphone = pr?.mmshopphone
                    Malls.importer.mmshops = pr?.mmshops
                    Malls.importer.mmfloornames = pr?.mmfloornames
                    Malls.importer.mmshopnumbers = pr?.mmshopnumbers
                    let mmfloorurl = [pr?.mmfloorimages[0], pr?.mmfloorimages[1], pr?.mmfloorimages[2]]
                    for i in 0...2{ // getting one by one data from the array we make below
                        if let imageData = try? Data(contentsOf: URL(string:mmfloorurl[i]!)!){
                            
                            self.imageArrFormm?.append(imageData) // appending the data to our image array we made in starting of the file
                            //print(imageArrForLc)
                            
                        }
                    }
                    Malls.importer.dataFloor = imageArrFormm
                    print("MSx\( Malls.importer.dataFloor)")

                    datastgr1 = true
                }
//                if Malls.importer.killTask == false{
//                    //let image =
//                    Malls.importer.gr1images![indexPath.row] =  UIImage(data: Malls.importer.dataFloor![indexPath.row])!
//                   // print("doingmyjob\(indexPath.row)")
//                }
//                if indexPath.row == 2{
//                    Malls.importer.killTask = true
//                    print("doingmyjob\(Malls.importer.gr1images)")
//                }
                
                DispatchQueue.main.async {
                    self.navBar.title = Malls.importer.mmname
                    cell.floorButton.setBackgroundImage(UIImage(data:Malls.importer.dataFloor![indexPath.row]), for: .normal) // setting image from that var to each cell's button in each row
                    cell.floorName.text =  Malls.importer.mmfloornames![indexPath.row]// setting floornames label from global [var] to each cell of wach row
                    cell.shopButton.tag = indexPath.row // setting the shopbutton tag to indexpath.row which sets 3 int means 0...2
                    cell.shopButton.addTarget(self, action: #selector(self.shopstapped(_:)), for: .touchUpInside) // adding custom rtarget function refer to the func below
                    
                    cell.floorbuttonzoom.tag = indexPath.row // setting floorbutton's tag to indexpath.row which sets 3 int means 0...2
                    cell.floorbuttonzoom.addTarget(self, action: #selector(self.zoomTapped(_:)), for: .touchUpInside)// adding functionality i.e ibaaction to this button refer to line ()
                    
                    
                    self.dislabel.text = Malls.importer.mmdis
                    self.mallimage.image = UIImage(data: Malls.importer.dataimg![1])
                    cell.shopButton.isUserInteractionEnabled = true
                    cell.shopButton.isEnabled = true
                    self.navigation.isEnabled = true
                    self.navigation.isUserInteractionEnabled = true
                    
                    
                }
                
                floornumbercell = Malls.importer.mmfloors
            case 2:
                if datastgr1 == false{
                    let pr = try? JSONDecoder().decode(detailgr2.self, from: Data(contentsOf: URL(string: urlgr2)!))
                    Malls.importer.apdis = pr?.apdis
                    Malls.importer.apfloors = pr?.apfloors
                    Malls.importer.apshopphone = pr?.apshopphone
                    Malls.importer.apshopsaf = pr?.apshopsaf
                    Malls.importer.apfloornames = pr?.apfloornames
                    Malls.importer.apshopnumbers = pr?.apshopnumbers
                    print("Ansal\(pr?.apfloorimages)")
                    let apfloorurl = [pr?.apfloorimages[0], pr?.apfloorimages[1], pr?.apfloorimages[2], pr?.apfloorimages[3], pr?.apfloorimages[4]]
                    for i in 0...4{ // getting one by one data from the array we make below
                        if let imageData = try? Data(contentsOf: URL(string:apfloorurl[i]!)!){
                            
                            self.imageArrFormm?.append(imageData) // appending the data to our image array we made in starting of the file
                            //print(imageArrForLc)
                            
                        }
                    }
                    Malls.importer.dataFloor = imageArrFormm
                    print("ansal\( Malls.importer.dataFloor)")
                    datastgr1 = true
                }
//                if Malls.importer.killTask == false{
//                    //let image =
//                    Malls.importer.gr1images![indexPath.row] =  UIImage(data: Malls.importer.dataFloor![indexPath.row])!
//                   // print("doingmyjob\(indexPath.row)")
//                }
//                if indexPath.row == 4{
//                    Malls.importer.killTask = true
//                    print("doingmyjob\(Malls.importer.gr1images)")
//                }
                
                DispatchQueue.main.async {
                    self.navBar.title = Malls.importer.apname
                    cell.floorButton.setBackgroundImage(UIImage(data:Malls.importer.dataFloor![indexPath.row]), for: .normal) // setting image from that var to each cell's button in each row
                    cell.floorName.text =  Malls.importer.apfloornames![indexPath.row]// setting floornames label from global [var] to each cell of wach row
                    cell.shopButton.tag = indexPath.row // setting the shopbutton tag to indexpath.row which sets 3 int means 0...2
                    cell.shopButton.addTarget(self, action: #selector(self.shopstapped(_:)), for: .touchUpInside) // adding custom rtarget function refer to the func below
                    
                    cell.floorbuttonzoom.tag = indexPath.row // setting floorbutton's tag to indexpath.row which sets 3 int means 0...2
                    cell.floorbuttonzoom.addTarget(self, action: #selector(self.zoomTapped(_:)), for: .touchUpInside)// adding functionality i.e ibaaction to this button refer to line ()
                    
                    
                    self.dislabel.text = Malls.importer.apdis
                    self.mallimage.image = UIImage(data: Malls.importer.dataimg![1])
                    cell.shopButton.isUserInteractionEnabled = true
                    cell.shopButton.isEnabled = true
                    self.navigation.isEnabled = true
                    self.navigation.isUserInteractionEnabled = true
                    
                    
                }
                
                floornumbercell = Malls.importer.apfloors
                
            case 3:
                if datastgr1 == false{
                    let pr = try? JSONDecoder().decode(detailgr3.self, from: Data(contentsOf: URL(string: urlgr3)!))
                    Malls.importer.oadis = pr?.oadis
                    Malls.importer.oafloors = pr?.oafloors
                    Malls.importer.oashopphone = pr?.oashopphone
                    Malls.importer.oashops = pr?.oashops
                    Malls.importer.oafloornames = pr?.oafloornames
                    Malls.importer.oashopnumbers = pr?.oashopnumbers
                    print("omaxe arcade\(pr?.oafloorimages)")
                    let oafloorurl = [pr?.oafloorimages[0], pr?.oafloorimages[1], pr?.oafloorimages[2]]
                    for i in 0...2{ // getting one by one data from the array we make below
                        if let imageData = try? Data(contentsOf: URL(string:oafloorurl[i]!)!){
                            
                            self.imageArrFormm?.append(imageData) // appending the data to our image array we made in starting of the file
                            //print(imageArrForLc)
                            
                        }
                    }
                    Malls.importer.dataFloor = imageArrFormm
                    
                    datastgr1 = true
                }
//                if Malls.importer.killTask == false{
//                    //let image =
//                    Malls.importer.gr1images![indexPath.row] =  UIImage(data: Malls.importer.dataFloor![indexPath.row])!
//                   // print("doingmyjob\(indexPath.row)")
//                }
//                if indexPath.row == 2{
//                    Malls.importer.killTask = true
//                    print("doingmyjob\(Malls.importer.gr1images)")
//                }
                
                DispatchQueue.main.async {
                    self.navBar.title = Malls.importer.oaname
                    cell.floorButton.setBackgroundImage(UIImage(data:Malls.importer.dataFloor![indexPath.row]), for: .normal) // setting image from that var to each cell's button in each row
                    cell.floorName.text =  Malls.importer.oafloornames![indexPath.row]// setting floornames label from global [var] to each cell of wach row
                    cell.shopButton.tag = indexPath.row // setting the shopbutton tag to indexpath.row which sets 3 int means 0...2
                    cell.shopButton.addTarget(self, action: #selector(self.shopstapped(_:)), for: .touchUpInside) // adding custom rtarget function refer to the func below
                    
                    cell.floorbuttonzoom.tag = indexPath.row // setting floorbutton's tag to indexpath.row which sets 3 int means 0...2
                    cell.floorbuttonzoom.addTarget(self, action: #selector(self.zoomTapped(_:)), for: .touchUpInside)// adding functionality i.e ibaaction to this button refer to line ()
                    
                    
                    self.dislabel.text = Malls.importer.oadis
                    self.mallimage.image = UIImage(data: Malls.importer.dataimg![1]) //FIXME
                    cell.shopButton.isUserInteractionEnabled = true
                    cell.shopButton.isEnabled = true
                    self.navigation.isEnabled = true
                    self.navigation.isUserInteractionEnabled = true
                    
                    
                }
                
                floornumbercell = Malls.importer.oafloors
                
            default:
                return cell
            }
            
            
            
            
            
            
        } // networking
        
        
        
        //   let cell = detailTable.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! floorCell // custom cell
        
        
        else if ViewController.myGlobalVar.region == "Noida"{
            
            
        }
        else if ViewController.myGlobalVar.region == "Delhi"{
            
        }
        
        
        return cell
        
        
    }
    
    
    //taskkiller
    @IBAction func backtomalls(_ sender: Any) {
        
        //Task.cancel(task)
        performSegue(withIdentifier: "backtomalls", sender: self)
        backpressed = true
        Malls.importer.killTask = false
        Malls.importer.gr1images = nil
        print("delted here")
        currenTask?.cancel()
        
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
        performSegue(withIdentifier: "shops", sender: self)
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


