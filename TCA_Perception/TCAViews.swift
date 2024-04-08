import ComposableArchitecture
import SwiftUI

struct ListViewTCA: View {
    let store: StoreOf<ListFeature>

    var body: some View {
        Text("TCA")
        ScrollView {
            LazyVStack {
                ForEach(
                    store.scope(state: \.items, action: \.items)
                ) { itemStore in
                    ItemViewTCA(store: itemStore) { storeID in
                        let index = indexOf(storeID)
                        if index == store.items.count - 1 {
                            store.send(.addItems)
                        }
                    }
                }
            }
        }
    }
    func indexOf(_ itemID: Int) -> Int {
        store.items.firstIndex { $0.id == itemID } ?? 0
    }
}

struct ItemViewTCA: View {
    let store: StoreOf<ItemFeature>
    let onAppear: (Int) -> Void

    var body: some View {
        let _ = print("update", store.name)
        Color.random.opacity(0.5)
            .frame(width: 200, height: 300)
            .overlay {
                ZStack {
                    Color.random
                        .frame(width: 50, height: 50)
                    Text("\(store.id)")
                }
            }
            .onAppear { onAppear(store.id) }
    }
}
