import 'package:url_launcher/url_launcher.dart';

abstract class UrlHandler {
  void openUrl(String? url);
}

class UrlLauncher extends UrlHandler {
  @override
  openUrl(String? url) async {
    await launchUrl(
      Uri.parse(url!),
      mode: LaunchMode.externalApplication,
    );
  }
}
