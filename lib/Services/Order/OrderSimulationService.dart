import 'dart:async';
import 'package:get/get.dart';
import '../../Controller/OrderController.dart';
import '../../models/Order/OrderModel.dart';
import '../Notification/NotificationService.dart';

/// Service to simulate order status changes for testing
/// In production, this would be replaced with real-time updates from backend
class OrderSimulationService {
  static final OrderSimulationService _instance = OrderSimulationService._internal();
  factory OrderSimulationService() => _instance;
  OrderSimulationService._internal();

  final Map<String, Timer> _activeSimulations = {};
  final orderController = Get.find<OrderController>();
  final notificationService = NotificationService();

  /// Start simulating order status changes for a given order
  void startSimulation(String orderId) {
    // Cancel any existing simulation for this order
    stopSimulation(orderId);

    int step = 0;
    final timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      step++;
      
      final order = orderController.getOrderById(orderId);
      if (order == null) {
        timer.cancel();
        return;
      }

      OrderStatus? nextStatus;
      
      switch (order.status) {
        case OrderStatus.placed:
          nextStatus = OrderStatus.confirmed;
          notificationService.showOrderConfirmedNotification(orderId);
          break;
        case OrderStatus.confirmed:
          nextStatus = OrderStatus.preparing;
          notificationService.showOrderPreparingNotification(orderId);
          break;
        case OrderStatus.preparing:
          nextStatus = OrderStatus.ready;
          notificationService.showOrderReadyNotification(orderId);
          break;
        case OrderStatus.ready:
          nextStatus = OrderStatus.completed;
          notificationService.showOrderCompletedNotification(orderId);
          timer.cancel();
          _activeSimulations.remove(orderId);
          break;
        case OrderStatus.completed:
        case OrderStatus.cancelled:
          timer.cancel();
          _activeSimulations.remove(orderId);
          return;
      }

      if (nextStatus != null) {
        orderController.updateOrderStatus(orderId, nextStatus);
      }
    });

    _activeSimulations[orderId] = timer;
  }

  /// Stop simulating order status changes for a given order
  void stopSimulation(String orderId) {
    final timer = _activeSimulations[orderId];
    if (timer != null) {
      timer.cancel();
      _activeSimulations.remove(orderId);
    }
  }

  /// Stop all active simulations
  void stopAllSimulations() {
    for (final timer in _activeSimulations.values) {
      timer.cancel();
    }
    _activeSimulations.clear();
  }

  /// Manually advance order status (for testing)
  void advanceOrderStatus(String orderId) {
    final order = orderController.getOrderById(orderId);
    if (order == null) return;

    OrderStatus? nextStatus;
    
    switch (order.status) {
      case OrderStatus.placed:
        nextStatus = OrderStatus.confirmed;
        notificationService.showOrderConfirmedNotification(orderId);
        break;
      case OrderStatus.confirmed:
        nextStatus = OrderStatus.preparing;
        notificationService.showOrderPreparingNotification(orderId);
        break;
      case OrderStatus.preparing:
        nextStatus = OrderStatus.ready;
        notificationService.showOrderReadyNotification(orderId);
        break;
      case OrderStatus.ready:
        nextStatus = OrderStatus.completed;
        notificationService.showOrderCompletedNotification(orderId);
        break;
      case OrderStatus.completed:
      case OrderStatus.cancelled:
        return;
    }

    if (nextStatus != null) {
      orderController.updateOrderStatus(orderId, nextStatus);
    }
  }
}
