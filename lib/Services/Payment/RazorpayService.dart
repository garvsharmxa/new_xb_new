import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:get/get.dart';

class RazorpayService {
  late Razorpay _razorpay;
  Function(String)? onPaymentSuccess;
  Function(String)? onPaymentError;
  Function()? onPaymentWallet;

  RazorpayService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Payment Success: ${response.paymentId}');
    if (onPaymentSuccess != null) {
      onPaymentSuccess!(response.paymentId ?? '');
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Payment Error: ${response.code} - ${response.message}');
    if (onPaymentError != null) {
      onPaymentError!(response.message ?? 'Payment failed');
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External Wallet: ${response.walletName}');
    if (onPaymentWallet != null) {
      onPaymentWallet!();
    }
  }

  Future<void> openCheckout({
    required double amount,
    required String orderId,
    required String name,
    required String email,
    required String contact,
    String description = 'Food Order Payment',
    Function(String)? onSuccess,
    Function(String)? onError,
    Function()? onWallet,
  }) async {
    onPaymentSuccess = onSuccess;
    onPaymentError = onError;
    onPaymentWallet = onWallet;

    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag', // Replace with your Razorpay key
      'amount': (amount * 100).toInt(), // Amount in paise
      'name': 'XpressBites',
      'order_id': orderId,
      'description': description,
      'timeout': 300, // 5 minutes
      'prefill': {
        'contact': contact,
        'email': email,
        'name': name,
      },
      'theme': {
        'color': '#C2262D',
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error opening Razorpay: $e');
      if (onError != null) {
        onError('Failed to open payment gateway');
      }
    }
  }

  void dispose() {
    _razorpay.clear();
  }
}
