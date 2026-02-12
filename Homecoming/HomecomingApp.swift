//
//  HomecomingApp.swift
//  Homecoming
//
//  Created by Devin M. Joseph on 12/15/25.
//

import SwiftUI

@main
struct HomecomingApp: App {
    @State var viewModel: StudentViewModel = StudentViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(viewModel)
        }
    }
}
