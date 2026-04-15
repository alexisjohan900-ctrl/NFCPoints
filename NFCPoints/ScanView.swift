import SwiftUI
import CoreNFC

struct ScanView: View {
    @EnvironmentObject var dataManager: DataManager
    @StateObject private var nfcManager = NFCManager()
    @State private var selectedTeam: Team?
    @State private var showPointsModal = false
    @State private var showTeamSelection = false
    @State private var scanMessage = ""
    @State private var scanResultColor = Color.blue
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.blue.opacity(0.1),
                        Color.purple.opacity(0.1)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    VStack(spacing: 8) {
                        Text("Scan NFC Card")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.primary)
                        
                        Text("Hold card to device to add/subtract points")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .background(Color(.systemBackground))
                    .shadow(radius: 2)
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            // Selected Team Card
                            if let team = selectedTeam {
                                VStack(spacing: 16) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text("Current Team")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                            
                                            Text(team.name)
                                                .font(.title2)
                                                .fontWeight(.semibold)
                                        }
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .trailing, spacing: 8) {
                                            Text("Points")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                            
                                            Text("\(team.points)")
                                                .font(.system(size: 32, weight: .bold))
                                                .foregroundColor(ColorOption(rawValue: team.color)?.uiColor ?? .blue)
                                        }
                                    }
                                    
                                    Button(action: { selectedTeam = nil; showTeamSelection = true }) {
                                        Text("Change Team")
                                            .font(.caption)
                                            .foregroundColor(.blue)
                                    }
                                }
                                .padding(16)
                                .background(Color(.systemBackground))
                                .cornerRadius(12)
                                .shadow(color: ColorOption(rawValue: team.color)?.uiColor.opacity(0.3) ?? .blue.opacity(0.3), radius: 4, x: 0, y: 2)
                            } else {
                                Button(action: { showTeamSelection = true }) {
                                    VStack(spacing: 8) {
                                        Image(systemName: "person.fill.viewfinder")
                                            .font(.system(size: 40))
                                            .foregroundColor(.blue)
                                        
                                        Text("Select a Team")
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        
                                        Text("Choose the team to scan for")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(20)
                                    .background(Color(.systemBackground))
                                    .cornerRadius(12)
                                }
                            }
                            
                            // Scan Button
                            if selectedTeam != nil {
                                Button(action: startScanning) {
                                    HStack(spacing: 12) {
                                        Image(systemName: nfcManager.isScanning ? "radiowaves.right.fill" : "radiowaves.right")
                                            .font(.system(size: 20))
                                            .foregroundColor(.white)
                                        
                                        Text(nfcManager.isScanning ? "Scanning..." : "Scan Card")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(16)
                                    .background(nfcManager.isScanning ? Color.gray : Color.blue)
                                    .cornerRadius(12)
                                }
                                .disabled(nfcManager.isScanning)
                            }
                            
                            // Status Message
                            if !scanMessage.isEmpty {
                                HStack(spacing: 12) {
                                    Image(systemName: scanResultColor == .green ? "checkmark.circle.fill" : "exclamationmark.circle.fill")
                                        .foregroundColor(scanResultColor)
                                    
                                    Text(scanMessage)
                                        .font(.subheadline)
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                }
                                .padding(12)
                                .background(scanResultColor.opacity(0.1))
                                .cornerRadius(8)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                            }
                            
                            // Team Assignment Info
                            VStack(alignment: .leading, spacing: 12) {
                                Label("NFC Assignment Info", systemImage: "info.circle")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                
                                Text("You can assign NFC cards to teams in the Teams tab. When you scan an NFC card, it will automatically add/subtract the default points amount.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .lineLimit(nil)
                            }
                            .padding(12)
                            .background(Color.blue.opacity(0.05))
                            .cornerRadius(8)
                        }
                        .padding(16)
                    }
                }
            }
            .actionSheet(isPresented: $showTeamSelection) {
                ActionSheet(
                    title: Text("Select Team"),
                    message: Text("Choose a team to add/subtract points"),
                    buttons: dataManager.teams.map { team in
                        .default(Text(team.name)) {
                            selectedTeam = team
                        }
                    } + [.cancel()]
                )
            }
            .sheet(isPresented: $showPointsModal) {
                if let team = selectedTeam {
                    PointsModalView(team: team, isPresented: $showPointsModal)
                        .environmentObject(dataManager)
                }
            }
            .alert("Error", isPresented: .constant(!nfcManager.errorMessage?.isEmpty ?? false)) {
                Button("OK", role: .cancel) {
                    nfcManager.errorMessage = nil
                }
            } message: {
                Text(nfcManager.errorMessage ?? "")
            }
        }
    }
    
    private func startScanning() {
        guard let team = selectedTeam else { return }
        
        nfcManager.startScanning { tag in
            if let nfcTag = tag {
                // Check if this tag is assigned to any team
                if let assignedTeam = dataManager.getTeam(by: nfcTag), assignedTeam.id == team.id {
                    // Tag already assigned to this team - add points
                    dataManager.addPoints(to: team.id, amount: dataManager.defaultPointsAmount)
                    scanMessage = "Added \(dataManager.defaultPointsAmount) points to \(team.name)!"
                    scanResultColor = .green
                } else if dataManager.getTeam(by: nfcTag) != nil {
                    // Tag assigned to another team
                    scanMessage = "This card is assigned to another team"
                    scanResultColor = .orange
                } else {
                    // New tag - assign to current team
                    dataManager.assignNFCTag(teamId: team.id, tag: nfcTag)
                    dataManager.addPoints(to: team.id, amount: dataManager.defaultPointsAmount)
                    scanMessage = "Card assigned and \(dataManager.defaultPointsAmount) points added!"
                    scanResultColor = .green
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        scanMessage = ""
                    }
                }
            }
        }
    }
}

#Preview {
    ScanView()
        .environmentObject(DataManager())
}
