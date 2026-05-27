//
//  CSVImporter.swift
//  Homecoming
//
//  Created by Abhi Sorathiya on 5/12/26.
//

import Foundation
import CloudKit

enum CSVImporter {
    static let database = CKContainer.default().privateCloudDatabase

    static func importStudents(from fileURL: URL, completion: @escaping (String) -> Void) {
        let accessed = fileURL.startAccessingSecurityScopedResource()
        defer {
            if accessed { fileURL.stopAccessingSecurityScopedResource() }
        }

        do {
            let csvText = try String(contentsOf: fileURL, encoding: .utf8)
            let students = parseStudents(from: csvText)
            saveStudentsToCloudKit(students, completion: completion)
        } catch {
            completion("Could not read CSV: \(error.localizedDescription)")
        }
    }

    static func parseStudents(from csvText: String) -> [Student] {
        let lines = csvText.components(separatedBy: .newlines).filter { !$0.isEmpty }
        guard lines.count > 1 else { return [] }

        let header = splitCSVLine(lines[0])

        return lines.dropFirst().compactMap { line in
            let values = splitCSVLine(line)
            guard values.count == header.count else { return nil }

            let row = Dictionary(uniqueKeysWithValues: zip(header, values))

            let altID = row["altID"] ?? ""
            let firstName = row["firstName"] ?? ""
            let idNumber = Int(row["idNumber"] ?? "") ?? 0
            let lastName = row["LastName"] ?? ""
            let studentEmail = row["studentEmail"] ?? ""
            let studentParentCell = row["studentParentCell"] ?? ""
            let studentParentFirstName = row["StudentParentfirstName"] ?? ""
            let studentParentLastName = row["studentparentlastname"] ?? ""
            let studentParentPhone = row["studentParentPhone"] ?? ""

            return Student(
                altID: altID,
                checkInTime: nil,
                checkOutTime: nil,
                checkedInOrOut: "",
                firstName: firstName,
                guestCheckIn: "",
                guestName: "",
                guestParentPhone: "",
                guestSchool: "",
                idNumber: idNumber,
                lastName: lastName,
                studentEmail: studentEmail,
                studentParentCell: studentParentCell,
                studentParentFirstName: studentParentFirstName,
                studentParentLastName: studentParentLastName,
                studentParentPhone: studentParentPhone
            )
        }
    }

    static func saveStudentsToCloudKit(_ students: [Student], completion: @escaping (String) -> Void) {
        let records: [CKRecord] = students.map { student in
            let record = CKRecord(recordType: "Student")
            record["altID"] = student.altID as CKRecordValue
            record["firstName"] = student.firstName as CKRecordValue
            record["idNumber"] = NSNumber(value: student.idNumber)
            record["lastName"] = student.lastName as CKRecordValue
            record["studentEmail"] = student.studentEmail as CKRecordValue
            record["studentParentCell"] = student.studentParentCell as CKRecordValue
            record["studentParentFirstName"] = student.studentParentFirstName as CKRecordValue
            record["studentParentLastName"] = student.studentParentLastName as CKRecordValue
            record["studentParentPhone"] = student.studentParentPhone as CKRecordValue
            return record
        }

        let operation = CKModifyRecordsOperation(recordsToSave: records, recordIDsToDelete: nil)
        operation.savePolicy = .changedKeys
        operation.modifyRecordsResultBlock = { result in
            switch result {
            case .success:
                completion("Imported \(records.count) students into CloudKit.")
            case .failure(let error):
                completion("CloudKit save failed: \(error.localizedDescription)")
            }
        }

        database.add(operation)
    }

    static func splitCSVLine(_ line: String) -> [String] {
        var values: [String] = []
        var current = ""
        var inQuotes = false

        for char in line {
            if char == "\"" {
                inQuotes.toggle()
            } else if char == "," && !inQuotes {
                values.append(current.trimmingCharacters(in: .whitespaces))
                current = ""
            } else {
                current.append(char)
            }
        }

        values.append(current.trimmingCharacters(in: .whitespaces))
        return values
    }
}
