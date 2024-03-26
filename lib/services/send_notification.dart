import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class NotificationService {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

 void isRefreshToken() async {
    messaging.onTokenRefresh.listen((String? newToken) {
      print('Token Refreshed: $newToken');
      // You may want to update your backend database with the new token here
    });
  }
  // String apiKey = "OTMzMjgzOWItNTY0Yi00ZTM4LWI2N2ItOTdiOWZmMTcxZDNj";
  String url = "https://api.onesignal.com/notifications";

  sendNotification(String title, String description) async {
    print("Send notification is called");
    try {
      Map<String, String> headers = {
        // 'Authorization': 'Basic $apiKey', for the only subscribes users  like to send the targeted device the auth api key doesnot required
        'accept': "application/json",
        'Content-Type': 'application/json',
       
      };

      Map<String, dynamic> body = {
       "app_id": "66087130-0c75-4c54-8daa-afbde9dff111",
  "include_subscription_ids": ["fcaacfb8-41ba-4012-b89c-d5c910ff205f"], 
  "contents": {"en": "You have a new order", }, 
  'headings': {"en": "Baisnab", }, 
  'ios_attachments': {"id1": "your_image_url", "subtitle": "Your optional subtitle"},
  'big_picture': 'https://firebasestorage.googleapis.com/v0/b/foodappsforproject.appspot.com/o/images%2Fbaisnab.jpg?alt=media&token=5472cc55-e8d8-49d8-918c-5f11c2f802db',
       
      };
      var response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(body));

      print(response.statusCode);
      print(response.body);

      // print(response.body);

      if (response.statusCode == 200) {
        print("Sent successfully");
        print(response.body);
      }
    } catch (e) {
      print("Unable to send notification because of $e");
    }
  }
}