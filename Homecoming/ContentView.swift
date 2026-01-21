//
//  ContentView.swift
//  Homecoming
//
//  Created by Devin M. Joseph on 12/15/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            NavigationLink("Scan ID", destination: ScanID())
            NavigationLink("Guest List", destination: StudentListView())
            Button("Guest Application") {
                
            }
            HStack{
                
            }
        }
    }
}


#Preview {
    ContentView()
}
