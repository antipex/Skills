//
//  LearnView.swift
//  Skills
//
//  Created by Kyle Rohr on 20/11/2024.
//

import SwiftUI

struct LearnView: View {
    @State var viewModel: LearnViewModel

    var body: some View {
        ZStack {
            TabView(selection: $viewModel.currentCardIndex) {
                ForEach(Array(zip(viewModel.cards.indices, viewModel.cards)), id: \.0) { (index, card) in
                    VStack {
                        Card(
                            index: index,
                            numCards: viewModel.cards.count,
                            title: card.title,
                            text: card.body,
                            question: card.question,
                            backAction: {
                                viewModel.viewEvents.send(.tappedBack)
                            },
                            forwardAction: {
                                viewModel.viewEvents.send(.tappedForward)
                            }
                        )
                        .padding(.Spacing.seven)
                        .tag(index)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .animation(.easeInOut(duration: 1.0), value: viewModel.currentCardIndex)
            .transition(.slide)
            .onAppear {
                viewModel.viewEvents.send(.onAppear)
            }
        }
        .navigationTitle("Learn")
    }
}

#Preview {
    NavigationStack {
        LearnView(viewModel: LearnViewModel())
    }
}

private struct Card: View {
    let index: Int
    let numCards: Int
    let title: String
    let text: String
    let question: String?
    let backAction: () -> Void
    let forwardAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: .Spacing.seven) {
            Text(title)
                .typography(.heading1)

            Text(text)

            if let question {
                VStack(alignment: .leading, spacing: .Spacing.four) {
                    Text("Question")
                        .typography(.info)
                    Text(question)
                        .typography(.bodyL)
                }
            }

            VStack(alignment: .center) {
                HStack {
                    if index > 0 {
                        Button {
                            backAction()
                        } label: {
                            Image(systemName: "arrow.left")
                        }
                    }

                    Spacer()

                    if index < numCards - 1 {
                        Button {
                            forwardAction()
                        } label: {
                            Image(systemName: "arrow.right")
                        }
                    }
                }
                .foregroundStyle(.primary)
            }
            .frame(maxWidth: .infinity)
        }
        .typography(.bodyXL)
    }
}
