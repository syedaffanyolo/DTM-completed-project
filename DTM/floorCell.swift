//
//  floorCell.swift
//  DTM
//
//  Created by Syedaffan on 11/1/20.
//

import UIKit
import Foundation

class floorCell: UITableViewCell {
    //outlets
    @IBOutlet weak var floorButton: UIButton! // button for the floor plan zoom in
    @IBOutlet weak var floorName: UILabel! // floor name
    @IBOutlet weak var shopButton: UIButton! // shops in the floor button
    @IBOutlet weak var floorbuttonzoom: UIButton!
    
    
    
    //mapfloorbutton
    @IBAction func floorButtonClicked(_ sender: Any) {
        // here add the zoom in floor plan functionality
    }
    // shopsnextbutton
    @IBAction func shopsButton(_ sender: Any) { // we didnt use this yet but maybe will in future 
        //  Malls.importer.floorsender = shopButton.sender.tag
        
        //print(Malls.importer.floorsender)
        // print("hereyougo\(Malls.importer.floorsender)")
    }
}
