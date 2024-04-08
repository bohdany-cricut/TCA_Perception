import SwiftUI

@Observable
class ListViewModel {
    var items: [Int] = [0, 1, 2, 3, 4]

    func addItems() {
        let lastIndex = items.endIndex
        for index in lastIndex..<lastIndex + 5 {
            items.append(index)
        }
        print("elements added")
    }
}

struct ListViewSwiftUI: View {
    let viewModel = ListViewModel()
    var body: some View {
        Text("Vanilla SwiftUI")
        ScrollView {
            LazyVStack {
                ForEach(
                    viewModel.items, id: \.self
                ) { item in
                    ItemViewSwiftUI(item: item) { item in
                        let index = indexOf(item)
                        if index == viewModel.items.count - 1 {
                            viewModel.addItems()
                        }
                    }
                }
            }
        }
    }
    func indexOf(_ item: Int) -> Int {
        viewModel.items.firstIndex { $0 == item } ?? 0
    }
}

struct ItemViewSwiftUI: View {
    let item: Int
    let onAppear: (Int) -> Void

    var body: some View {
        let _ = print("update", item)
        Color.random.opacity(0.5)
            .frame(width: 200, height: 300)
            .overlay {
                ZStack {
                    Color.random.frame(width: 50, height: 50)
                    Text("\(item)")
                }
            }
            .onAppear { onAppear(item) }
            .id(item)
    }
}
