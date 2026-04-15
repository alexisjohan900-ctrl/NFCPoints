# NFCPoints Build Instructions

## Quick Start

### Prerequisites
- macOS 12 or later
- Xcode 13.0 or later
- Apple Developer Account
- iPhone/iPad with NFC support + iOS 15.0+

### Five-Minute Setup

1. **Download and Extract**
   ```bash
   # Navigate to project folder
   cd NFCPoints
   ```

2. **Open in Xcode**
   ```bash
   # Open the project
   open NFCPoints.xcodeproj
   ```

3. **Configure Signing**
   - Select Project → NFCPoints target
   - Go to "Signing & Capabilities"
   - Select your Developer Team
   - Update Bundle ID if needed

4. **Enable NFC**
   - Click "+ Capability"
   - Add "NFC Tag Reading"

5. **Run**
   - Connect iPhone/iPad
   - Select device in toolbar
   - Press Cmd+R or click Run button

---

## Detailed Build Process

### Step 1: Environment Setup

**Verify System Requirements:**
```bash
# Check macOS version (must be 12+)
sw_vers

# Check Xcode version (must be 13.0+)
xcode-select --version
xcodebuild -version
```

### Step 2: Project Configuration

1. **Open XCode Project**
   ```bash
   open NFCPoints.xcodeproj
   ```

2. **Configure Build Settings**
   - Project → NFCPoints → Build Settings
   - Verify Code Sign Identity is set

3. **Set Deployment Target**
   - Target → Build Settings
   - iOS Deployment Target: 15.0 or later

### Step 3: NFC Capability Setup

This is critical for NFC scanning:

1. Click on **NFCPoints** project in navigator
2. Select **NFCPoints** target
3. Go to **Signing & Capabilities** tab
4. Click **+ Capability** button
5. Search for "NFC Tag Reading"
6. Add the capability

The following will be added automatically:
- CoreNFC framework
- NFC entitlements in provisioning profile
- Required permissions in Info.plist

### Step 4: Code Signing Configuration

1. Still in **Signing & Capabilities**
2. Under **Signing**:
   - Select your Apple Developer Team
   - Team will appear after signing into Xcode

3. Verify bundle identifier is unique:
   - Format: `com.yourcompany.nfcpoints`
   - Or use default: `com.nfcpoints.app`

### Step 5: Device Preparation

**Connect Device:**
1. Connect iPhone/iPad via USB
2. Unlock device
3. Tap "Trust" when prompted
4. Wait for device to appear in Xcode

**If Device Doesn't Appear:**
- Disconnect and reconnect
- Try different USB port
- Restart Xcode
- Restart your device

### Step 6: Build and Run

**Via Xcode UI:**
1. Select device from top toolbar
2. Press **Cmd + R** or click Run button
3. Wait for build to complete

**Via Command Line:**
```bash
# Build for specific device
xcodebuild -scheme NFCPoints \
           -destination generic/platform=iOS \
           -configuration Debug

# Or using xcrun
xcrun xcodebuild -scheme NFCPoints \
                 -destination 'id=<device_id>'
```

### Step 7: Post-Install Steps

**First Launch:**
1. App will request NFC permission → Tap **Allow**
2. Create test team: Teams tab → Add Team
3. Test scanning: Scan tab → Scan Card

---

## Troubleshooting Build Issues

### Issue: "NFC Tag Reading not available"
**Solution:**
```
✅ Ensure Team is selected in Signing & Capabilities
✅ Check iOS deployment target is 15.0+
✅ Verify device supports NFC (iPhone XS+)
```

### Issue: "Code Sign Error"
**Solution:**
```
✅ Go to Xcode Preferences (Cmd+,)
✅ Select Accounts
✅ Click Manage Certificates
✅ Ensure development certs exist
✅ Add new certificate if needed
```

### Issue: "App crashes on launch"
**Solution:**
```
✅ Check Console for crash details (Cmd+Shift+Y)
✅ Verify all frameworks are linked
✅ Check Info.plist is valid
✅ Replace app with clean build
```

### Issue: "Device not showing in device list"
**Solution:**
```
✅ Trust app on device: Settings → General → Device Management
✅ Check device is unlocked
✅ Try different USB port
✅ Restart Mac and device
```

---

## Building for Different Configurations

### Development Build
```bash
xcodebuild -scheme NFCPoints \
           -configuration Debug \
           -destination generic/platform=iOS
```

### Release Build
```bash
xcodebuild -scheme NFCPoints \
           -configuration Release \
           -destination generic/platform=iOS
```

### Archive for Distribution
```bash
xcodebuild -scheme NFCPoints \
           -configuration Release \
           -archivePath ./build/NFCPoints.xcarchive \
           archive
```

---

## Testing the App

### Without Real NFC Tags
The app has built-in simulation:
1. Go to Scan tab
2. Select a team
3. Tap "Scan Card"
4. App simulates NFC scan (generates UUID)

### With Real NFC Tags
1. Get NFC-enabled cards or tags
2. Go to Scan tab
3. Select a team
4. Tap "Scan Card"
5. Hold tag to top of device
6. Hold still until scan completes

---

## Project Structure for Building

```
NFCPoints/
├── NFCPoints.xcodeproj/          # Xcode project file
│   ├── project.pbxproj           # Build configuration
│   └── xcshareddata/             # Shared settings
│
├── NFCPoints/                     # Source code
│   ├── *.swift files            # All app source files
│   ├── Info.plist               # App configuration
│   └── Preview Content/         # SwiftUI previews
│
├── build/                        # Build output (generated)
├── .xcode.env                    # Xcode environment vars
└── Documentation/                # Guides
    ├── README.md
    ├── XCODE_SETUP.md
    └── BUILD.md (this file)
```

---

## Advanced Build Options

### Build with Verbose Output
```bash
xcodebuild -verbose -scheme NFCPoints \
           -destination generic/platform=iOS
```

### Clean Build
```bash
xcodebuild clean -scheme NFCPoints -configuration Debug
xcodebuild -scheme NFCPoints
```

### Show Build Dependencies
```bash
xcodebuild -scheme NFCPoints \
           -showBuildSettings \
           -destination generic/platform=iOS
```

---

## Performance Tips

### Fast Iteration
- Use same device for testing
- Avoid full device rebuilds when possible
- Use Live Preview for UI changes
- Rebuild only when necessary (Cmd+R)

### Optimized Debug Builds
- Disable code optimization for faster builds
- Build Settings → Optimization Level: None (-O0)
- Fast incremental compilation enabled by default

### Production Builds
- Enable optimization (Build Settings → Optimization: Fast (-O2))
- Enable code stripping
- Test thoroughly before release

---

## After Successful Build

Once app is running:

1. **Verify Core Features**
   - [ ] Can create teams
   - [ ] Can scan NFC (or simulate)
   - [ ] Points update correctly
   - [ ] Data persists after close

2. **Test All Views**
   - [ ] Scan tab works
   - [ ] Team list displays correctly
   - [ ] Settings page loads
   - [ ] All buttons functional

3. **Verify Permissions**
   - [ ] NFC permission requested
   - [ ] App runs after permission granted
   - [ ] Graceful handling if permission denied

---

## Common Commands Reference

```bash
# Clean everything
xcodebuild clean

# Build only
xcodebuild build -scheme NFCPoints

# Build and run on connected device
xcodebuild build-for-testing -scheme NFCPoints

# Show available schemes
xcodebuild -list

# Show build settings
xcodebuild -scheme NFCPoints -showBuildSettings

# Build for iOS simulator (if possible - NFC not supported)
xcodebuild -scheme NFCPoints -destination 'platform=iOS Simulator'
```

---

## Version Information

- **Xcode**: 13.0 or later
- **Swift**: 5.5 or later
- **iOS**: 15.0 or later
- **Deployment Target**: iOS 15.0+
- **macOS**: 12 (Monterey) or later

---

## Support & Documentation

- Apple CoreNFC: https://developer.apple.com/documentation/corenfc
- SwiftUI: https://developer.apple.com/tutorials/swiftui
- Xcode Help: Xcode Menu → Help → Xcode Help

---

**Last Updated**: April 2026  
**Status**: Production Ready
