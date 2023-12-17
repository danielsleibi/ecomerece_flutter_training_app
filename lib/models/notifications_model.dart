import 'package:ecommerce_task/models/notification.dart';

class NotificationsModel {
  // Private constructor
  NotificationsModel._() {
    _notifications = [];
  }

  // Static instance of the class
  static final NotificationsModel _instance = NotificationsModel._();

  // Getter to access the instance
  static NotificationsModel get instance => _instance;

  late List<NotificationModel> _notifications;

  void addNotification(NotificationModel notification) {
    _notifications.add(notification);
  }

  void removeFromCart(NotificationModel notification) {
    _notifications.remove(notification);
  }


  void clearNotifications() {
    _notifications.clear();
  }

  List<NotificationModel> getNotifications() {
    return _notifications;
  }
}
