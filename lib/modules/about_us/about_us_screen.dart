import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

class OthersPage extends StatelessWidget {
  const OthersPage({Key? key}) : super(key: key);

  // replace the email address with your own feedback email address
  final String feedbackEmail = 'anyemail@ay7aga.com'; // المشكله هنا مش بيقرأ اي email يتحط
  final String url = 'https://gmail.com';

  // Check if the device can launch the URL
  Future<bool> canLaunchUrl(String url) async {
    if (await canLaunch(url)) {
      return true;
    } else {
      return false;
    }
  }

  // Launch the URL
  Future<void> launchUrl(String? url) async {
    if (url == null || url.isEmpty) {
      throw 'Invalid URL';
    }

    if (await canLaunchUrl(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      // دي ال method بتاعت ال send اللي بتستعمل ال mail اللي فوق بس مش بيدي exception انه ب Null
      path: feedbackEmail,
      queryParameters: {
        'subject': 'Feedback on Emergency app',
        'body': 'Please share your feedback and suggestions with us, we would love it!',
      },
    );

    final String emailLaunchUrl = emailLaunchUri.toString();

    if (await canLaunchUrl(emailLaunchUrl)) {
      await launchUrl(emailLaunchUrl);
    } else {
      throw 'Could not launch $emailLaunchUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Others page'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Do you have feedback?',
              style: TextStyle(),),
            SizedBox(height: 16.0),
            FloatingActionButton(
              onPressed: _sendEmail,
              child: Icon(Icons.feedback),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}