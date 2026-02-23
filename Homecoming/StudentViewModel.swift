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
    var scannedAltID: String?
    
    var scannedStudent: Student? {
        students.first
    }
    
    let database = CKContainer.default().publicCloudDatabase
    
    init() { }
    
    func setScannedAltID(_ id: String) {
        scannedAltID = id
        pullFromDatabase(altID: id)
    }
    
    func pullFromDatabase(altID: String) {
        let predicate = NSPredicate(format: "altIDNumber == %@", scannedAltID ?? "")
        let query = CKQuery(recordType: "Students", predicate: predicate)
        
        database.fetch(withQuery: query) { result in
            switch result {
            case .success(let response):
                var fetchedStudents: [Student] = []
                
                for (_, matchResult) in response.matchResults {
                    guard let record = try? matchResult.get() else { continue }
                    
                    let student = Student(
                        altID: record["altIDNumber"] as? String ?? "",
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
                    print(student.firstName + " " + student.lastName)
                    
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
    
//    func markStudentPaid(method: String) {
//        guard let student = scannedStudent else { return }
//        
//        let predicate = NSPredicate(format: "altIDNumber == %@", student.altID)
//        let query = CKQuery(recordType: "altIDNumber", predicate: predicate)
//        
//        database.fetch(withQuery: query) { result in
//            switch result {
//            case .success(let response):
//                
//                for (_, matchResult) in response.matchResults {
//                    guard let record = try? matchResult.get() else { continue }
//                    
//                    record["isPaid"] = true
//                    record["paymentMethod"] = method
//                    record["paymentTime"] = Date()
//                    record["checkedInOrOut"] = true
//                    record["checkInTime"] = Date()
//                    
//                    self.database.save(record) { _, error in
//                        if let error = error {
//                            print(error.localizedDescription)
//                        }
//                    }
//                }
//                
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
}

