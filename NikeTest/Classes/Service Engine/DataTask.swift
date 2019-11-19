//
//  DataTask.swift
//  NikeTest
//
//  Created by Oj Shrivastava on 11/18/19.
//  Copyright © 2019 Oj Shrivastava. All rights reserved.
//

import Foundation

typealias DataTaskCompletion = (_ result: Data?) -> Void

class DataTask {
    
    // Closure for sending the response back for each request
    var responseHandler: DataTaskCompletion?
    
    // Initialization for the Data Task Request with the completion handler
    init(withURL url: URL, responseHandler handler: @escaping DataTaskCompletion) {
        self.responseHandler = handler
        createDataTask(withURL: url)
    }
    
    // Creating the task
    private func createDataTask(withURL url: URL){
        let restAdapter = RestAdapter.sharedRestAdapter
        let task  = restAdapter.session.dataTask(with: url) {(data, response, error) in
            self.processResponse(data: data, response: response, error: error)
        }
        
        // Adding the task to the Operation Queue for concurrency
        let taskOperation = TaskOperation.init(task: task)
        restAdapter.addData(withTaskOperation: taskOperation)
    }
    
    private func processResponse(data: Data?, response: URLResponse?, error: Error?){
        
        // unwrap data
        guard let data = data else {
            // unwrap error
            guard let error = error else {return}
            // return error to delegate
            print("Got Some Error " + error.localizedDescription)
            return
        }
        responseHandler!(data)
        
    }
    
}

