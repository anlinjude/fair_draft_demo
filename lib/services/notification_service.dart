import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    // Initialize Firebase Messaging
    FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    await _requestNotificationPermission();
    initializeAwesomeNotifications();
  }

  initializeAwesomeNotifications(){
    AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              channelGroupKey: 'basic_channel_group',
              channelKey: 'basic_channel',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: const Color(0xFF9D50DD),
              ledColor: Colors.white)
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ],
    );
  }

  Future<void> _requestNotificationPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      // Add any other permission options you need
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission for notifications.');
    } else {
      print('User declined or has not granted permission for notifications.');
    }
  }

  Future<void> _handleMessage(RemoteMessage message) async {
    // Handle the incoming notification here while the app is in the foreground
    print('Received notification in the foreground: ${message.notification?.title}');
    _showLocalNotification(
      title: message.notification?.title ?? 'Notification',
      body: message.notification?.body ?? 'You have a new notification.',
    );
  }

  Future<void> _handleMessageOpenedApp(RemoteMessage message) async {
    // Handle the notification when the user taps on it and the app is in the background
    print('Notification opened while app was in the background: ${message.notification?.title}');
    // Navigate to a specific screen or update the UI as needed
  }

  Future<void> _showLocalNotification({
    required String title,
    required String body,
  }) async {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: title,
            body: body,
            actionType: ActionType.Default
        )
    );
  }

}






