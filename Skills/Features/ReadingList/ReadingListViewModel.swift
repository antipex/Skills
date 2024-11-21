//
//  ReadingListViewModel.swift
//  Skills
//
//  Created by Kyle Rohr on 20/11/2024.
//

import SwiftUI
import Combine

@Observable
final class ReadingListViewModel {
    private(set) var state: State = .initial
    private(set) var readables: [any Readable] = []

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
            populateReadables()
        }
    }

    private func populateReadables() {
        guard state != .loaded else { return }

        do {
            let websites = try FileDecoder.load([Website].self, fromFileNamed: "websites") ?? []

            readables.append(contentsOf: websites)
            state = .loaded
        } catch {
            print("Error loading websites: \(error.localizedDescription)")
            state = .error
        }
    }
}

extension ReadingListViewModel {
    enum State {
        case initial
        case loaded
        case error
    }

    enum ViewEvent {
        case onAppear
    }
}
