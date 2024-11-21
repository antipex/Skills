//
//  ReadingListView.swift
//  Skills
//
//  Created by Kyle Rohr on 20/11/2024.
//

import SwiftUI

struct ReadingListView: View {
    @State var viewModel: ReadingListViewModel

    @State private var website: Website?

    var body: some View {
        ScrollView {
            VStack(spacing: .Spacing.six) {
                if viewModel.state == .error {
                    Section {
                        HStack {
                            Image(systemName: "exclamationmark.triangle")
                            Text("Could not load websites.")
                        }
                    }
                }

                ForEach(viewModel.readables, id: \.id) { readable in
                    HStack(alignment: .top) {
                        if let readable = readable as? Website {
                            Button {
                                website = readable
                            } label: {
                                listItem(for: readable)
                            }
                            .foregroundStyle(.primary)
                        }

                        Image(systemName: "arrow.up.forward.app")
                    }
                }
            }
        }
        .padding(.Spacing.six)
        .navigationTitle("Reading List")
        .onAppear {
            viewModel.viewEvents.send(.onAppear)
        }
        .sheet(item: $website) { website in
            SafariView(url: website.url)
        }
    }

    @ViewBuilder
    private func listItem(for readable: any Readable) -> some View {
        Text(readable.title)
            .typography(.bodyXL)
    }
}

#Preview {
    NavigationStack {
        ReadingListView(viewModel: ReadingListViewModel())
    }
}
