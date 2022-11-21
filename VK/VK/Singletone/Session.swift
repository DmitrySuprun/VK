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
    var userID: Int = 0
    var token: String = ""
    
    // MARK: - Private Initializer
    private init() {}
}
