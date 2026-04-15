# NFCPoints - Complete User Guide

## Welcome to NFCPoints! 👋

NFCPoints is your personal team scoring app powered by NFC technology. Create teams, scan their unique NFC cards, and instantly manage points!

---

## Table of Contents
1. [Getting Started](#getting-started)
2. [Creating Teams](#creating-teams)
3. [Scanning NFC Cards](#scanning-nfc-cards)
4. [Managing Points](#managing-points)
5. [Settings & Customization](#settings--customization)
6. [Tips & Tricks](#tips--tricks)
7. [Troubleshooting](#troubleshooting)

---

## Getting Started

### First Launch

When you first open NFCPoints:

1. **Grant NFC Permission**
   - Tap "Allow" when prompted
   - This gives the app permission to scan cards
   - You can change this in Settings → Privacy → NFC

2. **Create Your First Team**
   - Go to the **Teams** tab
   - Tap **"Add Team"**
   - Enter a team name (e.g., "Red Team")
   - Choose a color
   - Tap **"Create Team"**

3. **Start Scanning**
   - Go to the **Scan** tab
   - Select your team
   - Tap **"Scan Card"**
   - Hold an NFC card to the top of your iPhone

---

## Creating Teams

### Add a New Team

**Step-by-Step:**
1. Navigate to **Teams** tab (bottom navigation)
2. Tap **"Add Team"** button (blue button at bottom)
3. Enter the team name in the text field
4. Select a color by tapping a circle:
   - 🔴 Red
   - 🔵 Blue
   - 🟢 Green
   - 🟡 Yellow
   - 🟣 Purple
   - 🟠 Orange
   - 🌸 Pink
   - 🔷 Teal
5. Tap **"Create Team"** button
6. Your team now appears in the Teams list!

### Edit a Team

1. Go to **Teams** tab
2. Tap on a team card
3. Choose an action:
   - **Edit**: Modify team details (coming soon)
   - **Reset Points**: Set points back to 0
   - **Delete Team**: Permanently remove team

---

## Scanning NFC Cards

### What is NFC?

**NFC** (Near Field Communication) is wireless technology that works at very short distances. It's used in:
- Apple Pay contactless payments
- Access cards
- Team badges
- Event tickets
- Custom NFC stickers/cards

### How to Scan

**Before Scanning:**
1. Get an NFC card or tag
2. Ensure your iPhone has NFC (iPhone XS or newer)
3. Open NFCPoints
4. Go to **Scan** tab
5. Select a team

**Scanning Process:**
1. Tap **"Scan Card"** button
2. App shows: "Hold your NFC card to the top of your iPhone"
3. Bring card to the **top edge** of your device
   - Specifically the upper area near the camera/speaker
4. **Hold still** for 1-2 seconds
5. App vibrates and shows green checkmark ✅
6. Points are automatically added!

### First Time Scanning a Card

When you scan a **new card** for the first time:
1. Not yet assigned to any team
2. App automatically assigns it to your selected team
3. Default points are added
4. Message shows: "Card assigned and [points] added!"

### Scanning an Already-Assigned Card

When you scan a **previously scanned card**:
1. App detects it's assigned to your team
2. Points are added to that team
3. Message shows: "Added [points] to [Team Name]!"

### Tips for Successful Scanning

✅ **Do:**
- Hold card at the **top edge** of phone
- Keep card **still** during scan
- Hold for **1-2 seconds**
- Use phone in **portrait orientation**
- Ensure card is **flat against phone**

❌ **Don't:**
- Tap screen while scanning
- Move card around
- Pull card away too soon
- Use phone in landscape
- Tilt card at angles

---

## Managing Points

### Quick Point Adjustment

**From Team List:**
1. Go to **Teams** tab
2. Find your team
3. Use quick action buttons:
   - 🟢 **Add**: Quick add default points
   - 🔴 **Subtract**: Quick subtract default points

### Detailed Point Adjustment

**Change Points Manually:**
1. Go to **Teams** tab
2. Tap the team card (long press or tap)
3. Select **"Edit Points"**
4. Choose action:
   - ➕ **Add Points**
   - ➖ **Subtract Points**
5. Use the slider to select amount (1-100)
6. Or tap quick buttons: 5, 10, 25, 50
7. Tap **"Add Points"** or **"Subtract Points"**

### View Current Points

**Current Team Points:**
- Visible on the team card in **Teams** tab
- Large number with team color
- Updates instantly when points change

**Total Statistics:**
- Go to **Settings** tab
- View team statistics:
  - Total teams
  - Total points across all teams
  - Leading team name

---

## Settings & Customization

### Change Default Points

The "Default Points per Scan" is the amount added/subtracted when scanning:

**To Adjust:**
1. Go to **Settings** tab
2. Find **"Point Settings"** section
3. Use the **+** and **-** buttons, OR
4. Drag the **slider** (1-100 points)
5. Setting saves automatically

**Examples:**
- **5 points**: Good for frequent scanning
- **10 points**: Default, balanced option
- **25 points**: For major achievements
- **50 points**: For significant milestones

### View Team Statistics

**Statistics Available:**
- **Total Teams**: Count of all teams
- **Total Points**: Sum of all points
- **Leading Team**: Team with most points

**Access:**
- Go to **Settings** tab
- View under "Team Statistics" section

### App Information

**About Section Shows:**
- App version (v1.0)
- Feature list
- Requirements:
  - iOS 15.0 or later
  - NFC support required

---

## Tips & Tricks

### Organization Tips

📋 **Color Coding**
- Use different colors for different purposes
- Red = Important, Blue = Regular, etc.
- Easy visual identification

👥 **Multiple Competitions**
- Create teams for different events
- Example: "Beach Volleyball", "Office Competition"
- Run parallel competitions

### Scanning Efficiency

⚡ **Speed Up Scanning**
- Pre-select team before scanning
- Have cards ready
- Scan multiple cards quickly in sequence

🔄 **Card Reuse**
- Once assigned, scan same card multiple times
- Points accumulate with each scan
- No need to reassign

### Point Strategy

🎯 **Flexible Points**
- Adjust points based on difficulty
- Use slider for custom amounts
- Match points to achievement difficulty

### Data Management

💾 **Automatic Saving**
- All data saves automatically
- No manual save button needed
- Even works if app crashes

---

## Troubleshooting

### NFC Not Working

**Issue**: "Scanning..." never completes

**Solution:**
1. Ensure you're holding card at **top edge**
2. Card should be **flat against phone**
3. Hold for at least **1-2 seconds**
4. Try a different location on top edge
5. Verify card is **NFC-enabled**
6. Restart the app

**If Still Not Working:**
- Go to Settings → Privacy → NFC
- Ensure NFCPoints has Allow permission
- Add NFC capability in Xcode again
- Rebuild and reinstall app

### Points Not Adding

**Issue**: Scanned card but points didn't increase

**Solution:**
1. Check team is selected (should show in blue)
2. Verify successful scan (should see checkmark)
3. Check team still exists (not deleted)
4. Try adding points manually from Teams tab

### Card Assignment Issues

**Issue**: Card assigned to wrong team

**Solution:**
- Currently: Delete team and Create new one
- New card will assign to new team on first scan

### App Crashes on Launch

**Solution:**
1. Force close app (swipe up from bottom)
2. Reopen app
3. If persists:
   - Delete app
   - Reinstall from Xcode
   - Provide NFC permission when prompted

### Permission Issues

**Issue**: "NFC access denied"

**Solution:**
1. Open device Settings
2. Go to Privacy → NFC
3. Find NFCPoints
4. Toggle "ON"
5. Return to app and try again

---

## Best Practices

### Before an Event

1. ✅ Create all teams
2. ✅ Assign colors strategically
3. ✅ Set appropriate point values
4. ✅ Prepare NFC cards for each team
5. ✅ Test scanning with one card

### During Scoring

1. 📱 Keep phone charged
2. 🔋 Enable Low Power Mode if needed (scanning still works)
3. 🎯 Scan quickly and efficiently
4. 📊 Check statistics between rounds

### After Event

1. 💾 Backup data (screenshot statistics)
2. 🏆 Note winning team
3. 🔄 Reset points for next event
4. 📝 Keep team setup for re-using

---

## Features Summary

✨ **Core Features**
- ✅ Create multiple teams
- ✅ Assign unique NFC cards
- ✅ Automatic point addition
- ✅ Manual point adjustment
- ✅ Custom point amounts
- ✅ Team statistics
- ✅ Color-coded teams
- ✅ Data persistence

🎨 **Visual Design**
- ✅ Modern gradient UI
- ✅ Smooth animations
- ✅ Color-coded feedback
- ✅ Large, readable text
- ✅ Intuitive navigation

🔒 **Data Safety**
- ✅ Automatic saving
- ✅ No cloud required
- ✅ Local device storage
- ✅ Data persists between sessions
- ✅ Can manually reset teams

---

## Getting Help

### Common Questions

**Q: Can I use the app without NFC?**
A: No, NFC is required for scanning. But you can manually adjust points in Teams tab.

**Q: How many teams can I create?**
A: Unlimited! Create as many as you need.

**Q: Can I undo a point change?**
A: Currently no, but you can manually adjust using the slider.

**Q: Does it need internet?**
A: No, everything is local on your device.

**Q: Can I export the data?**
A: Not yet, but you can screenshot the statistics page.

### Support Resources

- 📖 Read this guide again
- 🔧 Check Settings page
- 🍎 Apple's NFC Documentation
- 🤝 Contact via App Store reviews

---

## Version Information

- **Current Version**: 1.0
- **Last Updated**: April 2026
- **Compatible**: iOS 15.0+
- **Requires**: NFC-capable device

---

## Quick Reference

| Action | Location | Steps |
|--------|----------|-------|
| Add Team | Teams tab → Add Team button | Name + Color + Create |
| Scan Card | Scan tab → Select team → Scan Card | Hold NFC to phone top |
| Edit Points | Teams tab → Team card → Action | Choose +/- and amount |
| Change Default Points | Settings → Point Settings | Adjust slider |
| View Statistics | Settings → Team Statistics | Automatic display |
| Reset Team | Teams tab → Team → Reset Points | Confirms reset to 0 |
| Delete Team | Teams tab → Team → Delete Team | Confirms deletion |

---

**Have fun scoring! 🎉**
