# XpressBites - Food Takeaway App Features

## Overview
XpressBites is a complete food delivery and takeaway application designed specifically for college students. This document outlines the key features and their implementation.

## User Flow
```
1. Splash Screen
2. Welcome/Onboarding
3. Authentication (Login/Register with OTP)
4. Location Selection
5. Home Screen (Restaurant/Shop List)
6. Shop Screen (Food Items)
7. Cart
8. Payment Gateway
9. Order Tracking
10. Past Orders
```

## Features

### 1. Authentication System
- **Login with OTP**: Secure phone number verification
- **Registration**: New user signup with OTP verification
- **Session Management**: Persistent login using SharedPreferences
- **Location**: Location selection for personalized shop listings

### 2. Home Screen
- **Shop Listings**: Browse available restaurants/shops
- **Trending Shops**: Featured popular shops
- **Search & Filter**: Find specific shops or food items
- **Favorites**: Save favorite shops for quick access
- **Refresh**: Pull-to-refresh for updated shop list

### 3. Shop & Food Items
- **Shop Details**: Restaurant information, ratings, preparation time
- **Menu Categories**: Browse food items by category
- **Food Details**: Name, price, image, description
- **Add to Cart**: Quick add with quantity selection
- **Favorites**: Mark favorite food items

### 4. Cart Management
- **Item List**: View all cart items with quantity
- **Quantity Control**: Increase/decrease item quantities
- **Price Breakdown**: Subtotal, delivery fee, tax, discounts
- **Coupon System**: Apply discount coupons (SAVE10, FIRSTORDER)
- **Delivery Address**: Select from saved addresses or add new
- **Clear Cart**: Remove all items at once

### 5. Payment Gateway (NEW)
- **Razorpay Integration**: Secure online payment processing
- **Multiple Payment Methods**:
  - Online Payment (Card, UPI, Net Banking, Wallets)
  - Cash on Delivery (COD)
- **Payment Verification**: Automatic payment status verification
- **Order Summary**: Final review before payment

#### Configuration
Update Razorpay key in `lib/Services/Payment/RazorpayService.dart`:
```dart
'key': 'YOUR_RAZORPAY_KEY_HERE'
```

### 6. Order Tracking (NEW)
- **Real-time Status Updates**: Track order through 5 stages
  1. Order Placed
  2. Confirmed by Restaurant
  3. Preparing Food
  4. Ready for Pickup
  5. Completed
- **Visual Progress Indicator**: Easy-to-understand status display
- **Order Details**: Complete order information
- **Estimated Time**: Pickup/delivery time estimation
- **Support Options**: Help and contact support

#### Testing Features
- **Auto-progression**: Orders automatically advance through stages (every 30 seconds)
- **Manual Advance**: Test button to skip to next status
- **Simulation Service**: Located in `lib/Services/Order/OrderSimulationService.dart`

### 7. Notifications (NEW)
- **Push Notifications**: Local notifications for order updates
- **Notification Badge**: Count display on app bar
- **Notification Center**: View all notifications
- **Status Alerts**: Automatic alerts at each order stage
  - Order Placed 🎉
  - Order Confirmed ✅
  - Preparing Your Food 👨‍🍳
  - Order Ready 🎊
  - Order Completed 🌟

#### Configuration
Notifications are automatically initialized on app start. No additional configuration needed for local notifications.

For Firebase Cloud Messaging (FCM), add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files.

### 8. Past Orders (NEW)
- **Order History**: View all previous orders
- **Active Orders**: Quick access to ongoing orders
- **Order Details**: Complete order information
- **Track Order**: Navigate to tracking screen
- **Order Status**: Visual status indicators

### 9. Favorites
- **Favorite Shops**: Save preferred restaurants
- **Favorite Foods**: Mark favorite food items
- **Quick Access**: Easy navigation to favorites

## Technical Architecture

### State Management
- **GetX**: Reactive state management
- **Controllers**:
  - `CartController`: Cart operations
  - `OrderController`: Order management
  - `FavoriteController`: Favorites management
  - `BottomNavController`: Navigation

### Services
- **Payment**: `RazorpayService` - Razorpay integration
- **Notifications**: `NotificationService` - Local notifications
- **Order Simulation**: `OrderSimulationService` - Testing helper
- **API Services**: HTTP requests to backend

### Models
- **Order**: Complete order data structure
- **OrderItem**: Individual order item
- **OrderStatus**: Enum for order stages
- **Shop**: Restaurant/shop information
- **FoodItem**: Food item details

### UI Components
- **Custom Widgets**: Reusable UI components
- **Material Design**: Following Flutter Material guidelines
- **Google Fonts**: Poppins font family
- **Custom Colors**: Brand color scheme (#C2262D primary)

## API Integration

Backend API endpoints are configured in `lib/Constants/app_urls.dart`:
- Base URL configuration
- Auth endpoints
- Shop endpoints
- Food endpoints
- Cart endpoints
- Order endpoints (NEW)
- Payment endpoints (NEW)

## Dependencies

### Core
- `flutter`: SDK
- `get`: State management
- `http`: API calls

### Payment
- `razorpay_flutter`: Payment gateway

### Notifications
- `firebase_core`: Firebase initialization
- `firebase_messaging`: Push notifications
- `flutter_local_notifications`: Local notifications

### UI/UX
- `google_fonts`: Custom fonts
- `font_awesome_flutter`: Icons
- `cached_network_image`: Image caching
- `shimmer`: Loading effects

### Utilities
- `intl`: Date formatting
- `shared_preferences`: Local storage
- `path_provider`: File paths
- `url_launcher`: External links

## Testing the App

### Order Flow Testing
1. Add items to cart
2. Apply coupon (use: SAVE10 or FIRSTORDER)
3. Select delivery address
4. Choose payment method
5. Complete payment
6. Watch order progress automatically
7. Use "Advance Status" button for quick testing

### Notification Testing
- Place an order to receive "Order Placed" notification
- Wait 30 seconds or use "Advance Status" for next notification
- Check notification badge on home screen
- Open notifications screen to view history

### Payment Testing
**Razorpay Test Mode:**
- Use test card: 4111 1111 1111 1111
- Any future date for expiry
- Any CVV
- Or use COD for quick testing

## Production Deployment

### Before Production
1. **Replace Razorpay Test Key** with production key
2. **Remove Simulation Service** or disable auto-progression
3. **Implement Real-time Updates** via WebSocket or polling
4. **Configure Firebase** for push notifications
5. **Update API URLs** to production backend
6. **Add Error Tracking** (Sentry, Firebase Crashlytics)
7. **Optimize Images** and assets
8. **Enable Proguard** for Android release builds

### Environment Setup
Create environment configuration for dev/staging/production:
```dart
// lib/config/environment.dart
class Environment {
  static const String apiUrl = String.fromEnvironment('API_URL');
  static const String razorpayKey = String.fromEnvironment('RAZORPAY_KEY');
}
```

## Support & Maintenance

### Common Issues
1. **Notifications not showing**: Check app permissions
2. **Payment fails**: Verify Razorpay key and internet connection
3. **Order not tracking**: Ensure OrderController is initialized

### Future Enhancements
- Real-time order tracking with WebSocket
- Order cancellation feature
- Rating and review system
- Loyalty points and rewards
- Multiple delivery addresses
- Schedule orders for later
- Group orders feature
- In-app chat support

## Contact
For issues or questions, please contact the development team.
