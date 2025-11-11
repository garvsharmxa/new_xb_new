import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../Controller/OrderController.dart';
import '../../models/Order/OrderModel.dart';
import '../../Nav/BottomNav.dart';
import '../../Services/Order/OrderSimulationService.dart';

class OrderTrackingScreen extends StatefulWidget {
  final String orderId;

  const OrderTrackingScreen({
    super.key,
    required this.orderId,
  });

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  final orderController = Get.find<OrderController>();
  final orderSimulation = OrderSimulationService();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => BottomNavBar());
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF8FAFC),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xff2D3748),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.offAll(() => BottomNavBar());
            },
          ),
          title: Text(
            'Track Order',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xff2D3748),
            ),
          ),
        ),
        body: GetBuilder<OrderController>(
          builder: (controller) {
            final order = controller.getOrderById(widget.orderId);

            if (order == null) {
              return _buildErrorState();
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _buildOrderHeader(order),
                  const SizedBox(height: 16),
                  _buildTrackingProgress(order),
                  const SizedBox(height: 16),
                  _buildOrderDetails(order),
                  const SizedBox(height: 16),
                  _buildOrderItems(order),
                  const SizedBox(height: 16),
                  _buildPriceBreakdown(order),
                  const SizedBox(height: 16),
                  _buildActionButtons(order),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Color(0xffC2262D),
          ),
          const SizedBox(height: 16),
          Text(
            'Order not found',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xff2D3748),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Get.offAll(() => BottomNavBar()),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffC2262D),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Go to Home',
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

  Widget _buildOrderHeader(OrderModel order) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xffC2262D), Color(0xffA01E24)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffC2262D).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ID',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '#${order.id.substring(order.id.length - 8)}',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order.status.displayName,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  order.estimatedDeliveryTime != null
                      ? 'Ready by ${DateFormat('hh:mm a').format(order.estimatedDeliveryTime!)}'
                      : 'Estimated time: 25-30 mins',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingProgress(OrderModel order) {
    final statuses = [
      OrderStatus.placed,
      OrderStatus.confirmed,
      OrderStatus.preparing,
      OrderStatus.ready,
      OrderStatus.completed,
    ];

    final currentIndex = statuses.indexOf(order.status);

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
          Text(
            'Order Status',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xff2D3748),
            ),
          ),
          const SizedBox(height: 24),
          ...List.generate(statuses.length, (index) {
            final status = statuses[index];
            final isCompleted = index <= currentIndex;
            final isLast = index == statuses.length - 1;

            return _buildStatusStep(
              status.displayName,
              status.description,
              isCompleted,
              !isLast,
              index == currentIndex,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildStatusStep(
    String title,
    String subtitle,
    bool isCompleted,
    bool showLine,
    bool isCurrent,
  ) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? const Color(0xffC2262D)
                        : Colors.grey.shade300,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isCurrent
                          ? const Color(0xffC2262D)
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      isCompleted ? Icons.check : Icons.circle,
                      color: Colors.white,
                      size: isCompleted ? 18 : 10,
                    ),
                  ),
                ),
                if (showLine)
                  Container(
                    width: 2,
                    height: 40,
                    color: isCompleted
                        ? const Color(0xffC2262D)
                        : Colors.grey.shade300,
                  ),
              ],
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
                      color: isCompleted
                          ? const Color(0xff2D3748)
                          : Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  if (showLine) const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderDetails(OrderModel order) {
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
                Icons.store,
                color: Color(0xffC2262D),
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                'Shop Details',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff2D3748),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildDetailRow('Shop Name', order.shopName),
          const SizedBox(height: 12),
          _buildDetailRow('Delivery Address', order.deliveryAddress),
          const SizedBox(height: 12),
          _buildDetailRow(
            'Order Time',
            DateFormat('dd MMM yyyy, hh:mm a').format(order.createdAt),
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            'Payment Method',
            order.paymentMethod == 'razorpay' ? 'Online Payment' : 'Cash on Delivery',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xff2D3748),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItems(OrderModel order) {
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
                size: 18,
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
          const SizedBox(height: 16),
          ...order.items.map((item) => _buildOrderItem(item)),
        ],
      ),
    );
  }

  Widget _buildOrderItem(OrderItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 50,
                height: 50,
                color: Colors.grey.shade300,
                child: const Icon(Icons.image_not_supported),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff2D3748),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Qty: ${item.quantity}',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '₹${item.totalPrice.toStringAsFixed(0)}',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xffC2262D),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceBreakdown(OrderModel order) {
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
          const SizedBox(height: 16),
          _buildPriceRow('Subtotal', order.subtotal),
          _buildPriceRow('Delivery Fee', order.deliveryFee),
          _buildPriceRow('Tax', order.tax),
          if (order.discount > 0)
            _buildPriceRow('Discount', -order.discount, isDiscount: true),
          const Divider(height: 24, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Paid',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff2D3748),
                ),
              ),
              Text(
                '₹${order.totalAmount.toStringAsFixed(0)}',
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

  Widget _buildPriceRow(String label, double amount, {bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            '${isDiscount ? '-' : ''}₹${amount.abs().toStringAsFixed(0)}',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isDiscount ? Colors.green : const Color(0xff2D3748),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(OrderModel order) {
    final canAdvance = order.status != OrderStatus.completed && 
                      order.status != OrderStatus.cancelled;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Test button to advance order status (for demo purposes)
          if (canAdvance)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  orderSimulation.advanceOrderStatus(order.id);
                },
                icon: const Icon(Icons.fast_forward),
                label: Text(
                  'Advance Status (Test)',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.orange,
                  side: const BorderSide(color: Colors.orange),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Implement help/support
                    Get.snackbar(
                      'Support',
                      'Contact support at: +91 1234567890',
                      backgroundColor: Colors.blue,
                      colorText: Colors.white,
                    );
                  },
                  icon: const Icon(Icons.help_outline),
                  label: Text(
                    'Need Help?',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xffC2262D),
                    side: const BorderSide(color: Color(0xffC2262D)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.offAll(() => BottomNavBar());
                  },
                  icon: const Icon(Icons.home),
                  label: Text(
                    'Go Home',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffC2262D),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
