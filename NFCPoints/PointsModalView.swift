import SwiftUI

struct PointsModalView: View {
    @EnvironmentObject var dataManager: DataManager
    let team: Team
    @Binding var isPresented: Bool
    @State private var pointsAmount = 10
    @State private var actionType: String = "add"
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.blue.opacity(0.05),
                        Color.purple.opacity(0.05)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    // Team Info Card
                    VStack(spacing: 12) {
                        Text(team.name)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("\(team.points) Points")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(ColorOption(rawValue: team.color)?.uiColor ?? .blue)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(20)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    
                    // Action Selection
                    Picker("Action", selection: $actionType) {
                        Text("Add Points").tag("add")
                        Text("Subtract Points").tag("subtract")
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    
                    // Points Amount Slider
                    VStack(spacing: 12) {
                        HStack {
                            Text("Points Amount")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text("\(pointsAmount)")
                                .font(.headline)
                                .foregroundColor(actionType == "add" ? .green : .red)
                        }
                        
                        Slider(value: Binding(
                            get: { Double(pointsAmount) },
                            set: { pointsAmount = Int($0) }
                        ), in: 1...100, step: 1)
                        
                        HStack(spacing: 8) {
                            ForEach([5, 10, 25, 50], id: \.self) { amount in
                                Button(action: { pointsAmount = amount }) {
                                    Text("\(amount)")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .frame(maxWidth: .infinity)
                                        .padding(8)
                                        .background(pointsAmount == amount ? Color.blue : Color.gray.opacity(0.2))
                                        .foregroundColor(pointsAmount == amount ? .white : .primary)
                                        .cornerRadius(6)
                                }
                            }
                        }
                    }
                    .padding(16)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    
                    Spacer()
                    
                    // Action Buttons
                    VStack(spacing: 8) {
                        Button(action: performAction) {
                            HStack(spacing: 8) {
                                Image(systemName: actionType == "add" ? "plus.circle.fill" : "minus.circle.fill")
                                Text(actionType == "add" ? "Add Points" : "Subtract Points")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .foregroundColor(.white)
                            .background(actionType == "add" ? Color.green : Color.red)
                            .cornerRadius(10)
                        }
                        
                        Button("Close") {
                            isPresented = false
                        }
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .foregroundColor(.blue)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                    }
                )
                .padding(16)
                }
            }
            .navigationTitle("Adjust Points")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func performAction() {
        if actionType == "add" {
            dataManager.addPoints(to: team.id, amount: pointsAmount)
        } else {
            dataManager.subtractPoints(from: team.id, amount: pointsAmount)
        }
        isPresented = false
    }
}

#Preview {
    PointsModalView(team: Team(name: "Team A"), isPresented: .constant(true))
        .environmentObject(DataManager())
}
