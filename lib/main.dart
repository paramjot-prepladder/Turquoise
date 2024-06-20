import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/ui/GlobalVariable.dart';
import 'package:testing/ui/chat/chat.dart';
import 'package:testing/ui/selection/selection.dart';
import 'package:testing/utils/color/app_colors.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  // showDummyNoti();
  if (defaultTargetPlatform != TargetPlatform.android) {
    showFlutterNotification(message);
  }
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.notification?.title ?? ""}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'demo', // id
    'demo', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void showDummyNoti() {
  flutterLocalNotificationsPlugin.show(
      12,
      "title",
      "body",
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
        ),
      ));
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
        ),
      ),
    );
  }
}

// class MyApp extends StatefulWidget{
//
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: SharedPreferences.getInstance(),
//         builder: (context, snapshot) => MaterialApp(
//             title: 'TurQuoise',
//             theme: ThemeData(
//               colorScheme:
//                   ColorScheme.fromSeed(seedColor: AppColors.greenPrimary),
//               useMaterial3: true,
//             ),
//             navigatorKey: GlobalVariable.navState,
//             debugShowCheckedModeBanner: false,
//             home: const Selection()
//             // home: snapshot.data?.getString('token') == null
//             //     ? const Selection()
//             //     : snapshot.data!.getString('token')!.toString().isEmpty
//             //         ? const ProductListing()
//             //         : const TabHome(),
//             ));
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _Application();
}

class _Application extends State<MyApp> {
  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data.toString()}');

      if (message.notification != null) {
        print('Message data: ${message.notification?.toString()}');
        print('Message data: ${message.notification?.title}');
        print(
            'Message also contained a notification: ${message.notification?.android?.clickAction}');
      }
    });
  }

  void _handleMessage(RemoteMessage message) {
    var type = message.data["chat_type"];
    var ticket = message.data["ticket_id"];
    if (type == "2") {
      Navigator.of(GlobalVariable.navState.currentContext!).push(
        MaterialPageRoute(builder: (context) => Chat(ticketId: ticket)),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) => MaterialApp(
            title: 'TurQuoise',
            theme: ThemeData(
              colorScheme:
              ColorScheme.fromSeed(seedColor: AppColors.greenPrimary),
              useMaterial3: true,
            ),
            navigatorKey: GlobalVariable.navState,
            debugShowCheckedModeBanner: false,
            home: const Selection()
          // home: snapshot.data?.getString('token') == null
          //     ? const Selection()
          //     : snapshot.data!.getString('token')!.toString().isEmpty
          //         ? const ProductListing()
          //         : const TabHome(),
        ));
  }
}
