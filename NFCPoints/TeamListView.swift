import SwiftUI

struct TeamListView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var showAddTeam = false
    @State private var selectedTeam: Team?
    @State private var showTeamActions = false
    @State private var newTeamName = ""
    @State private var selectedColor = "blue"
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.purple.opacity(0.1),
                        Color.pink.opacity(0.1)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    VStack(spacing: 8) {
                        Text("Teams")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.primary)
                        
                        Text("\(dataManager.teams.count) team\(dataManager.teams.count != 1 ? "s" : "")")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .background(Color(.systemBackground))
                    .shadow(radius: 2)
                    
                    if dataManager.teams.isEmpty {
                        // Empty State
                        Spacer()
                        VStack(spacing: 16) {
                            Image(systemName: "person.2.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                            
                            Text("No Teams Yet")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text("Create a team to get started with NFC scanning")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(32)
                        Spacer()
                    } else {
                        // Teams List
                        ScrollView {
                            VStack(spacing: 12) {
                                ForEach(dataManager.teams) { team in
                                    TeamCardView(team: team)
                                        .onTapGesture {
                                            selectedTeam = team
                                            showTeamActions = true
                                        }
                                }
                            }
                            .padding(16)
                        }
                    }
                    
                    // Add Team Button
                    Button(action: { showAddTeam = true }) {
                        HStack(spacing: 12) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 18))
                            
                            Text("Add Team")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(14)
                        .foregroundColor(.white)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.purple, Color.pink]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(10)
                        .padding(16)
                    }
                }
            }
            .sheet(isPresented: $showAddTeam) {
                NavigationStack {
                    VStack(spacing: 16) {
                        TextField("Team Name", text: $newTeamName)
                            .textFieldStyle(.roundedBorder)
                            .padding(16)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Team Color")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 16)
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
                                ForEach(ColorOption.allCases, id: \.rawValue) { color in
                                    Button(action: { selectedColor = color.rawValue }) {
                                        Circle()
                                            .fill(color.uiColor)
                                            .frame(height: 50)
                                            .overlay(
                                                selectedColor == color.rawValue ?
                                                Circle()
                                                    .stroke(Color.black, lineWidth: 3)
                                                : nil
                                            )
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                        
                        Spacer()
                        
                        Button(action: addTeam) {
                            Text("Create Team")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(12)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding(16)
                        .disabled(newTeamName.isEmpty)
                    }
                    .navigationTitle("New Team")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Cancel") {
                                showAddTeam = false
                                resetForm()
                            }
                        }
                    }
                }
            }
            .confirmationDialog(
                "Team Options",
                isPresented: $showTeamActions,
                presenting: selectedTeam
            ) { team in
                Button("Edit") { }
                
                Button("Reset Points") {
                    dataManager.resetPoints(for: team.id)
                }
                
                Button("Delete Team", role: .destructive) {
                    dataManager.deleteTeam(id: team.id)
                    selectedTeam = nil
                }
                
                Button("Cancel", role: .cancel) { }
            } message: { team in
                Text("What would you like to do with \(team.name)?")
            }
        }
    }
    
    private func addTeam() {
        dataManager.addTeam(name: newTeamName, color: selectedColor)
        showAddTeam = false
        resetForm()
    }
    
    private func resetForm() {
        newTeamName = ""
        selectedColor = "blue"
    }
}

struct TeamCardView: View {
    let team: Team
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(team.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    if let nfcTag = team.nfcTag {
                        Label("Card Assigned", systemImage: "nfc.contactless")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(team.points)")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(ColorOption(rawValue: team.color)?.uiColor ?? .blue)
                    
                    Text("Points")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            // Quick Action Buttons
            HStack(spacing: 8) {
                Button(action: {}) {
                    HStack(spacing: 4) {
                        Image(systemName: "plus")
                            .font(.caption)
                        Text("Add")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .foregroundColor(.green)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(6)
                }
                
                Button(action: {}) {
                    HStack(spacing: 4) {
                        Image(systemName: "minus")
                            .font(.caption)
                        Text("Subtract")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .foregroundColor(.red)
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(6)
                }
                
                Button(action: {}) {
                    HStack(spacing: 4) {
                        Image(systemName: "gift.fill")
                            .font(.caption)
                        Text("Redeem")
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .foregroundColor(.orange)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(6)
                }
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: ColorOption(rawValue: team.color)?.uiColor.opacity(0.2) ?? .blue.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    TeamListView()
        .environmentObject(DataManager())
}
