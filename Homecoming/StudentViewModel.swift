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
    let scannedID = 197063
    
    init() {
        pullFromDatabase()
    }
    
    func addStudent() {
        
    }
    
    func pullFromDatabase() {
        let predicate = NSPredicate(format: "altIDNumber", scannedID)
        let query = CKQuery(recordType: "altIDNumber", predicate: predicate)
        
        database.fetch(withQuery: query) { result in
            switch result {
            case.success(let response):
                var downloadedStudent: [Student] = []
                
                for matchResult in response.matchResults {
                    if let record = try? matchResult.1.get() {
                        let altID = record["altIDNumber"] as? Int ?? 0
                        let checkInTime = record["checkInTime"] as? Date ?? Date()
                        let checkOutTime = record["checkOutTime"] as? Date ?? Date()
                        let checkedInOrOut = record["checkedInOrOut"] as? Bool ?? false
                        let firstName = record["firstName"] as? String ?? ""
                        let guestCheckIn = record["guestCheckIn"] as? String ?? ""
                        let guestName = record["guestName"] as? String ?? ""
                        let guestParentPhone = record["guestParentPhone"] as? String ?? ""
                        let guestSchool = record["guestSchool"] as? String ?? ""
                        let idNumber = record["idNumber"] as? Int ?? 0
                        let lastName = record["lastName"] as? String ?? ""
                        let studentEmail = record["studentEmail"] as? String ?? ""
                        let studentParentCell = record["studentParentCell"] as? String ?? ""
                        let studentParentFirstName = record["studentParentFirstName"] as? String ?? ""
                        let studentParentLastName = record["studentParentLastName"] as? String ?? ""
                        let studentParentPhone = record["studentParentPhone"] as? String ?? ""
                        let currentStudent = Student(altID: altID, checkedInOrOut: checkedInOrOut, firstName: firstName, guestCheckIn: guestCheckIn, guestName: guestName, guestParentPhone: guestParentPhone, guestSchool: guestSchool, idNumber: idNumber, lastName: lastName, studentEmail: studentEmail, studentParentCell: studentParentCell, studentParentFirstName: studentParentFirstName, studentParentLastName: studentParentLastName, studentParentPhone: studentParentPhone)
                        
                        downloadedStudent.append(currentStudent)
                        
                        
                        
                    }
                    DispatchQueue.main.async {
                        self.student.removeAll()
                        self.student = downloadedStudent
                    }
                }
            case.failure(let error):
                print(error)
            }
        }
    }
}
