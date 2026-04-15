import SwiftUI

struct RedemptionView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var selectedTeam: Team?
    @State private var showTeamSelection = false
    @State private var selectedGift: Gift?
    @State private var showRedemptionSheet = false
    @State private var redemptionMessage = ""
    @State private var messageColor = Color.blue
    
    var availableGifts: [Gift] {
        dataManager.gifts.filter { $0.quantity > 0 }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.pink.opacity(0.1),
                        Color.purple.opacity(0.1)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    VStack(spacing: 8) {
                        Text("Redeem Gifts")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.primary)
                        
                        Text("Spend your team's points")
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
                                            Text("Your Team")
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
                                            
                                            HStack(spacing: 4) {
                                                Image(systemName: "star.fill")
                                                    .foregroundColor(.orange)
                                                
                                                Text("\(team.points)")
                                                    .font(.system(size: 24, weight: .bold))
                                                    .foregroundColor(ColorOption(rawValue: team.color)?.uiColor ?? .blue)
                                            }
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
                                .shadow(color: ColorOption(rawValue: team.color)?.uiColor.opacity(0.3) ?? .blue.opacity(0.3), radius: 4)
                            } else {
                                Button(action: { showTeamSelection = true }) {
                                    VStack(spacing: 8) {
                                        Image(systemName: "person.fill.viewfinder")
                                            .font(.system(size: 40))
                                            .foregroundColor(.pink)
                                        
                                        Text("Select Your Team")
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        
                                        Text("Choose your team to redeem gifts")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(20)
                                    .background(Color(.systemBackground))
                                    .cornerRadius(12)
                                }
                            }
                            
                            // Status Message
                            if !redemptionMessage.isEmpty {
                                HStack(spacing: 12) {
                                    Image(systemName: messageColor == .green ? "checkmark.circle.fill" : "exclamationmark.circle.fill")
                                        .foregroundColor(messageColor)
                                    
                                    Text(redemptionMessage)
                                        .font(.subheadline)
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                }
                                .padding(12)
                                .background(messageColor.opacity(0.1))
                                .cornerRadius(8)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                            }
                            
                            // Gifts Grid
                            if availableGifts.isEmpty {
                                VStack(spacing: 12) {
                                    Image(systemName: "gift")
                                        .font(.system(size: 40))
                                        .foregroundColor(.gray)
                                    
                                    Text("No Gifts Available")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(32)
                            } else {
                                VStack(spacing: 12) {
                                    ForEach(availableGifts) { gift in
                                        GiftRedemptionCardView(gift: gift, team: selectedTeam)
                                            .onTapGesture {
                                                selectedGift = gift
                                                showRedemptionSheet = true
                                            }
                                    }
                                }
                            }
                        }
                        .padding(16)
                    }
                }
            }
            .actionSheet(isPresented: $showTeamSelection) {
                ActionSheet(
                    title: Text("Select Your Team"),
                    message: Text("Choose your team to view and redeem gifts"),
                    buttons: dataManager.teams.map { team in
                        .default(Text(team.name)) {
                            selectedTeam = team
                        }
                    } + [.cancel()]
                )
            }
            .sheet(isPresented: $showRedemptionSheet) {
                if let gift = selectedGift, let team = selectedTeam {
                    RedemptionConfirmationView(
                        team: team,
                        gift: gift,
                        isPresented: $showRedemptionSheet,
                        onRedeem: { success in
                            if success {
                                redemptionMessage = "Congratulations! 🎉 You redeemed \(gift.name)!"
                                messageColor = .green
                            } else {
                                redemptionMessage = "Not enough points to redeem this gift"
                                messageColor = .red
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                withAnimation {
                                    redemptionMessage = ""
                                }
                            }
                        }
                    )
                    .environmentObject(dataManager)
                }
            }
        }
    }
}

struct GiftRedemptionCardView: View {
    let gift: Gift
    let team: Team?
    
    var canAfford: Bool {
        guard let team = team else { return false }
        return team.points >= gift.pointsCost
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                Text(gift.emoji)
                    .font(.system(size: 40))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(gift.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(gift.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                    
                    HStack(spacing: 8) {
                        Label("\(gift.quantity) left", systemImage: "number")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 8) {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.title3)
                            .foregroundColor(.orange)
                        
                        Text("\(gift.pointsCost)")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    
                    Text(canAfford ? "Affordable" : "Not enough points")
                        .font(.caption2)
                        .foregroundColor(canAfford ? .green : .red)
                }
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .opacity(canAfford ? 1.0 : 0.6)
        .shadow(radius: 2)
    }
}

struct RedemptionConfirmationView: View {
    @EnvironmentObject var dataManager: DataManager
    let team: Team
    let gift: Gift
    @Binding var isPresented: Bool
    let onRedeem: (Bool) -> Void
    
    var canRedeem: Bool {
        team.points >= gift.pointsCost
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.pink.opacity(0.05),
                        Color.purple.opacity(0.05)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Gift Preview
                    VStack(spacing: 16) {
                        Text(gift.emoji)
                            .font(.system(size: 60))
                        
                        VStack(spacing: 8) {
                            Text(gift.name)
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text(gift.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(24)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    
                    // Details
                    VStack(spacing: 12) {
                        HStack {
                            Text("Gift Cost")
                                .font(.subheadline)
                            Spacer()
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.orange)
                                Text("\(gift.pointsCost) points")
                                    .fontWeight(.semibold)
                            }
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Your Points")
                                .font(.subheadline)
                            Spacer()
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.blue)
                                Text("\(team.points) points")
                                    .fontWeight(.semibold)
                            }
                        }
                        
                        if canRedeem {
                            Divider()
                            
                            HStack {
                                Text("Points After")
                                    .font(.subheadline)
                                Spacer()
                                HStack(spacing: 4) {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.green)
                                    Text("\(team.points - gift.pointsCost) points")
                                        .fontWeight(.semibold)
                                }
                            }
                        }
                    }
                    .padding(16)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    
                    if !canRedeem {
                        HStack(spacing: 8) {
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundColor(.red)
                            
                            Text("You don't have enough points for this gift")
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(12)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(8)
                    }
                    
                    Spacer()
                    
                    // Action Buttons
                    VStack(spacing: 12) {
                        if canRedeem {
                            Button(action: redeemGift) {
                                HStack(spacing: 8) {
                                    Image(systemName: "checkmark.circle.fill")
                                    Text("Redeem Gift")
                                        .fontWeight(.semibold)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(12)
                                .foregroundColor(.white)
                                .background(Color.green)
                                .cornerRadius(10)
                            }
                        }
                        
                        Button("Cancel") {
                            isPresented = false
                        }
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .foregroundColor(.blue)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .padding(16)
                }
            }
            .navigationTitle("Confirm Redemption")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func redeemGift() {
        let success = dataManager.redeemGift(teamId: team.id, giftId: gift.id)
        onRedeem(success)
        isPresented = false
    }
}

#Preview {
    RedemptionView()
        .environmentObject(DataManager())
}
