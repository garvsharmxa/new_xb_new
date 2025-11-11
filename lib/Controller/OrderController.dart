import 'package:get/get.dart';
import '../models/Order/OrderModel.dart';

class OrderController extends GetxController {
  final RxList<OrderModel> _orders = <OrderModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  List<OrderModel> get orders => _orders;
  List<OrderModel> get activeOrders => _orders
      .where((order) =>
          order.status != OrderStatus.completed &&
          order.status != OrderStatus.cancelled)
      .toList();
  List<OrderModel> get pastOrders => _orders
      .where((order) =>
          order.status == OrderStatus.completed ||
          order.status == OrderStatus.cancelled)
      .toList();

  void addOrder(OrderModel order) {
    _orders.insert(0, order);
    update();
  }

  void updateOrderStatus(String orderId, OrderStatus status) {
    final index = _orders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      final order = _orders[index];
      final updatedOrder = OrderModel(
        id: order.id,
        userId: order.userId,
        shopId: order.shopId,
        shopName: order.shopName,
        items: order.items,
        subtotal: order.subtotal,
        deliveryFee: order.deliveryFee,
        tax: order.tax,
        discount: order.discount,
        totalAmount: order.totalAmount,
        deliveryAddress: order.deliveryAddress,
        status: status,
        paymentMethod: order.paymentMethod,
        paymentId: order.paymentId,
        createdAt: order.createdAt,
        estimatedDeliveryTime: order.estimatedDeliveryTime,
        specialInstructions: order.specialInstructions,
      );
      _orders[index] = updatedOrder;
      update();
    }
  }

  OrderModel? getOrderById(String orderId) {
    try {
      return _orders.firstWhere((order) => order.id == orderId);
    } catch (e) {
      return null;
    }
  }

  void clearOrders() {
    _orders.clear();
    update();
  }

  Future<void> loadOrders() async {
    try {
      isLoading.value = true;
      error.value = '';
      // TODO: Fetch orders from API
      // For now, orders are managed locally
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      error.value = 'Failed to load orders';
      print('Error loading orders: $e');
    }
  }
}
