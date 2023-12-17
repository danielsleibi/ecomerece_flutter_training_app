import 'package:ecommerce_task/models/notification.dart';
import 'package:ecommerce_task/models/notifications_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  Widget _buildPromotionWidget(String image, String text, String time) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Container(
        // height: 100.0,
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 1, // Spread radius
              blurRadius: 7, // Blur radius
              offset: Offset(0, 3), // Offset
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                  image: NetworkImage(
                    image,
                  ),
                  fit: BoxFit.cover,
                )),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.0),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      time,
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromotionsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        children: [
          _buildPromotionWidget(
              'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWFjYm9vayUyMHByb3xlbnwwfHwwfHx8MA%3D%3D',
              'Cool laptop, limited!, %50 discount ....',
              '10:00 AM'),
          _buildPromotionWidget(
              'https://images.unsplash.com/photo-1585386959984-a4155224a1ad?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzJ8fHByb2R1Y3RzfGVufDB8fDB8fHww',
              'Smell good, cheap price only 5 left',
              '1 day ago')
        ],
      ),
    );
  }

  Widget _buildNotificationWidget(NotificationModel notification) {
    return Container(
      // height: 100.0,
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 1, // Spread radius
            blurRadius: 7, // Blur radius
            offset: Offset(0, 3), // Offset
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              child: Icon(
                notification.icon,
                color: Colors.purple,
              ),
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Color.fromRGBO(233, 230, 235, 1.0),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    notification.description,
                    softWrap: true,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsSection(BuildContext context) {
    NotificationsModel notificationsModel = NotificationsModel.instance;
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
              bottom: 8.0, top: 8.0, left: 16.0, right: 16.0),
          child: _buildNotificationWidget(notificationsModel.getNotifications()[
              notificationsModel.getNotifications().length - index - 1]),
        );
      },
      itemCount: notificationsModel.getNotifications().length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Promotions',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
              ),
              _buildPromotionsSection(context),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Your Activity',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
              ),
              _buildNotificationsSection(context),
            ],
          ),
        ),
      ),
    );
  }
}
