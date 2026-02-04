//
//  StudentViewModel.swift
//  Homecoming
//
//  Created by George Koroulis on 2/2/26.
//

import CloudKit

@Observable class StudentViewModel{
    var student: [Student] = []
    let database = CKContainer.default().privateCloudDatabase
    
    init() {
        pullFromDatabase()
    }
    
    func addStudent() {
        
    }
    
    func pullFromDatabase() {
        
    }
}
