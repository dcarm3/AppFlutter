import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    var androidInitSettings = AndroidInitializationSettings('app_icon');
    var initSettings = InitializationSettings(android: androidInitSettings);

    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  Future<void> scheduleNotification(DateTime scheduledDate) async {
    var androidDetails = AndroidNotificationDetails('channelId', 'channelName',
        importance: Importance.max);
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.schedule(
      0, // id único para a notificação
      'Tarefa Programada',
      'É hora de realizar a tarefa!',
      scheduledDate,
      generalNotificationDetails,
    );
  }
}
