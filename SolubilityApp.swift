import SwiftUI

@main
struct SolubilityApp: App {
    init() {
        AppFonts.register()
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
