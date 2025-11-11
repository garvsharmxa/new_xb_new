import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../Controller/CartController.dart';
import '../../../../../models/foodItems.dart';
import '../Payment/PaymentScreen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController couponController = TextEditingController();
  bool isCouponApplied = false;
  double couponDiscount = 0.0;
  String selectedAddress = "Home";

  final List<Map<String, dynamic>> addresses = [
    {
      'type': 'Home',
      'address': '123 Main Street, Downtown',
      'icon': Icons.home,
      'time': '25-30 min',
    },
    {
      'type': 'Work',
      'address': '456 Business Plaza, CBD',
      'icon': Icons.work,
      'time': '20-25 min',
    },
    {
      'type': 'Other',
      'address': '789 Park Avenue, Uptown',
      'icon': Icons.location_on,
      'time': '30-35 min',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xff2D3748),
        title: Text(
          'Your Cart',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xff2D3748),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            onPressed: () {
              _showClearCartDialog(cartController);
            },
          ),
        ],
      ),
      body: Obx(() {
        final cartItems = cartController.cartItems;

        if (cartItems.isEmpty) {
          return _buildEmptyCart();
        }

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    _buildDeliveryAddress(),
                    _buildCartItems(cartController),
                    _buildCouponSection(),
                    _buildBillDetails(cartController),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            _buildCheckoutButton(cartController),
          ],
        );
      }),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: const Color(0xffC2262D).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              FontAwesomeIcons.shoppingCart,
              size: 60,
              color: Color(0xffC2262D),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Your cart is empty!',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: const Color(0xff2D3748),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add some delicious items to get started',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: const Color(0xff718096),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffC2262D),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Start Shopping',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryAddress() {
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
              const Icon(Icons.location_on, color: Color(0xffC2262D), size: 24),
              const SizedBox(width: 12),
              Text(
                'Delivery Address',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff2D3748),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...addresses.map((addr) => _buildAddressOption(addr)),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              // Add new address logic
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xffC2262D).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Color(0xffC2262D),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Add New Address',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffC2262D),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressOption(Map<String, dynamic> address) {
    final isSelected = selectedAddress == address['type'];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAddress = address['type'];
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
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
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xffC2262D)
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                address['icon'],
                color: isSelected ? Colors.white : Colors.grey.shade600,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address['type'],
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff2D3748),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address['address'],
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xff718096),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
                const SizedBox(height: 4),
                Text(
                  address['time'],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItems(CartController cartController) {
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
                FontAwesomeIcons.shoppingBag,
                color: Color(0xffC2262D),
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                'Order Items',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff2D3748),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...cartController.cartItems
              .map((item) => _buildCartItem(item, cartController))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildCartItem(FoodItem item, CartController cartController) {
    final itemCount = cartController.getItemCount(item);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.image_not_supported),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff2D3748),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '₹${item.price.toStringAsFixed(0)}',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffC2262D),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildQuantityButton(
                      icon: Icons.remove,
                      onTap: () => cartController.removeFromCart(item),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        '$itemCount',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff2D3748),
                        ),
                      ),
                    ),
                    _buildQuantityButton(
                      icon: Icons.add,
                      onTap: () => cartController.addToCart(item),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xffC2262D),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: const Color(0xffC2262D).withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  Widget _buildCouponSection() {
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
                FontAwesomeIcons.ticket,
                color: Color(0xffC2262D),
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                'Apply Coupon',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff2D3748),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: couponController,
                  decoration: InputDecoration(
                    hintText: 'Enter coupon code',
                    hintStyle: GoogleFonts.poppins(color: Colors.grey.shade500),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xffC2262D)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: _applyCoupon,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffC2262D),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Apply',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          if (isCouponApplied) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Coupon applied! You saved ₹${couponDiscount.toStringAsFixed(0)}',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBillDetails(CartController cartController) {
    final subtotal = cartController.totalPrice;
    final deliveryFee = 40.0;
    final taxAmount = subtotal * 0.18; // 18% tax
    final total = subtotal + deliveryFee + taxAmount - couponDiscount;

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
                Icons.receipt_outlined,
                color: Color(0xffC2262D),
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                'Bill Details',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff2D3748),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildBillRow('Subtotal', '₹${subtotal.toStringAsFixed(0)}'),
          _buildBillRow('Delivery Fee', '₹${deliveryFee.toStringAsFixed(0)}'),
          _buildBillRow('Tax (18%)', '₹${taxAmount.toStringAsFixed(0)}'),
          if (isCouponApplied)
            _buildBillRow(
              'Discount',
              '-₹${couponDiscount.toStringAsFixed(0)}',
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
                '₹${total.toStringAsFixed(0)}',
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

  Widget _buildBillRow(String label, String amount, {bool isDiscount = false}) {
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

  Widget _buildCheckoutButton(CartController cartController) {
    final subtotal = cartController.totalPrice;
    final deliveryFee = 40.0;
    final taxAmount = subtotal * 0.18;
    final total = subtotal + deliveryFee + taxAmount - couponDiscount;

    return Container(
      height: 70,

      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Price Section
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: Text(
                '₹${total.toStringAsFixed(0)}',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // Proceed to Pay Button
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                _proceedToCheckout(total);
              },
              child: Container(
                alignment: Alignment.center,
                color: const Color(0xffC2262D),
                child: Text(
                  'PROCEED TO PAY',
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

  void _applyCoupon() {
    final couponCode = couponController.text.trim().toUpperCase();

    if (couponCode.isEmpty) {
      Get.snackbar('Error', 'Please enter a coupon code');
      return;
    }

    // Simple coupon validation
    if (couponCode == 'SAVE10') {
      setState(() {
        isCouponApplied = true;
        couponDiscount = 50.0;
      });
      Get.snackbar(
        'Success',
        'Coupon applied successfully!',
        backgroundColor: Colors.green,
      );
    } else if (couponCode == 'FIRSTORDER') {
      setState(() {
        isCouponApplied = true;
        couponDiscount = 100.0;
      });
      Get.snackbar(
        'Success',
        'Welcome discount applied!',
        backgroundColor: Colors.green,
      );
    } else {
      Get.snackbar('Error', 'Invalid coupon code');
    }
  }

  void _showClearCartDialog(CartController cartController) {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Clear Cart',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Are you sure you want to clear all items from your cart?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              cartController.clearCart();
              Get.back();
            },
            child: Text(
              'Clear',
              style: GoogleFonts.poppins(color: const Color(0xffC2262D)),
            ),
          ),
        ],
      ),
    );
  }

  void _proceedToCheckout(double total) {
    // Navigate to payment screen
    Get.to(() => PaymentScreen(
      totalAmount: total,
      subtotal: cartController.totalPrice,
      deliveryFee: 40.0,
      tax: cartController.totalPrice * 0.18,
      discount: couponDiscount,
      deliveryAddress: addresses.firstWhere(
        (addr) => addr['type'] == selectedAddress,
        orElse: () => {'address': 'No address selected'},
      )['address'],
    ));
  }

  @override
  void dispose() {
    couponController.dispose();
    super.dispose();
  }
}
