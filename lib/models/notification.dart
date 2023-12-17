import 'package:flutter/cupertino.dart';

class NotificationModel {
  NotificationModel(
      {required this.title,
        required this.description,
        required this.icon,
       });
  String title;
  String description;
  IconData icon;

}
