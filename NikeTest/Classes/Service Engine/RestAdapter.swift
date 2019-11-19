//
//  RestAdapter.swift
//  NikeTest
//
//  Created by Oj Shrivastava on 11/18/19.
//  Copyright © 2019 Oj Shrivastava. All rights reserved.
//

import Foundation

class RestAdapter {
    
    // Singleton Instance for the Rest Adapter
    static let sharedRestAdapter = RestAdapter()
    
    // Shared Session
    let session = URLSession.shared
    
    // Operation Queue for the session
    private let sessionQueue = OperationQueue.main
    
    private init() {
        sessionQueue.maxConcurrentOperationCount = 5
    }
}

extension RestAdapter {
    
    // MARK: - get Session instance
    func getSession() -> URLSession {
        return session
    }
    
    // Add the Data Task Operation to the Queue
    func addData(withTaskOperation taskOperation :TaskOperation) {
        sessionQueue.addOperation(taskOperation)
    }
    
}

