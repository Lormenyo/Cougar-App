import 'package:get_it/get_it.dart';
import 'call_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(CallService());
}