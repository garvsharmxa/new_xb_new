# XpressBites - Food Takeaway App

A complete food delivery and takeaway Flutter application designed for college students, inspired by [xpressbites.store](https://xpressbites.store/).

## Features

✅ **User Authentication** - Secure OTP-based login/registration  
✅ **Location-based Shops** - Browse restaurants by location  
✅ **Shop & Menu Browsing** - View shops and their food items  
✅ **Smart Cart** - Add items, apply coupons, manage quantities  
✅ **Payment Gateway** - Razorpay integration + Cash on Delivery  
✅ **Order Tracking** - Real-time visual order status tracking  
✅ **Push Notifications** - Order updates via notifications  
✅ **Order History** - View active and past orders  
✅ **Favorites** - Save favorite shops and items  

## Tech Stack

- **Framework**: Flutter 3.8+
- **State Management**: GetX
- **Payment**: Razorpay
- **Notifications**: Firebase + Local Notifications
- **Backend API**: REST API (configured in app_urls.dart)

## Quick Start

1. **Clone the repository**
```bash
git clone https://github.com/garvsharmxa/new_xb_new.git
cd new_xb_new
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
flutter run
```

## Configuration

### Razorpay Setup
Update your Razorpay key in `lib/Services/Payment/RazorpayService.dart`:
```dart
'key': 'YOUR_RAZORPAY_KEY_HERE'
```

### Backend API
Configure API base URL in `lib/Constants/app_urls.dart`:
```dart
static const String baseUrl = 'YOUR_API_URL';
```

## User Flow

```
Auth → Location Selection → Home (Shops) → Shop Details (Food Items) → 
Cart → Payment → Order Tracking → Past Orders
```

## Testing

### Test Coupons
- `SAVE10` - ₹50 off
- `FIRSTORDER` - ₹100 off

### Razorpay Test Card
- Card: 4111 1111 1111 1111
- Expiry: Any future date
- CVV: Any 3 digits

### Order Simulation
Orders automatically progress through stages every 30 seconds for testing.
Use the "Advance Status" button on tracking screen for quick testing.

## Documentation

For detailed feature documentation, see [FEATURES.md](FEATURES.md)

## Project Structure

```
lib/
├── Controller/          # State management controllers
├── Features/           # UI screens and features
│   ├── Auth/          # Authentication screens
│   ├── Cart/          # Cart screen
│   ├── HomeScreen/    # Home and shop listings
│   ├── Payment/       # Payment screen
│   ├── OrderTracking/ # Order tracking screen
│   ├── Notifications/ # Notifications screen
│   └── PastOrder/     # Order history
├── Services/          # Business logic services
│   ├── Payment/       # Razorpay service
│   ├── Notification/  # Notification service
│   └── Order/         # Order simulation
├── models/            # Data models
├── Constants/         # App constants and URLs
└── main.dart         # App entry point
```

## Screenshots

[Add screenshots here]

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License.

## Support

For issues or questions, please open an issue on GitHub.
