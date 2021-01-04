//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Andrey Antipov on 22.12.2020.
//  Copyright © 2020 Andrey Antipov. All rights reserved.
//

import Foundation
protocol LoginViewControllerDelegate: AnyObject {
    /// Function of login checking
    func checkLogin(_ login: String) -> Bool
    /// Function of password checking
    func checkPassword(_ password: String) -> Bool
}
