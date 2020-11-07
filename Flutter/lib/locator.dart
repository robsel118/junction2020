import 'package:get_it/get_it.dart';
import 'package:junction2020/services/push-notification-sevices.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => PushNotificationService());
}
