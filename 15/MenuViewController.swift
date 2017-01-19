//
//  MenuViewController.swift
//  spaccaquindici
//
//  Created by  Luca Paterlini on 07/09/16.
//  Copyright © 2016 luca paterlini. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController as UIViewController
            if let navCon = destination as? UINavigationController {
                destination = navCon.visibleViewController!
            }
            if let gvc = destination as? GameplayViewController {
                if let identifier = segue.identifier {
                    switch identifier {
                        case "upon_a_time": gvc.ImageBaseName = "upon_a_time";gvc.loops = 100
                        case "cielo": gvc.ImageBaseName = "cielo";gvc.loops = 50
                        case "cascate": gvc.ImageBaseName = "cascate"; gvc.loops = 10

                    default: break
                    }
                }
            }
        }
}
