import UIKit
let url = "https://dtmappapi.herokuapp.com/shopgr"

let sp = try? JSONDecoder().decode(shopgr.self, from: Data(contentsOf: URL(string: url)!))
print("SUIIII\(sp)")

    if let dict = sp as? Dictionary<String, Any>, let rates = dict["gvshopug"] as? Dictionary<String, Double> {
        for (key, value) in rates {
            print(key, value)
            self.mySymbols.append(key)
            self.myValues.append(value)
        }

    }
