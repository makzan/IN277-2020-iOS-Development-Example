//
//  GlobalSession.swift
//  WebViewDemo
//
//  Created by Makzan on 6/1/2021.
//  Copyright © 2021 in200-06-2018-cm. All rights reserved.
//

import UIKit
import WebKit

class GlobalSession: NSObject {
    static let shared = GlobalSession()
    
    let processPool = WKProcessPool()
}
