import 'package:url_launcher/url_launcher.dart';

class CallService {
  void call(String number) => launch("tel://$number");

}