//
//  ContentView.swift
//  Homecoming
//
//  Created by Devin M. Joseph on 12/15/25.
//

//
//  ContentView.swift
//  Homecoming
//
//  Created by Devin M. Joseph on 12/15/25.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @Environment(StudentViewModel.self) var viewModel
    @State var showingCSVImporter = false
    @State var statusMessage = ""

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.30, green: 0.16, blue: 0.10),
                        Color(red: 0.92, green: 0.48, blue: 0.12),
                        Color(red: 0.98, green: 0.95, blue: 0.92)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 18) {
                        VStack(spacing: 10) {
                            Image(systemName: "pawprint.fill")
                                .font(.system(size: 44, weight: .bold))
                                .foregroundStyle(.white)

                            Text("Hersey Homecoming")
                                .font(.largeTitle.bold())
                                .foregroundStyle(.white)

                            Text("Huskies spirit • guest management • event access")
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.9))
                        }
                        .padding(.top, 20)

                        VStack(spacing: 14) {
                            NavigationLink(destination: ScanID()) {
                                labelCard(title: "Scan ID", systemImage: "qrcode.viewfinder")
                            }

                            NavigationLink(destination: StudentListView()) {
                                labelCard(title: "Guest List", systemImage: "person.3.fill")
                            }

                            Button {
                                showingCSVImporter = true
                            } label: {
                                labelCard(title: " CSV Import", systemImage: "doc.badge.plus")
                            }
                        }
                        .fileImporter(
                            isPresented: $showingCSVImporter,
                            allowedContentTypes: [.commaSeparatedText],
                            allowsMultipleSelection: false
                        ) { result in
                            switch result {
                            case .success(let urls):
                                if let fileURL = urls.first {
                                    CSVImporter.importStudents(from: fileURL) { message in
                                        DispatchQueue.main.async {
                                            statusMessage = message
                                        }
                                    }
                                }
                            case .failure(let error):
                                statusMessage = "File error: \(error.localizedDescription)"
                            }
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Status")
                                .font(.headline)
                                .foregroundStyle(.white)

                            Text(statusMessage.isEmpty ? "Ready for homecoming check-in." : statusMessage)
                                .font(.footnote)
                                .foregroundStyle(.white.opacity(0.9))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .background(.white.opacity(0.12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 22)
                                .stroke(.white.opacity(0.18), lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 22))
                        .padding(.top, 6)

                        Spacer(minLength: 20)
                    }
                    .padding()
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }

    private func labelCard(title: String, systemImage: String) -> some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white.opacity(0.18))
                    .frame(width: 52, height: 52)

                Image(systemName: systemImage)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(.white)
            }

            Text(title)
                .font(.headline)
                .foregroundStyle(.white)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white.opacity(0.85))
        }
        .padding()
        .background(.white.opacity(0.14))
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(.white.opacity(0.18), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .shadow(color: .black.opacity(0.12), radius: 10, x: 0, y: 6)
    }
}
