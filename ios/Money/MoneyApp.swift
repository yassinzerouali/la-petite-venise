import SwiftUI
import UIKit

@main
struct MoneyApp: App {
    init() {
        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithOpaqueBackground()
        navAppearance.backgroundColor = UIColor(red: 0.957, green: 0.925, blue: 0.867, alpha: 1.0)
        navAppearance.titleTextAttributes = [
            .foregroundColor: UIColor(red: 0.133, green: 0.220, blue: 0.290, alpha: 1.0)
        ]
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
        UINavigationBar.appearance().compactAppearance = navAppearance

        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundColor = UIColor(red: 0.984, green: 0.965, blue: 0.925, alpha: 1.0)
        UITabBar.appearance().standardAppearance = tabAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabAppearance
    }

    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
