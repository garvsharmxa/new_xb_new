# Setup Guide - XpressBites Food Takeaway App

This guide will help you set up and run the XpressBites food delivery app.

## Prerequisites

- Flutter SDK 3.8.1 or higher
- Dart SDK 3.0 or higher
- Android Studio / VS Code with Flutter extensions
- Android device/emulator or iOS device/simulator
- Razorpay account (for payment testing)

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/garvsharmxa/new_xb_new.git
cd new_xb_new
```

### 2. Install Dependencies

```bash
flutter pub get
```

If you encounter any issues, try:
```bash
flutter clean
flutter pub get
```

### 3. Configure Razorpay (Required for Payments)

1. Sign up at [Razorpay](https://razorpay.com/)
2. Get your API Key from Dashboard → Settings → API Keys
3. Open `lib/Services/Payment/RazorpayService.dart`
4. Replace the test key:

```dart
var options = {
  'key': 'rzp_test_YOUR_KEY_HERE', // Replace with your key
  // ... rest of options
};
```

**Test Mode Keys:**
- Use test keys (starting with `rzp_test_`) for development
- Use live keys (starting with `rzp_live_`) for production

### 4. Configure Backend API (Required)

1. Open `lib/Constants/app_urls.dart`
2. Update the base URL:

```dart
static const String baseUrl = 'https://your-api-url.com/api';
```

If you don't have a backend yet:
- The app uses mock/local data for most features
- Payment and order creation require a backend API
- You can test the UI flow with the simulation service

### 5. Firebase Configuration (Optional - for Push Notifications)

#### For Android:
1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Add an Android app to your Firebase project
3. Download `google-services.json`
4. Place it in `android/app/`

#### For iOS:
1. Add an iOS app to your Firebase project
2. Download `GoogleService-Info.plist`
3. Place it in `ios/Runner/`

#### Update Dependencies (if needed):
```yaml
# pubspec.yaml - already added
dependencies:
  firebase_core: ^2.24.2
  firebase_messaging: ^14.7.9
```

**Note:** Local notifications work without Firebase. FCM is only needed for remote push notifications.

### 6. Run the App

#### On Android:
```bash
flutter run
```

#### On iOS:
```bash
cd ios
pod install
cd ..
flutter run
```

#### On specific device:
```bash
flutter devices  # List available devices
flutter run -d <device_id>
```

## Testing the App

### 1. Test Authentication
- Use any phone number (format: 10 digits)
- OTP verification depends on your backend
- For testing, you might want to mock the OTP flow

### 2. Test Payment

#### Razorpay Test Credentials:
- **Card Number:** 4111 1111 1111 1111
- **Expiry:** Any future date (e.g., 12/25)
- **CVV:** Any 3 digits (e.g., 123)
- **Name:** Any name

#### Test Coupons:
- `SAVE10` → ₹50 discount
- `FIRSTORDER` → ₹100 discount

#### Cash on Delivery:
- Select COD option in payment screen
- No payment gateway required

### 3. Test Order Tracking
- After placing an order, you'll be redirected to tracking screen
- Order status automatically advances every 30 seconds (testing mode)
- Use "Advance Status (Test)" button to skip to next status immediately
- Notifications appear at each status change

### 4. Test Notifications
- Grant notification permissions when prompted
- Place an order to trigger notifications
- Check notification badge on home screen
- Open notifications screen from app bar icon

## Troubleshooting

### Issue: Dependencies not installing
**Solution:**
```bash
flutter clean
flutter pub cache repair
flutter pub get
```

### Issue: Razorpay not opening
**Solution:**
- Check internet connection
- Verify Razorpay key is correct
- Check app permissions
- Try on a real device (some features don't work on emulator)

### Issue: Notifications not showing
**Solution:**
- Check notification permissions in device settings
- For Android: Ensure channel is created
- Restart the app after granting permissions

### Issue: Build fails on Android
**Solution:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Issue: Build fails on iOS
**Solution:**
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter pub get
flutter run
```

### Issue: API calls failing
**Solution:**
- Verify backend URL in `app_urls.dart`
- Check network connectivity
- Verify API endpoints are accessible
- Check backend CORS settings

## Development Tips

### Hot Reload
Press `r` in terminal while app is running to hot reload changes.

### Hot Restart
Press `R` in terminal to hot restart the app.

### Debug Mode
The app runs in debug mode by default. For release build:
```bash
flutter build apk --release  # Android
flutter build ios --release  # iOS
```

### Viewing Logs
```bash
flutter logs
```

Or use Android Studio / VS Code debug console.

## Project Structure Overview

```
lib/
├── main.dart                    # App entry point
├── Constants/
│   └── app_urls.dart           # API endpoints
├── Controller/
│   ├── CartController.dart     # Cart state
│   ├── OrderController.dart    # Order state
│   └── ...                     # Other controllers
├── Features/
│   ├── Auth/                   # Login/Register
│   ├── Cart/                   # Cart screen
│   ├── Payment/                # Payment screen
│   ├── OrderTracking/          # Order tracking
│   └── ...                     # Other features
├── Services/
│   ├── Payment/
│   │   └── RazorpayService.dart    # Payment integration
│   ├── Notification/
│   │   └── NotificationService.dart # Notifications
│   └── Order/
│       └── OrderSimulationService.dart # Testing helper
└── models/
    └── Order/
        └── OrderModel.dart     # Order data structure
```

## Environment-Specific Configuration

### Development
- Use test API keys
- Enable simulation service
- Use test Razorpay keys
- Mock data for testing

### Staging
- Use staging API
- Real payment testing
- Limited simulations
- Beta testing

### Production
- Production API keys
- Live Razorpay keys
- Disable simulation service
- Enable analytics
- Enable crash reporting

## Next Steps

1. ✅ Complete setup following this guide
2. ✅ Test all features using test data
3. ✅ Configure your backend API
4. ✅ Set up Firebase (optional)
5. ✅ Add your branding/logo
6. ✅ Test on real devices
7. ✅ Build release version
8. ✅ Submit to app stores

## Support

If you encounter any issues:
1. Check this guide first
2. Review [FEATURES.md](FEATURES.md) for feature documentation
3. Check Flutter documentation
4. Open an issue on GitHub

## Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [GetX Documentation](https://pub.dev/packages/get)
- [Razorpay Documentation](https://razorpay.com/docs/)
- [Firebase Documentation](https://firebase.google.com/docs)

---

**Happy Coding! 🚀**
