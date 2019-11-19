//
//  TaskOperation.swift
//  NikeTest
//
//  Created by Oj Shrivastava on 11/18/19.
//  Copyright © 2019 Oj Shrivastava. All rights reserved.
//

import UIKit

class TaskOperation: Operation {
    let task: URLSessionTask
    
    init(task: URLSessionTask) {
        self.task = task
        
        // Start the task
        task.resume()
        super.init()
    }
    
}
