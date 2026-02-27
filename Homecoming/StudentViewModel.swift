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
    var students2: [Student] = []
    var scannedAltID: String?
    var searchedLastName: String?
    
    var scannedStudent: Student? {
        students.first
    }
    
    var searchedStudent: Student? {
        students2.first
    }
    
    let database = CKContainer.default().publicCloudDatabase
    
    init() { }
    
    func setScannedAltID(_ id: String) {
        scannedAltID = id
        pullFromDatabase(altID: id)
    }
    
    func setSearchLastName(_ name: String) {
        searchedLastName = name
        searchThroughDatabase(lastName: name)
    }
    
    func pullFromDatabase(altID: String) {
        let predicate = NSPredicate(format: "altIDNumber == %@", altID)
        let query = CKQuery(recordType: "Students", predicate: predicate)
        
        database.fetch(withQuery: query) { result in
            switch result {
            case .success(let response):
                var fetchedStudents: [Student] = []
                let dateFormatter = ISO8601DateFormatter()
                
                for (_, matchResult) in response.matchResults {
                    guard let record = try? matchResult.get() else { continue }
                    
                    let checkInTimeString = record["checkInTime"] as? String
                    let checkOutTimeString = record["checkOutTime"] as? String
                    let checkInTime = checkInTimeString != nil ? dateFormatter.date(from: checkInTimeString!) : nil
                    let checkOutTime = checkOutTimeString != nil ? dateFormatter.date(from: checkOutTimeString!) : nil
                    
                    let student = Student(
                        altID: record["altIDNumber"] as? String ?? "",
                        checkInTime: checkInTime,
                        checkOutTime: checkOutTime,
                        checkedInOrOut: record["checkedInOrOut"] as? String ?? "-",
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
                    print("\(student.firstName) \(student.lastName) - Status: \(student.checkedInOrOut)")
                    
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
    
    func searchThroughDatabase(lastName: String) {
        let predicate = NSPredicate(format: "lastName == %@", searchedLastName ?? "")
        let query = CKQuery(recordType: "Students", predicate: predicate)
        
        database.fetch(withQuery: query) { result in
            switch result {
            case .success(let response):
                var fetchedStudents: [Student] = []
                let dateFormatter = ISO8601DateFormatter()
                
                for (_, matchResult) in response.matchResults {
                    guard let record = try? matchResult.get() else { continue }
                    
                    let checkInTimeString = record["checkInTime"] as? String
                    let checkOutTimeString = record["checkOutTime"] as? String
                    let checkInTime = checkInTimeString != nil ? dateFormatter.date(from: checkInTimeString!) : nil
                    let checkOutTime = checkOutTimeString != nil ? dateFormatter.date(from: checkOutTimeString!) : nil
                    
                    let student = Student(
                        altID: record["altIDNumber"] as? String ?? "",
                        checkInTime: checkInTime,
                        checkOutTime: checkOutTime,
                        checkedInOrOut: record["checkedInOrOut"] as? String ?? "-",
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
                    print("\(student.firstName) \(student.lastName) - Status: \(student.checkedInOrOut)")
                    
                    fetchedStudents.append(student)
                }
                
                DispatchQueue.main.async {
                    self.students2 = fetchedStudents
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func toggleCheckInStatus(paymentMethod: String?) {
        guard let student = scannedStudent else {
            print("No scanned student")
            return
        }
        
        print("Toggling status for \(student.altID): \(student.checkedInOrOut)")
        
        let predicate = NSPredicate(format: "altIDNumber == %@", student.altID)
        let query = CKQuery(recordType: "Students", predicate: predicate)
        
        database.fetch(withQuery: query) { result in
            switch result {
            case .success(let response):
                guard let matchResult = response.matchResults.first else {
                    print("No record found")
                    return
                }
                
                guard let record = try? matchResult.1.get() else {
                    print("Failed to get record")
                    return
                }
                
                let currentStatus = record["checkedInOrOut"] as? String ?? "-"
                print("Current DB status: \(currentStatus)")
                
                let formatter = ISO8601DateFormatter()
                let nowString = formatter.string(from: Date())
                var newStatus: String
                
                if currentStatus == "-" {
                    newStatus = "Purchased"
                    record["checkInTime"] = nowString as CKRecordValue
                    record["checkOutTime"] = "-" as CKRecordValue
                    print("- → Purchased (checkInTime set)")
                    
                } else if currentStatus == "Purchased" {
                    newStatus = "Checked In"
                    record["checkInTime"] = nowString as CKRecordValue
                    record["checkOutTime"] = "-" as CKRecordValue
                    record["isPaid"] = true
                    if let paymentMethod = paymentMethod {
                        record["paymentMethod"] = paymentMethod
                    }
                    record["paymentTime"] = nowString as CKRecordValue
                    print("Purchased → Checked In (checkInTime updated)")
                    
                } else if currentStatus == "Checked In" {
                    newStatus = "Checked Out"
                    record["checkOutTime"] = nowString as CKRecordValue
                    print("Checked In → Checked Out (checkOutTime set)")
                    
                } else {
                    newStatus = "Checked Out"
                    print("Checked Out → Checked Out (no change)")
                }
                
                record["checkedInOrOut"] = newStatus as CKRecordValue
                print("Saving new status: \(newStatus)")
                
                self.database.save(record) { savedRecord, error in
                    if let error = error {
                        print("SAVE FAILED: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let savedRecord = savedRecord else {
                        print("No saved record returned")
                        return
                    }
                    
                    let savedStatus = savedRecord["checkedInOrOut"] as? String ?? "UNKNOWN"
                    print("SUCCESS: \(savedStatus)")
                    
                    let checkInTimeString = savedRecord["checkInTime"] as? String
                    let checkOutTimeString = savedRecord["checkOutTime"] as? String
                    let checkInTime = checkInTimeString.flatMap { formatter.date(from: $0) }
                    let checkOutTime = checkOutTimeString.flatMap { formatter.date(from: $0) }
                    
                    let updatedStudent = Student(
                        altID: savedRecord["altIDNumber"] as? String ?? student.altID,
                        checkInTime: checkInTime,
                        checkOutTime: checkOutTime,
                        checkedInOrOut: savedStatus,
                        firstName: savedRecord["firstName"] as? String ?? student.firstName,
                        guestCheckIn: savedRecord["guestCheckIn"] as? String ?? student.guestCheckIn,
                        guestName: savedRecord["guestName"] as? String ?? student.guestName,
                        guestParentPhone: savedRecord["guestParentPhone"] as? String ?? student.guestParentPhone,
                        guestSchool: savedRecord["guestSchool"] as? String ?? student.guestSchool,
                        idNumber: savedRecord["idNumber"] as? Int ?? student.idNumber,
                        lastName: savedRecord["lastName"] as? String ?? student.lastName,
                        studentEmail: savedRecord["studentEmail"] as? String ?? student.studentEmail,
                        studentParentCell: savedRecord["studentParentCell"] as? String ?? student.studentParentCell,
                        studentParentFirstName: savedRecord["studentParentFirstName"] as? String ?? student.studentParentFirstName,
                        studentParentLastName: savedRecord["studentParentLastName"] as? String ?? student.studentParentLastName,
                        studentParentPhone: savedRecord["studentParentPhone"] as? String ?? student.studentParentPhone
                    )
                    
                    DispatchQueue.main.async {
                        if !self.students.isEmpty {
                            self.students[0] = updatedStudent
                        } else {
                            self.students = [updatedStudent]
                        }
                    }
                }
                
            case .failure(let error):
                print("Query failed: \(error.localizedDescription)")
            }
        }
    }
}
