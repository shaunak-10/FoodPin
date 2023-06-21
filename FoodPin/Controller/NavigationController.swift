//
//  NavigationController.swift
//  FoodPin
//
//  Created by Shaunak Mehta on 08/06/23.
//

import UIKit

class NavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
    



}
