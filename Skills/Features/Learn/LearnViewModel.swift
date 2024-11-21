//
//  LearnViewModel.swift
//  Skills
//
//  Created by Kyle Rohr on 20/11/2024.
//

import SwiftUI
import Combine

@Observable
final class LearnViewModel {
    private(set) var state: State = .initial
    var currentCardIndex: Int = 0
    private(set) var cards: [LearnCard] = []

    let viewEvents = PassthroughSubject<ViewEvent, Never>()

    private var cancellables = Set<AnyCancellable>()

    init() {
        setupBindings()
    }

    private func setupBindings() {
        viewEvents
            .sink(receiveValue: handleViewEvent)
            .store(in: &cancellables)
    }

    private func handleViewEvent(_ event: ViewEvent) {
        switch event {
        case .onAppear:
            populateCards()
        case .tappedBack:
            if currentCardIndex > 0 {
                currentCardIndex -= 1
            }
        case .tappedForward:
            if currentCardIndex <= cards.count - 1 {
                currentCardIndex += 1
            }
        }
    }

    private func populateCards() {
        guard state != .loaded else { return }

        do {
            cards = try FileDecoder.load([LearnCard].self, fromFileNamed: "learnCards") ?? []
            state = .loaded
        } catch {
            print("Error loading cards: \(error.localizedDescription)")
            state = .error
        }
    }
}

extension LearnViewModel {
    enum State {
        case initial
        case loaded
        case error
    }

    enum ViewEvent {
        case onAppear
        case tappedBack
        case tappedForward
    }
}
