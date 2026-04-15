import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Scan Tab
            ScanView()
                .tabItem {
                    Label("Scan", systemImage: "radiowaves.right")
                }
                .tag(0)
            
            // Teams Tab
            TeamListView()
                .tabItem {
                    Label("Teams", systemImage: "person.3.fill")
                }
                .tag(1)
            
            // Redemption Tab
            RedemptionView()
                .tabItem {
                    Label("Redeem", systemImage: "gift.fill")
                }
                .tag(2)
            
            // Gift Management Tab
            GiftManagementView()
                .tabItem {
                    Label("Gifts", systemImage: "star.fill")
                }
                .tag(3)
            
            // Settings Tab
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(4)
        }
        .onAppear {
            setupTabBarAppearance()
        }
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color(.systemGray6))
        
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DataManager())
}
