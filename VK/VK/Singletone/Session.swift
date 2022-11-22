//
//  Session.swift
//  VK
//
//  Created by Дмитрий Супрун on 21.11.22.
//

import Foundation

/// Information about current session
class Session {
    // MARK: - Class Properties
    static var shared = Session()
    
    // MARK: - Public Properties
    var userID = 0
    var token = ""
    
    // MARK: - Private Initializer
    private init() {}
}
