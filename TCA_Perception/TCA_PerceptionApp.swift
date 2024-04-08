import SwiftUI

@main
struct TCA_PerceptionApp: App {
    var body: some Scene {
        WindowGroup {
            ListViewTCA(store: .init(initialState: ListFeature.State(), reducer: ListFeature.init))
//            ListViewSwiftUI()
        }
    }
}
