import 'dart:io';
import 'package:demo/core/common/app_button.dart';
import 'package:demo/core/common/common_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareView extends StatelessWidget {
  const ShareView({super.key});

  Future<void> shareAssetImage() async {
    // Load asset as bytes
    final byteData = await rootBundle.load('assets/images/pngs/test.png');

    // Save to temp directory (NO permission needed)
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/share.png');

    await file.writeAsBytes(byteData.buffer.asUint8List());

    // Share image + text
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        text:
            'Hello, this image is shared from my Flutter app https://example.com',
      ),
    );
  }

  Future<void> openSmsApp() async {
    final message = Uri.encodeComponent(
      'Hello this is my invite https://example.com',
    );

    final Uri smsUri =
        Platform.isIOS
            // iOS: MUST use &body=
            ? Uri.parse('sms:&body=$message')
            // Android: use ?body=
            : Uri.parse('sms:?body=$message');

    if (!await launchUrl(smsUri, mode: LaunchMode.platformDefault)) {
      throw 'Could not open Messages app';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: appButton(title: "Share via sms", onPressed: openSmsApp),
      ),
    );
  }
}
