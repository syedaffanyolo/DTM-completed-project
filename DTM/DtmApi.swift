//
//  dtmApi.swift
//  DTM
//
//  Created by Syedaffan on 10/21/20.
//

import Foundation



// our api structuring 
struct GrNoida : Codable{
    
   
    let gvname : String
//    let gvdis : String
//    let gvshops:[String]
    let gvmallimage:String
//    let gvid:Int
//    let gvfloors:Int
//    let gvshopphone:[Int]
//    let gvshopnumbers:Int
//    let gvfloorimages:[String]
    
    let mmname : String
//    let mmdis : String
//    let mmfloors:Int
   // let mmshops:[String]
    let mmmallimage:String
//    let mmid:Int
//    let mmshopphone:[Int]
//    let mmshopnumbers:Int
//    let mmfloorimages:[String]
    
    let apname : String
//    let apdis : String
//    let apshops:[String]
    let apmallimage:String
//    let apid:Int
//    let apshopphone:[Int]
//    let apshopnumbers:Int
//    let apfloorimages:[String]
//    let apfloors:Int
    
    let oaname : String
//    let oadis : String
//    let oashops:[String]
    let oamallimage:String
//    let oaid:Int
//    let oashopphone:[Int]
//    let oashopnumbers:Int
//    let oafloorimages:[String]
//    let oafloors:Int
    
}

struct Noida : Codable {
    
    let dmname : String
//    let dmdis : String
//    let dmshops:[String]
    let dmmallimage:String
//    let dmid:Int
//    let dmshopphone:[Int]
//    let dmshopnumbers:Int
//    let dmfloorimages:[String]
//    let dmfloors:Int
    
    let lcname : String
//    let lcdis : String
//    let lcshopslg:[String]
//    let lcshopg:[String]
//    let lcshop1:[String]
//    let lcshop2:[String]
//    let lcshop3:[String]
//    let lcshop4:[String]
    let lcmallimage:String
//    let lcid:Int
//    let lcshopphonelg:[Int]
//    let lcshopphoneg:[Int]
//    let lcshopphone1:[Int]
//    let lcshopphone2:[Int]
//    let lcshopphone3:[Int]
//    let lcshopphone4:[Int]
//    let lcshopnumbers:Int
//    let lcfloorimages:[String]
//    let lcfloornames:[String]
//    let lcfloors:Int
    
    let ggname : String
//    let ggdis : String
//    let ggshops:[String]
    let ggmallimage:String
//    let ggid:Int
//    let ggshopphone:[Int]
//    let ggshopnumbers:Int
//    let ggfloorimages:[String]
//    let ggfloors:Int
    
    let gpname : String
//    let gpdis : String
//    let gpshops:[String]
    let gpmallimage:String
//    let gpid:Int
//    let gpshopphone:[Int]
//    let gpshopnumbers:Int
//    let gpfloorimages:[String]
//    let gpfloors:Int
//

}


struct Delhi : Codable{
    let vsname : String
//    let vsdis : String
//    let vsshops:[String]
    let vsmallimage:String
//    let vsid:Int
//    let vsshopphone:[Int]
//    let vsshopnumbers:Int
//    let vsfloorimages:[String]
//    let vsfloors:Int
    
    let tcname : String
//    let tcdis : String
//    let tcshops:[String]
    let tcmallimage:String
//    let tcid:Int
//    let tcshopphone:[Int]
//    let tcshopnumbers:Int
//    let tcfloorimages:[String]
//    let tcfloors:Int
    
    let ccname : String
//    let ccdis : String
//    let ccshops:[String]
    let ccmallimage:String
//    let ccid:Int
//    let ccshopphone:[Int]
//    let ccshopnumbers:Int
//    let ccfloorimages:[String]
//    let ccfloors:Int
    
    let cmname : String
//    let cmdis : String
//    let cmshops:[String]
    let cmmallimage:String
//    let cmid:Int
//    let cmshopphone:[Int]
//    let cmshopnumbers:Int
//    let cmfloorimages:[String]
//    let cmfloors:Int
    
    let dsname : String
//    let dsdis : String
//    let dsshops:[String]
    let dsmallimage:String
//    let dsid:Int
//    let dsshopphone:[Int]
//    let dsshopnumbers:Int
//    let dsfloorimages:[String]
//    let dsfloors:Int
    
    let amname : String
//    let amdis : String
//    let amshops:[String]
    let ammallimage:String
//    let amid:Int
//    let amshopphone:[Int]
//    let amshopnumbers:Int
//    let amfloorimages:[String]
//    let amfloors:Int
    
    let pmname : String
//    let pmdis : String
//    let pmshops:[String]
    let pmmallimage:String
//    let pmid:Int
//    let pmshopphone:[Int]
//    let pmshopnumbers:Int
//    let pmfloorimages:[String]
//    let pmfloors:Int
    
    let scname : String
//    let scdis : String
//    let scshops:[String]
    let scmallimage:String
//    let scid:Int
//    let scshopphone:[Int]
//    let scshopnumbers:Int
//    let scfloorimages:[String]
//    let scfloors:Int
}
struct detailgr : Codable{
        let gvfloornames : [String]
        let gvdis : String
       // let gvshopslg:[String]
    let gvshops:[String]
   
    
        let gvid:Int
        let gvfloors:Int
        let gvshopphone:[Int]
        let gvshopnumbers:Int
        let gvfloorimages:[String]
    
}
struct detailgr1 : Codable{
        let mmfloornames : [String]
        let mmdis : String
        let mmfloors:Int
        let mmfloorimages : [String]
        let mmshops:[String]
       let mmid:Int
        let mmshopphone:[Int]
        let mmshopnumbers:Int
       // let mmfloorimages:[String]
    
}
struct detailgr2 : Codable{
    
    let apfloornames : [String]
        let apdis : String
    let apshopsaf:[
        String:String
    ]
    let apshopsg:[
        String:String
    ]
    let apshops2:[
        String:String
    ]
        let apid:Int
        let apshopphone:[Int]
        let apshopnumbers:Int
        let apfloorimages:[String]
        let apfloors:Int
       
}
struct detailgr3 : Codable{
    let oadis : String
    let oashops:[String]
    let oaid:Int
    let oashopphone:[Int]
    let oashopnumbers:Int
    let oafloornames : [String]
    let oafloorimages:[String]
    let oafloors:Int
}
 
struct detailn : Codable{
        let dmdis : String
      
       // let dmid:Int
    // let dmshops:[String]
       // let dmshopphone:[Int]
        //let dmshopnumbers:Int
        let dmfloorimages:[String]
        let dmfloors:Int
        let lcdis : String
       // let lcshopslg:[String]
       // let lcshopg:[String]
        //let lcshop1:[String]
        //let lcshop2:[String]
       // let lcshop3:[String]
      //  let lcshop4:[String]
       // let lcid:Int
      //  let lcshopphonelg:[Int]
      //  let lcshopphoneg:[Int]
      //  let lcshopphone1:[Int]
     //   let lcshopphone2:[Int]
      //  let lcshopphone3:[Int]
       // let lcshopphone4:[Int]
       // let lcshopnumbers:Int
        let lcfloorimages:[String]
        let lcfloornames:[String]
        let lcfloors:Int
        let ggdis : String
      //  let ggshops:[String]
      //  let ggid:Int
       // let ggshopphone:[Int]//
       // let ggshopnumbers:Int
        let ggfloorimages:[String]
        let ggfloors:Int
        let gpdis : String
       // let gpshops:[String]
       // let gpid:Int
        //let gpshopphone:[Int]
        //let gpshopnumbers:Int
        let gpfloorimages:[String]
        let gpfloors:Int
}
struct detaild : Codable{
  
    let vsdis : String
//    let vsshops:[String]

//    let vsid:Int
//    let vsshopphone:[Int]
//    let vsshopnumbers:Int
    let vsfloorimages:[String]
    let vsfloors:Int
    

    let tcdis : String
//    let tcshops:[String]

//    let tcid:Int
//    let tcshopphone:[Int]
//    let tcshopnumbers:Int
    let tcfloorimages:[String]
    let tcfloors:Int
    

    let ccdis : String
//    let ccshops:[String]

//    let ccid:Int
//    let ccshopphone:[Int]
//    let ccshopnumbers:Int
    let ccfloorimages:[String]
    let ccfloors:Int
    

   let cmdis : String
//    let cmshops:[String]

//    let cmid:Int
//    let cmshopphone:[Int]
//    let cmshopnumbers:Int
    let cmfloorimages:[String]
   let cmfloors:Int
    

    let dsdis : String
//    let dsshops:[String]

//    let dsid:Int
//    let dsshopphone:[Int]
//    let dsshopnumbers:Int
    let dsfloorimages:[String]
    let dsfloors:Int
    
   // let amname : String
    let amdis : String
//    let amshops:[String]
   
//    let amid:Int
//    let amshopphone:[Int]
//    let amshopnumbers:Int
    let amfloorimages:[String]
    let amfloors:Int
    
  
    let pmdis : String
//    let pmshops:[String]
   
//    let pmid:Int
//    let pmshopphone:[Int]
//    let pmshopnumbers:Int
    let pmfloorimages:[String]
    let pmfloors:Int
    
    
    let scdis : String
//    let scshops:[String]

//    let scid:Int
//    let scshopphone:[Int]
//    let scshopnumbers:Int
    let scfloorimages:[String]
    let scfloors:Int
}
struct shopn : Codable{
     let dmshops:[String]
        let dmshopphone:[Int]
        let dmshopnumbers:Int
    
     let lcshopslg:[String]
     let lcshopg:[String]
     let lcshop1:[String]
     let lcshop2:[String]
     let lcshop3:[String]
     let lcshop4:[String]
    
     let lcshopphonelg:[Int]
     let lcshopphoneg:[Int]
     let lcshopphone1:[Int]
     let lcshopphone2:[Int]
     let lcshopphone3:[Int]
     let lcshopphone4:[Int]
     let lcshopnumbers:Int
    
      let ggshops:[String]
    
      let ggshopphone:[Int]//
      let ggshopnumbers:Int
    
     let gpshops:[String]
    
     let gpshopphone:[Int]
     let gpshopnumbers:Int
}


