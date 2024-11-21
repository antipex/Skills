//
//  HomeView.swift
//  Skills
//
//  Created by Kyle Rohr on 20/11/2024.
//

import SwiftUI

enum NavigationDestination: String, Hashable {
    case learn
    case readingList
    case about
}

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: .Spacing.eight) {
                VStack(spacing: .Spacing.four) {
                    Text("Skills")
                        .typography(.title)
                    Text("An exploration of interview coding assessments.")
                        .typography(.heading3)
                }

                VStack(spacing: .Spacing.six) {
                    HomeButton(title: "Learn", imageName: "graduationcap.fill", destination: .learn)
                    HomeButton(title: "Reading List", imageName: "safari.fill", destination: .readingList)
                    HomeButton(title: "About", imageName: "questionmark.circle.fill", destination: .about)
                }
                .padding(.horizontal)
            }
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .learn:
                    LearnView(viewModel: LearnViewModel())
                case .readingList:
                    ReadingListView(viewModel: ReadingListViewModel())
                case .about:
                    AboutView()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

private struct HomeButton: View {
    let title: String
    let imageName: String
    let destination: NavigationDestination

    var body: some View {
        NavigationLink(value: destination) {
            VStack(spacing: .Spacing.four) {
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 32)
                Text(title)
                    .typography(.heading2)
            }
            .padding(.vertical, .Spacing.four)
            .padding(.horizontal, .Spacing.six)
        }
        .foregroundStyle(.primary)
    }
}
