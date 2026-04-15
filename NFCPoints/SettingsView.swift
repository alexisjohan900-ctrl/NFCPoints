import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var showAbout = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.orange.opacity(0.1),
                        Color.yellow.opacity(0.1)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    VStack(spacing: 8) {
                        Text("Settings")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.primary)
                        
                        Text("Customize your experience")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .background(Color(.systemBackground))
                    .shadow(radius: 2)
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            // Default Points Section
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Point Settings")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                VStack(spacing: 12) {
                                    HStack {
                                        Label("Default Points per Scan", systemImage: "point.fill")
                                            .font(.subheadline)
                                        
                                        Spacer()
                                        
                                        HStack(spacing: 8) {
                                            Button(action: decreasePoints) {
                                                Image(systemName: "minus.circle.fill")
                                                    .foregroundColor(.red)
                                            }
                                            
                                            Text("\(dataManager.defaultPointsAmount)")
                                                .font(.headline)
                                                .frame(minWidth: 40, alignment: .center)
                                            
                                            Button(action: increasePoints) {
                                                Image(systemName: "plus.circle.fill")
                                                    .foregroundColor(.green)
                                            }
                                        }
                                    }
                                    
                                    Slider(
                                        value: Binding(
                                            get: { Double(dataManager.defaultPointsAmount) },
                                            set: { dataManager.setDefaultPoints(Int($0)) }
                                        ),
                                        in: 1...100,
                                        step: 1
                                    )
                                    
                                    Text("This amount will be added/subtracted each time you scan a card")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                .padding(12)
                                .background(Color(.systemBackground))
                                .cornerRadius(8)
                            }
                            .padding(16)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            
                            // Team Statistics
                            if !dataManager.teams.isEmpty {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Team Statistics")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    VStack(spacing: 8) {
                                        HStack {
                                            Label("Total Teams", systemImage: "person.3.fill")
                                                .font(.subheadline)
                                            
                                            Spacer()
                                            
                                            Text("\(dataManager.teams.count)")
                                                .font(.headline)
                                                .foregroundColor(.blue)
                                        }
                                        
                                        Divider()
                                        
                                        HStack {
                                            Label("Total Points", systemImage: "sum")
                                                .font(.subheadline)
                                            
                                            Spacer()
                                            
                                            Text("\(dataManager.teams.reduce(0) { $0 + $1.points })")
                                                .font(.headline)
                                                .foregroundColor(.purple)
                                        }
                                        
                                        Divider()
                                        
                                        HStack {
                                            Label("Leading Team", systemImage: "crown.fill")
                                                .font(.subheadline)
                                            
                                            Spacer()
                                            
                                            Text(leadingTeamName)
                                                .font(.headline)
                                                .foregroundColor(.orange)
                                        }
                                    }
                                    .padding(12)
                                    .background(Color(.systemBackground))
                                    .cornerRadius(8)
                                }
                                .padding(16)
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            }
                            
                            // About Section
                            VStack(alignment: .leading, spacing: 12) {
                                Text("About")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Button(action: { showAbout = true }) {
                                    HStack {
                                        Label("About NFCPoints", systemImage: "info.circle.fill")
                                            .font(.subheadline)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .font(.caption)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(12)
                                    .background(Color(.systemBackground))
                                    .foregroundColor(.primary)
                                    .cornerRadius(8)
                                }
                            }
                            .padding(16)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            
                            // Footer
                            VStack(spacing: 8) {
                                Text("NFCPoints v1.0")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                Text("Manage team points with NFC technology")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(16)
                        }
                        .padding(16)
                    }
                }
            }
            .sheet(isPresented: $showAbout) {
                NavigationStack {
                    VStack(spacing: 20) {
                        VStack(spacing: 12) {
                            Image(systemName: "nfc.contactless")
                                .font(.system(size: 50))
                                .foregroundColor(.blue)
                            
                            Text("NFCPoints")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text("Version 1.0")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(24)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Features")
                                    .font(.headline)
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Label("Scan NFC cards to add/subtract points", systemImage: "nfc.contactless")
                                    Label("Manage multiple teams", systemImage: "person.3.fill")
                                    Label("Customizable point amounts", systemImage: "slider.horizontal.3")
                                    Label("Team statistics and rankings", systemImage: "chart.bar")
                                }
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            }
                            
                            Divider()
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Requirements")
                                    .font(.headline)
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Label("iOS 15.0 or later", systemImage: "iphone")
                                    Label("NFC support", systemImage: "antenna.radiowaves.left.and.right")
                                }
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(16)
                        
                        Spacer()
                        
                        Button("Done") {
                            showAbout = false
                        }
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(16)
                    }
                    .navigationTitle("About")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
    
    private func increasePoints() {
        dataManager.setDefaultPoints(dataManager.defaultPointsAmount + 1)
    }
    
    private func decreasePoints() {
        if dataManager.defaultPointsAmount > 1 {
            dataManager.setDefaultPoints(dataManager.defaultPointsAmount - 1)
        }
    }
    
    private var leadingTeamName: String {
        dataManager.teams.max(by: { $0.points < $1.points })?.name ?? "N/A"
    }
}

#Preview {
    SettingsView()
        .environmentObject(DataManager())
}
