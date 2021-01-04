//
//  Checker.swift
//  Navigation
//
//  Created by Andrey Antipov on 22.12.2020.
//  Copyright © 2020 Andrey Antipov. All rights reserved.
//
import Foundation

/// Class for login and password checking
class Checker {
    let login = "Petya"
    let password = "Password"
    
    static let shared: Checker = {
        let checker = Checker()
        return checker
    }()
    
    //MARK: - Init
    private init() {}
}

/// Accidental copy protection
extension Checker: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
