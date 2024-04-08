import Foundation
import ComposableArchitecture

@Reducer
struct ListFeature {
    @ObservableState
    struct State {
        var items: IdentifiedArrayOf<ItemFeature.State> = [
            .init(id: 0),
            .init(id: 1),
            .init(id: 2),
            .init(id: 3),
            .init(id: 4)
        ]
    }

    enum Action {
        case items(IdentifiedActionOf<ItemFeature>)
        case addItems
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .items:
                return .none
            case .addItems:
                let lastIndex = state.items.endIndex
                for index in lastIndex..<lastIndex + 5 {
                    state.items.append(.init(id: index))
                }
                print("elements added")
                return .none
            }
        }
        .forEach(\.items, action: \.items) {
            ItemFeature()
        }
    }
}

@Reducer
struct ItemFeature {
    @ObservableState
    struct State: Identifiable {
        let id: Int
        var name: String { "\(id)" }
    }
}
