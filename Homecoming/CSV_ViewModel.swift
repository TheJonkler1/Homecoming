//
//  CSV_ViewModel.swift
//  Homecoming
//
//  Created by George Koroulis on 3/11/26.
//

import SwiftUI

class CSV {
    func loadCSV(fileName: String) -> [[String]] {
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: "csv") else {
            
            print("CSV file Not Found")
            
            return []
            
        }
        
        do {
            let data = try String(contentsOfFile: path)
            
            let rows = data.components(separatedBy: "\n")
            
            var result: [[String]] = []
            
            for row in rows {
                let columns = row.components(separatedBy: ",")
                result.append(columns)
            }
            result.removeLast()
            return result
            
        } catch {
            
            print("Error Reading CSV")
            return []
            
        }
    }
    
    func loadStudentInfo() -> [studentInfo] {
        
        let rows = loadCSV(fileName: "Students")
        
        var students: [studentInfo] = []
        
        for row in rows {
                
                let student = studentInfo(altId: row[0], firstName: row[1], lastName: row[2], id: row[3], email: row[4], parentPhone1: row[5], parentFirstName: row[6], parentLastName: row[7], parentPhone2: row[8])
                
                students.append(student)
            
        }
        return students
    }
    
}

struct studentInfo {
    var altId: String
    var firstName: String
    var lastName: String
    var id: String
    var email: String
    var parentPhone1: String
    var parentFirstName: String
    var parentLastName: String
    var parentPhone2: String
}
