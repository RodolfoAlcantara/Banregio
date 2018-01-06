//
//  CheckConnection.swift
//  Banregio
//
//  Created by Benjamin on 02/01/18.
//  Copyright © 2018 Rodolfo. All rights reserved.
//

import Foundation
import Alamofire

class CheckConnection: UIViewController {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
}
