import 'dart:async';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
}

// to ensure this executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
void onIosBackground() {
  WidgetsFlutterBinding.ensureInitialized();
  print('FLUTTER BACKGROUND FETCH');
}

void onStart() {
  WidgetsFlutterBinding.ensureInitialized();
  final service = FlutterBackgroundService();
  Timer timer;
  service.onDataReceived.listen((event) {
    if (event["action"] == "tick") {
      service.setForegroundMode(true);
      timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (!(await service.isServiceRunning())) timer.cancel();
        service.sendData(
          {
            "tick": timer.tick,
          },
        );
      });
      return;
    }
    if (event["action"] == "stop") {
      service.setForegroundMode(true);
      service.sendData(
        {
          "stop": timer.tick,
        },
      );
      timer.cancel();
      print("timer has stopped");
      return;
    }
  });
  service.setForegroundMode(true);
}

/// Background fetch configuration
Future<void> backgroundFetch() async {
  await BackgroundFetch.configure(
    BackgroundFetchConfig(
      minimumFetchInterval: 5,
      forceAlarmManager: false,
      stopOnTerminate: false,
      startOnBoot: true,
      enableHeadless: true,
      requiresBatteryNotLow: false,
      requiresCharging: false,
      requiresStorageNotLow: false,
      requiresDeviceIdle: false,
      requiredNetworkType: NetworkType.NONE,
    ),
    _onFetch,
    _onBackgroundFetchTimeout,
  );

  await BackgroundFetch.scheduleTask(TaskConfig(
    delay: 1000,
    enableHeadless: true,
    periodic: true,
    stopOnTerminate: false,
    taskId: "tick",
  ));
}

///
_onFetch(String taskId) {
  print("Received On Fetch Task with the id - $taskId");
}

///
void _onBackgroundFetchTimeout(String taskId) {}

///
headlessBackgroundTask(HeadlessTask task) {
  if (task.taskId == 'tick') {
    print("A tick event received");
  }
}
