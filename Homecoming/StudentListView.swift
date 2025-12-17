//
//  StudentListView.swift
//  Homecoming
//
//  Created by George Koroulis on 12/17/25.
//

import SwiftUI

struct StudentListView: View {
    @State var arrayOfStudents: [String] = ["George", "Devin", "Abhi", "Leo"]
    var body: some View {
        List {
            ForEach(arrayOfStudents, id: \.self) { student in
                Text(student)
            }
        }
    }
}

