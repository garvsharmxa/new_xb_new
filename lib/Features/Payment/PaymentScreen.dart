import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Services/Payment/RazorpayService.dart';
import '../../Services/Order/OrderSimulationService.dart';
import '../../Controller/OrderController.dart';
import '../../Controller/CartController.dart';
import '../../models/Order/OrderModel.dart';
import '../OrderTracking/OrderTrackingScreen.dart';

class PaymentScreen extends StatefulWidget {
  final double totalAmount;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double discount;
  final String deliveryAddress;

  const PaymentScreen({
    super.key,
    required this.totalAmount,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.discount,
    required this.deliveryAddress,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPaymentMethod = 'razorpay';
  final RazorpayService _razorpayService = RazorpayService();
  final cartController = Get.find<CartController>();
  final orderController = Get.put(OrderController());
  final orderSimulation = OrderSimulationService();
  bool isProcessing = false;

  @override
  void dispose() {
    _razorpayService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xff2D3748),
        title: Text(
          'Payment',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xff2D3748),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _buildOrderSummary(),
                  const SizedBox(height: 16),
                  _buildPaymentMethods(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          _buildPayButton(),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.receipt_outlined,
                color: Color(0xffC2262D),
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                'Order Summary',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff2D3748),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSummaryRow('Subtotal', '₹${widget.subtotal.toStringAsFixed(0)}'),
          _buildSummaryRow('Delivery Fee', '₹${widget.deliveryFee.toStringAsFixed(0)}'),
          _buildSummaryRow('Tax (18%)', '₹${widget.tax.toStringAsFixed(0)}'),
          if (widget.discount > 0)
            _buildSummaryRow(
              'Discount',
              '-₹${widget.discount.toStringAsFixed(0)}',
              isDiscount: true,
            ),
          const Divider(height: 24, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff2D3748),
                ),
              ),
              Text(
                '₹${widget.totalAmount.toStringAsFixed(0)}',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xffC2262D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String amount, {bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xff718096),
            ),
          ),
          Text(
            amount,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDiscount ? Colors.green : const Color(0xff2D3748),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.payment,
                color: Color(0xffC2262D),
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                'Payment Method',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff2D3748),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildPaymentOption(
            'razorpay',
            'Razorpay',
            'Card, UPI, Net Banking, Wallets',
            FontAwesomeIcons.creditCard,
          ),
          const SizedBox(height: 12),
          _buildPaymentOption(
            'cod',
            'Cash on Delivery',
            'Pay with cash when you receive',
            Icons.payments_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(
    String value,
    String title,
    String subtitle,
    IconData icon,
  ) {
    final isSelected = selectedPaymentMethod == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xffC2262D).withOpacity(0.1)
              : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xffC2262D) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xffC2262D)
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey.shade600,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff2D3748),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xff718096),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xffC2262D),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayButton() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: isProcessing ? null : _processPayment,
              child: Container(
                alignment: Alignment.center,
                color: isProcessing
                    ? const Color(0xffC2262D).withOpacity(0.5)
                    : const Color(0xffC2262D),
                child: isProcessing
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text(
                        'PAY ₹${widget.totalAmount.toStringAsFixed(0)}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _processPayment() {
    if (selectedPaymentMethod == 'razorpay') {
      _initiateRazorpayPayment();
    } else if (selectedPaymentMethod == 'cod') {
      _processCODOrder();
    }
  }

  void _initiateRazorpayPayment() {
    setState(() {
      isProcessing = true;
    });

    final orderId = 'ORD${DateTime.now().millisecondsSinceEpoch}';

    _razorpayService.openCheckout(
      amount: widget.totalAmount,
      orderId: orderId,
      name: 'Customer', // Replace with actual user name
      email: 'customer@example.com', // Replace with actual email
      contact: '9999999999', // Replace with actual contact
      onSuccess: (paymentId) {
        setState(() {
          isProcessing = false;
        });
        _createOrder(orderId, paymentId, 'razorpay');
      },
      onError: (error) {
        setState(() {
          isProcessing = false;
        });
        Get.snackbar(
          'Payment Failed',
          error,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      },
    );
  }

  void _processCODOrder() {
    setState(() {
      isProcessing = true;
    });

    final orderId = 'ORD${DateTime.now().millisecondsSinceEpoch}';
    
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isProcessing = false;
      });
      _createOrder(orderId, null, 'cod');
    });
  }

  void _createOrder(String orderId, String? paymentId, String paymentMethod) {
    // Create order items from cart
    final orderItems = cartController.cartItems.map((item) {
      final quantity = cartController.getItemCount(item);
      return OrderItem(
        foodId: item.name, // Use proper ID in production
        name: item.name,
        imageUrl: item.imageUrl,
        quantity: quantity,
        price: item.price,
        totalPrice: item.price * quantity,
      );
    }).toList();

    final order = OrderModel(
      id: orderId,
      userId: 'user123', // Replace with actual user ID
      shopId: 'shop123', // Replace with actual shop ID
      shopName: 'Restaurant Name', // Replace with actual shop name
      items: orderItems,
      subtotal: widget.subtotal,
      deliveryFee: widget.deliveryFee,
      tax: widget.tax,
      discount: widget.discount,
      totalAmount: widget.totalAmount,
      deliveryAddress: widget.deliveryAddress,
      status: OrderStatus.placed,
      paymentMethod: paymentMethod,
      paymentId: paymentId,
      createdAt: DateTime.now(),
      estimatedDeliveryTime: DateTime.now().add(const Duration(minutes: 30)),
    );

    // Add order to controller
    orderController.addOrder(order);

    // Clear cart
    cartController.clearCart();

    // Start order simulation (for testing - remove in production)
    orderSimulation.startSimulation(orderId);

    // Show success message
    Get.snackbar(
      'Order Placed!',
      'Your order has been placed successfully',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );

    // Navigate to tracking screen
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(() => OrderTrackingScreen(orderId: orderId));
    });
  }
}
