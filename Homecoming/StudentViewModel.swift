//
//  StudentViewModel.swift
//  Homecoming
//
//  Created by George Koroulis on 2/2/26.
//

import CloudKit
import SwiftUI

@Observable
class StudentViewModel {
    var students: [Student] = []
    var scannedAltID: Int? {
        didSet {
            guard let scannedAltID else { return }
            pullFromDatabase(altID: scannedAltID)
        }
    }
    
    let database = CKContainer.default().publicCloudDatabase
    
    func pullFromDatabase(altID: Int) {
        let predicate = NSPredicate(format: "altIDNumber == %d", altID)
        let query = CKQuery(recordType: "Student", predicate: predicate)
        
        database.fetch(withQuery: query) { result in
            switch result {
            case .success(let response):
                var fetchedStudents: [Student] = []
                
                for (_, matchResult) in response.matchResults {
                    guard let record = try? matchResult.get() else { continue }
                    
                    let student = Student(
                        altID: record["altIDNumber"] as? Int ?? 0,
                        checkInTime: record["checkInTime"] as? Date,
                        checkOutTime: record["checkOutTime"] as? Date,
                        checkedInOrOut: record["checkedInOrOut"] as? Bool ?? false,
                        firstName: record["firstName"] as? String ?? "",
                        guestCheckIn: record["guestCheckIn"] as? String ?? "",
                        guestName: record["guestName"] as? String ?? "",
                        guestParentPhone: record["guestParentPhone"] as? String ?? "",
                        guestSchool: record["guestSchool"] as? String ?? "",
                        idNumber: record["idNumber"] as? Int ?? 0,
                        lastName: record["lastName"] as? String ?? "",
                        studentEmail: record["studentEmail"] as? String ?? "",
                        studentParentCell: record["studentParentCell"] as? String ?? "",
                        studentParentFirstName: record["studentParentFirstName"] as? String ?? "",
                        studentParentLastName: record["studentParentLastName"] as? String ?? "",
                        studentParentPhone: record["studentParentPhone"] as? String ?? ""
                    )
                    
                    fetchedStudents.append(student)
                }
                
                DispatchQueue.main.async {
                    self.students = fetchedStudents
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

