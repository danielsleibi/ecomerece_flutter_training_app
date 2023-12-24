import 'package:ecommerce_task/controllers/db/offline/cache_keys.dart';
import 'package:ecommerce_task/controllers/db/offline/shared_helper.dart';
import 'package:ecommerce_task/controllers/db/online/dio_helper.dart';
import 'package:ecommerce_task/models/notification.dart';
import 'package:ecommerce_task/models/notifications_model.dart';
import 'package:ecommerce_task/pages/base_loggedin_page.dart';
import 'package:ecommerce_task/widgets/ecommerce_textfield.dart';
import 'package:ecommerce_task/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedHelper.initSharedPreferences();
  DioHelper.initDipHelper();

  NotificationsModel notificationsModel = NotificationsModel.instance;

  notificationsModel.addNotification(NotificationModel(
      title: 'Payment Confirmed',
      description:
          'Payment for order 1345627345126 has been Confirmed. Please wait for the product to be sent.',
      icon: Icons.credit_card_outlined));

  notificationsModel.addNotification(NotificationModel(
      title: 'Order Success',
      description:
          'Order 1345627345126 has been Success. Please wait for the product to be sent.',
      icon: Icons.fact_check));

  notificationsModel.addNotification(NotificationModel(
      title: 'Order Arrived',
      description:
          'Order 1345627345126 has been completed & arrived at the destination address',
      icon: Icons.check));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  bool isLoggedIn =
      SharedHelper.prefs.getString(CacheKeys.isLoggedIn.toString()) == 'true';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
          isLoggedIn ? const BaseLoggedInPage() : const LoginPage(title: 'we'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            EcommerceButton(title: 'Name', hint: 'Please enter your name'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
