import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

DateTime scheduleTime = DateTime.now();
class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/baisnab');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int uid, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max,
    priority: Priority.high,),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int uid = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        uid, title, body, await notificationDetails());
  }

  // Future scheduleNotification(
  //     {int uid = 0,
  //     String? title,
  //     String? body,
  //     String? payLoad,
  //     required DateTime scheduledNotificationDateTime}) async {
    // return notificationsPlugin.zonedSchedule(
        // uid,
        // title,
        // body,
        // tz.TZDateTime.from( 
        //   scheduledNotificationDateTime,
        //   tz.local,
        // ),
        // await notificationDetails(),
        // androidAllowWhileIdle: true,
        // uiLocalNotificationDateInterpretation:
        //     UILocalNotificationDateInterpretation.absoluteTime);
  }
