import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
//import 'package:flutter_push_notifications/utils/download_util.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest_all.dart' as tzData;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  // NotificationService();
  // final StreamController<String?> selectNotificationStream =
  // StreamController<String?>.broadcast();
  //
   final _localNotifications = FlutterLocalNotificationsPlugin();
  // final BehaviorSubject<String> behaviorSubject = BehaviorSubject();

  Future<void> initializePlatformNotifications() async {

    const initializationSettingsAndroid = AndroidInitializationSettings('ipet_icon');

    // final IOSInitializationSettings initializationSettingsIOS =
    // IOSInitializationSettings(
    //     requestSoundPermission: true,
    //     requestBadgePermission: true,
    //     requestAlertPermission: true,
    //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      //iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(initializationSettings).then((_) {
      debugPrint('setupPlugin: setup success');
    }).catchError((Object error) {
      debugPrint('Error: $error');
    });
  }
      //onDidReceiveBackgroundNotificationResponse: notificationTapBackground,

  // void onDidReceiveLocalNotification(
  //     int id, String? title, String? body, String? payload) {
  //   print('id $id');
  // }
  //
  // void selectNotification(String? payload) {
  //   if (payload != null && payload.isNotEmpty) {
  //     behaviorSubject.add(payload);
  //   }
  // }
   void addNotification(
       String title,
       String body,
       int endTime, {
         String sound = '',
         String channel = 'default',
       }) async {
     tzData.initializeTimeZones();

     final scheduleTime =
     tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, endTime);

     // #3
     // final iosDetail = sound == ''
     //     ? null
     //     : IOSNotificationDetails(presentSound: true, sound: sound);

     final soundFile = sound.replaceAll('.mp3', '');
     final notificationSound =
     sound == '' ? null : RawResourceAndroidNotificationSound(soundFile);

     final androidDetail = AndroidNotificationDetails(
         channel, // channel Id
         channel, // channel Name
         playSound: true,
         sound: notificationSound);

     final noticeDetail = NotificationDetails(
       //iOS: iosDetail,
       android: androidDetail,
     );

     // #4
     const id = 0;

     await _localNotifications.zonedSchedule(
       id,
       title,
       body,
       scheduleTime,
       noticeDetail,
       uiLocalNotificationDateInterpretation:
       UILocalNotificationDateInterpretation.absoluteTime,
       androidAllowWhileIdle: true,
     );
   }
}
